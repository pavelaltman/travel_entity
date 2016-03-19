<?php
defined('_JEXEC') or die;

jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";


class TravelEntityModelTrips extends JModelList
{
  protected function getListQuery()
  {
    $db = & JFactory::getDBO();
    $query = new TEQuery($db) ;

    $query->select('*');
    $query->from('#__te_trips t,#__te_trip_stages ts');
    $query->where('t.trip_stage=ts.trip_stage_id');
    $query->order('trip_start_date,trip_id') ;

    return $query;
  }
}
?>
