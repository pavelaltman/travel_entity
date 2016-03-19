<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.database.table');
class TravelEntityTablePointsPosts extends JTable
{
  var $points_links_id = null;

  function __construct(&$db)
  {
    parent::__construct('#__te_points_posts', 'post_article_point_id', $db);
  }
}
?>