<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->trip_move_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->trip_move_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=tripsmove.edit&trip_move_id=' . $item->trip_move_id); ?>">
  <?php echo $item->start_point." -> ".$item->end_point; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=tripsmovesoptions&trip_move_id=' . $item->trip_move_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_TRIPSMIVES_LIST_OPTIONSLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
