<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');

class TravelEntityTablePointPostPhotos extends JTable
{
  function __construct(&$db)
  {
    parent::__construct('#__te_photos', 'photo_id', $db);
  }
}
?>