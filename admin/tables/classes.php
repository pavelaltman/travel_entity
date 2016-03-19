<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableClasses extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_point_classes', 'point_class_id', $db);
  }
}
?>
