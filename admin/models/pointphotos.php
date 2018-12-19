<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelPointPhotos extends JModelList
{
  public function __construct($config = array())
  {
  
    if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'photo_point', 'photo_point',
				'photo_id', 'photo_id',
			);
   }
 
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $point = $this->getUserStateFromRequest('com_travelentity.pointphotos.filter.point', 'filter_point');
   $this->setState('filter.point', $point);

   // List state information.
   parent::populateState('photo_id', 'asc');
  }

 
   protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.point');
   return parent::getStoreId($id);
  }
 

  protected function getListQuery()
  {
    $point=JRequest::getInt('point_id') ;
    if ($point==-1)
    {
        $this->setState('filter.point', 0);
        
        $app = JFactory::getApplication();
        $app->setUserState('com_travelentity.pointphotos.filter.point',0);
    }
    elseif ($point)
    {
        $this->setState('filter.point', $point);
        
        $app = JFactory::getApplication();
        $app->setUserState('com_travelentity.pointphotos.filter.point',$point);
    }
    
    // Create a new query object.
    // $db = JFactory::getDBO();
    // $p_query = new TEQuery($db) ;
    // $p_query->select("point_id AS value, point_name AS text") ;
    // $p_query->from('#__te_points') ;
    // $p_query->where('point_id='.$point) ;
    // $db->setQuery($p_query);
    // $this->aux_arrays['pointlist'] = $db->loadObjectList();

    $query = new TEQuery($db) ;
    $query->select('p.*');
    $query->from('#__te_photos p');
    
    $query->select('trip_name'); $query->join('LEFT', '#__te_trips ON trip_id = photo_trip');
    $query->select('point_name'); $query->join('LEFT', '#__te_points ON point_id = photo_point');
    $query->join('LEFT', '#__te_points_posts ON post_article_point_id = photo_post');
    $query->select('m.title as menutitle'); $query->join('LEFT', '#__menu AS m ON m.id = post_menuitem');
    $query->select('c.title as articletitle'); $query->join('LEFT', '#__content AS c ON c.id = post_article');
    
   
    if ($point = $this->getState('filter.point')) 
      $query->where('photo_point= '.$point);
     
    return $query;
  }
}
?>