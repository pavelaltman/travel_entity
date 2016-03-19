<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableTripsMoves extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_trips_moves', 'trip_move_id', $db);
  }
}
?>