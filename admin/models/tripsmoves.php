<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelTripsMoves extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'trip_id', 'trip_id',
				'trip_move_id', 'trip_move_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $trip_id = $this->getUserStateFromRequest('com_travelentity.tripsmoves.filter.trip_id', 'filter_trip_id');
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
     $app->setUserState('com_travelentity.tripsmoves.filter.trip_id',$trip_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("trip_id AS value, trip_name AS text") ;
    $p_query->from("#__te_trips");
    $db->setQuery($p_query);
    $this->aux_arrays['triplist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('trip_move_id,sspps.settlement_name as start_point,espps.settlement_name as end_point');
    $query->from('#__te_trips_moves as tm');

    $query->leftJoin('#__te_trips_stay_points AS ssp ON tm.trip_move_start_stay_point = ssp.trip_stay_point_id');
    $query->leftJoin('#__te_trips_stay_points AS esp ON tm.trip_move_end_stay_point = esp.trip_stay_point_id');

    $query->leftJoin('#__te_points AS sspp ON ssp.stay_point_id=sspp.point_id');
    $query->leftJoin('#__te_settlements AS sspps ON sspp.point_settlement=sspps.settlement_id');
    $query->leftJoin('#__te_points AS espp ON esp.stay_point_id=espp.point_id');
    $query->leftJoin('#__te_settlements AS espps ON espp.point_settlement=espps.settlement_id');

    $query->order('trip_move_start_stay_point,trip_move_end_stay_point');


    if ($trip_id = $this->getState('filter.trip_id')) 
      $query->where('tm.trip_id='.$trip_id);

    return $query;
  }
}
?>
