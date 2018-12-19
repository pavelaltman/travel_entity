<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<tr>
  <th width="20">
  <input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($this->items); ?>);" />
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_TRIP_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_POINT_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_POST_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_NAME_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_PATH_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_PHOTO_TITLE'); ?>
  </th>
  <th>
  <?php echo JText::_('COM_TRAVELENTITY_POINT_PHOTOS_DATETIME_TITLE'); ?>
  </th>
</tr>