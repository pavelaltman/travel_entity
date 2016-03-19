<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<tr>
  <th width="20">
  <input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($this->items); ?>);" />
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINTS_POSTS_MENUITEM_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINTS_POST_ARTICLE_TITLE'); ?>
  </th>
</tr>