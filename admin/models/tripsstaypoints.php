<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelTripsStayPoints extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'trip_id', 'trip_id',
				'trip_stay_point_id', 'trip_stay_point_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $trip_id = $this->getUserStateFromRequest('com_travelentity.tripsstaypoints.filter.trip_id', 'filter_trip_id');
   $this->setState('filter.trip_id', $trip_id);

   // List state information.
   parent::populateState('trip_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.trip_id');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $trip_id=JRequest::getInt('trip_id') ;
    if ($trip_id)
    {
     $this->setState('filter.trip_id', $trip_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.tripsstaypoints.filter.trip_id',$trip_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("trip_id AS value, trip_name AS text") ;
    $p_query->from("#__te_trips") ;
    $db->setQuery($p_query);
    $this->aux_arrays['triplist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('trip_stay_point_id,stay_point_id,arrival_date,departure_date,point_name,settlement_name');
    $query->from('#__te_trips_stay_points,#__te_points,#__te_settlements');
    $query->where('stay_point_id=point_id');
    $query->where('point_settlement=settlement_id');

    if ($trip_id = $this->getState('filter.trip_id')) 
      $query->where('trip_id='.$trip_id);

    return $query;
  }
}
?>
