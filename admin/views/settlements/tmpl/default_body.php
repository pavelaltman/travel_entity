<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->settlement_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->settlement_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=settlement.edit&settlement_id=' . $item->settlement_id); ?>">
  <?php echo $item->settlement_name; ?>
  </a>
  </td>
  <td><?php echo $item->settlement_subregion; ?></td>
  </tr>
<?php endforeach; ?>
