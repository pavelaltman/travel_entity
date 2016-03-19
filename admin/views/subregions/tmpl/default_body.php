<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->subregion_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->subregion_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=subregion.edit&subregion_id=' . $item->subregion_id); ?>">
  <?php echo $item->subregion_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=settlements&subregion_id=' . $item->subregion_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_REGION_LIST_SETTLEMENTSLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
