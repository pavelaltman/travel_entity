<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityTablePoints extends TETable
{
  var $point_id = null;
  var $point_name = null;
  var $point_subtype = null;
  var $point_subtype_name = null;

  function __construct(&$db)
  {
    parent::__construct('#__te_points', 'point_id', $db);
  }
}
?>