<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->country_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->country_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=country.edit&country_id=' . $item->country_id); ?>">
  <?php echo $item->country_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=regions&country_id=' . $item->country_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_COUNTRY_LIST_REGIONSLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
