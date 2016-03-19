<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableTripsMovesOptions extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_trips_moves_options', 'trip_move_option_id', $db);
  }
}
?>