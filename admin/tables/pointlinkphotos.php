<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityTablePointLinkPhotos extends TETable
{
  var $points_links_id = null;

  function __construct(&$db)
  {
    parent::__construct('#__te_points_link_photos', 'point_link_photo_id', $db);
  }
}
?>