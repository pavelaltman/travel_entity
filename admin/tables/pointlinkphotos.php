<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTablePointLinkPhotos extends JTable
{
  var $points_links_id = null;

  function __construct(&$db)
  {
    parent::__construct('#__te_points_link_photos', 'point_link_photo_id', $db);
  }
}
?>