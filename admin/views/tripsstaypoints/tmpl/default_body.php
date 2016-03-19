<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->trip_stay_point_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->trip_stay_point_id); ?></td>
  <td><?php echo $item->settlement_name."(".$item->point_name.")"; ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=tripsstaypoint.edit&trip_stay_point_id=' . $item->trip_stay_point_id); ?>">
  <?php echo $item->stay_point_id; ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
