<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->region_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->region_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=region.edit&region_id=' . $item->region_id); ?>">
  <?php echo $item->region_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=subregions&region_id=' . $item->region_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_REGION_LIST_SUBREGIONSLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
