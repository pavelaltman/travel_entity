<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableLinkTypes extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_points_link_types', 'link_type_id', $db);
  }
}
?>