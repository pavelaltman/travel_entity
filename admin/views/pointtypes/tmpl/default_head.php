<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<tr>
  <th width="2">
  <?php echo JText::_('COM_TRAVELENTITY_POINTTYPE_HEADING_ID'); ?>
  </th>
  <th width="20">
  <input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($this->items); ?>);" />
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINTTYPE_HEADING_TITLE'); ?>
  </th>
</tr>