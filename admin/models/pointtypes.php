<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelPointTypes extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'point_class', 'point_class',
				'point_type_id', 'point_type_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $point_class_id = $this->getUserStateFromRequest('com_travelentity.pointtypes.filter.point_class', 'filter_point_class');
   $this->setState('filter.point_class', $point_class_id);

   // List state information.
   parent::populateState('point_type_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.point_class');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $point_class_id=JRequest::getInt('point_class_id') ;
    if ($point_class_id)
    {
     $this->setState('filter.point_class', $point_class_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.pointtypes.filter.point_class',$point_class_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("point_class_id AS value, point_class_name AS text");
    $p_query->from("#__te_point_classes") ;
    $db->setQuery($p_query);
    $this->aux_arrays['pointclasseslist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('point_type_id,point_type_name');
    $query->from('#__te_point_types');

    if ($point_class_id = $this->getState('filter.point_class')) 
      $query->where('point_class='.$point_class_id);

    return $query;
  }
}
?>
