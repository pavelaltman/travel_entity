<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelPointsPosts extends JModelList
{
  protected $point_id ;

  function SetPointId($id) { $this->point_id=$id; }

  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'post_point', 'post_point',
				'post_article_point_id', 'post_article_point_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $temp_point_id = $this->getUserStateFromRequest('com_travelentity.pointsposts.filter.post_point', 'filter_post_point');
   $this->SetPointId($temp_point_id) ;
   $this->setState('filter.post_point', $this->point_id);

   // List state information.
   parent::populateState('post_article_point_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.post_point');
   return parent::getStoreId($id);
  }
 

  protected function getListQuery()
  {
    $temp_point_id=JRequest::getInt('point_id') ;
    if ($temp_point_id)
    {
     $this->SetPointId($temp_point_id) ;
     $this->setState('filter.post_point', $this->point_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.pointsposts.filter.post_point',$this->point_id);
    }

    // Create a new query object.
    $db = JFactory::getDBO();
    $p_query = new TEQuery($db) ;
    $p_query->select("SELECT point_id AS value, point_name AS text") ;
    $p_query->from("#__te_points") ;
    $db->setQuery($p_query);
    $this->aux_arrays['pointlist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('post_article_point_id,post_point,post_article,post_menuitem');
    $query->from('#__te_points_posts');
   
    if ($this->point_id = $this->getState('filter.post_point')) 
      $query->where('post_point= '.$this->point_id);

    $query->select('m.title as menutitle');
    $query->join('LEFT', '#__menu AS m ON m.id = post_menuitem');

    $query->select('c.title as articletitle');
    $query->join('LEFT', '#__content AS c ON c.id = post_article');

    return $query;
  }
}
?>