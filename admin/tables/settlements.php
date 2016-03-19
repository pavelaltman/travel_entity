<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableSettlements extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_settlements', 'settlement_id', $db);
  }
}
?>