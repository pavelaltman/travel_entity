<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelPointSubTypes extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'point_type', 'point_type',
				'point_subtype_id', 'point_subtype_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $point_type_id = $this->getUserStateFromRequest('com_travelentity.pointsubtypes.filter.point_type', 'filter_point_type');
   $this->setState('filter.point_type', $point_type_id);

   // List state information.
   parent::populateState('point_subtype_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.point_type');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $point_type_id=JRequest::getInt('point_type_id') ;
    if ($point_type_id)
    {
     $this->setState('filter.point_type', $point_type_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.pointsubtypes.filter.point_type',$point_type_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("point_type_id AS value, point_type_name AS text") ;
    $p_query->from("#__te_point_types");
    $db->setQuery($p_query);
    $this->aux_arrays['pointtypeslist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('point_subtype_id,point_subtype_name');
    $query->from('#__te_point_subtypes');

    if ($point_type_id = $this->getState('filter.point_type')) 
      $query->where('point_type='.$point_type_id);

    return $query;
  }
}
?>
