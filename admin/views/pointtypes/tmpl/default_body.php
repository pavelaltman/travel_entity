<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->point_type_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->point_type_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=pointtype.edit&point_type_id=' . $item->point_type_id); ?>">
  <?php echo $item->point_type_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointsubtypes&point_type_id=' . $item->point_type_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_POINTTYPE_LIST_POINTSUBTYPESLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
