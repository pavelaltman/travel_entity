<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->mix_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->mix_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=descr.edit&mix_id=' . $item->mix_id); ?>">
  <?php echo $item->point_class_name." ".$item->point_type_name." ".$item->country_name." ".$item->region_name; ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
