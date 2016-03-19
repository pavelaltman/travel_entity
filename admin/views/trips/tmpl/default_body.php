<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->trip_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->trip_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=trip.edit&trip_id=' . $item->trip_id); ?>">
  <?php echo $item->trip_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=tripsstaypoints&trip_id=' . $item->trip_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_TRIPS_LIST_STAYPOINTSLABEL'); ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=tripsmoves&trip_id=' . $item->trip_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_TRIPS_LIST_MOVESLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
