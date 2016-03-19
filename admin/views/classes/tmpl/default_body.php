<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->point_class_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->point_class_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=class.edit&point_class_id=' . $item->point_class_id); ?>">
  <?php echo $item->point_class_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointtypes&point_class_id=' . $item->point_class_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_COUNTRY_LIST_POINTTYPESLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
