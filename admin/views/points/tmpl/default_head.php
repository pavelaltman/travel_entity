<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<tr>
  <th width="2">
  <?php echo JText::_('COM_TRAVELENTITY_POINT_HEADING_ID'); ?>
  </th>
  <th width="20" align="left">
  <input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($this->items); ?>);" />
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_HEADING_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_HEADING_LINKLIST'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_HEADING_LINKPHOTOLIST'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_HEADING_POSTSLIST'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_HEADING_POINTSLIST'); ?>
  </th>
</tr>