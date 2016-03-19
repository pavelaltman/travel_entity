<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelPointPostPhotos extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'photo_article_point', 'photo_article_point',
				'photo_id', 'photo_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $article_point = $this->getUserStateFromRequest('com_travelentity.pointpostphotos.filter.article_point', 'filter_article_point');
   $this->setState('filter.article_point', $article_point);

   // List state information.
   parent::populateState('photo_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.article_point');
   return parent::getStoreId($id);
  }
 

  protected function getListQuery()
  {
    $article_point=JRequest::getInt('article_point_id') ;
    if ($article_point)
    {
     $this->setState('filter.article_point', $article_point);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.pointpostphotos.filter.article_point',$article_point);
    }

    // Create a new query object.
    $db = JFactory::getDBO();
    $p_query = new TEQuery($db) ;
    $p_query->select("post_article_point_id AS value, concat(point_name,' - ',c.title) AS text") ;
    $p_query->from('#__te_points_posts, #__te_points, #__content as c') ;
    $p_query->where('post_point=point_id AND post_article=c.id') ;
    $db->setQuery($p_query);
    $this->aux_arrays['pointpostlist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('photo_id,photo_name,photo_path');
    $query->from('#__te_photos');
   
    if ($article_point = $this->getState('filter.article_point')) 
      $query->where('photo_article_point= '.$article_point);

    return $query;
  }
}
?>