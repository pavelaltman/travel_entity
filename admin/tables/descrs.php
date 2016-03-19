<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTableDescrs extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_class_type_country_region', 'mix_id', $db);
  }
}
?>