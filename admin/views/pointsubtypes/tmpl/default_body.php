<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->point_subtype_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->point_subtype_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=pointsubtype.edit&point_subtype_id=' . $item->point_subtype_id); ?>">
  <?php echo $item->point_subtype_name; ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
