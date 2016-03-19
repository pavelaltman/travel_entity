<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<tr>
  <th width="20">
  <input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($this->items); ?>);" />
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINTS_LINKS_LINKTYPE_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINTS_LINKS_LINKCLASS_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINTS_LINKS_HEADING_TITLE'); ?>
  </th>
</tr>