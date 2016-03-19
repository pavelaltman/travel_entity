<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->trip_move_option_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->trip_move_option_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=tripsmovesoption.edit&trip_move_option_id=' . $item->trip_move_option_id); ?>">
  <?php echo $item->trip_move_option_comment ; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=tripsmovesoptionspoints&trip_move_option_id=' . $item->trip_move_option_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_TRIPSMOVESOPTIONS_LIST_POINTSLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
