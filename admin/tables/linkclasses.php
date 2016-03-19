<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableLinkClasses extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_points_link_classes', 'link_class_id', $db);
  }
}
?>
