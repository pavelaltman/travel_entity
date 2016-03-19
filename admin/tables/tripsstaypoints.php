<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableTripsStayPoints extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_trips_stay_points', 'trip_stay_point_id', $db);
  }
}
?>