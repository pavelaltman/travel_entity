<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityTableRegions extends TETable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_regions', 'region_id', $db);
  }
}
?>