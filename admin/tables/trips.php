<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableTrips extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_trips', 'trip_id', $db);
  }
}
?>