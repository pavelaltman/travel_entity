<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTablePointSubTypes extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_point_subtypes', 'point_subtype_id', $db);
  }
}
?>