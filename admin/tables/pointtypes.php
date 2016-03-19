<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTablePointTypes extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_point_types', 'point_type_id', $db);
  }
}
?>