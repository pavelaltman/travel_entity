<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityTableTripsMovesOptionsPoints extends TETable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_trips_moves_options_points', 'trip_move_option_point_id', $db);
  }
}
?>