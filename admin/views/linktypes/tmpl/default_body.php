<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->link_type_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->link_type_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=linktype.edit&link_type_id=' . $item->link_type_id); ?>">
  <?php echo $item->link_type_name; ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
