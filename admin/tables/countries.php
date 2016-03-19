<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableCountries extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_countries', 'country_id', $db);
  }
}
?>