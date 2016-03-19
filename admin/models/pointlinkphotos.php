<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelPointLinkPhotos extends JModelList
{
  protected $point_id ;

  function SetPointId($id) { $this->point_id=$id; }

  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'point_id', 'point_id',
				'points_link_photo_id', 'point_link_photo_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $temp_point_id = $this->getUserStateFromRequest('com_travelentity.pointlinkphotos.filter.point_id', 'filter_point_id');
   $this->SetPointId($temp_point_id) ;
   $this->setState('filter.point_id', $this->point_id);

   // List state information.
   parent::populateState('point_link_photo_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.point_id');
   return parent::getStoreId($id);
  }
 

  protected function getListQuery()
  {
    $temp_point_id=JRequest::getInt('point_id') ;
    if ($temp_point_id)
    {
     $this->SetPointId($temp_point_id) ;
     $this->setState('filter.point_id', $this->point_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.pointlinkphotos.filter.point_id',$this->point_id);
    }

    // Create a new query object.
    $db = JFactory::getDBO();
    $p_query = new TEQuery($db) ;
    $p_query->select('point_id AS value, point_name AS text') ;
    $p_query->from('#__te_points');
    $db->setQuery($p_query);
    $this->aux_arrays['pointlist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('point_link_photo_id,link_type,point_id,link_photo_path');
    $query->from('#__te_points_link_photos');
   
    if ($this->point_id = $this->getState('filter.point_id')) 
      $query->where('point_id= '.$this->point_id);

    $query->select('lt.link_type_pre_label AS pre_label,lt.link_type_link_label AS link_label,lt.link_type_post_label AS post_label');
    $query->join('LEFT', '#__te_points_link_types AS lt ON lt.link_type_id = link_type');

    $query->select('lc.link_class_pre_label AS class_pre_label,lc.link_class_link_label AS class_link_label,lc.link_class_post_label AS class_post_label');
    $query->join('LEFT', '#__te_points_link_classes AS lc ON lc.link_class_id = lt.link_type_class');

    return $query;
  }
}
?>