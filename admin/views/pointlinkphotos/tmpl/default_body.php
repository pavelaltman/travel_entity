<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo JHtml::_('grid.id', $i, $item->points_links_id); ?></td>
  <td><?php echo $item->class_pre_label." ".$item->class_link_label." ".$item->class_post_label; ?></td>
  <td><?php echo $item->pre_label." ".$item->link_label." ".$item->post_label; ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=pointlinkphoto.edit&point_link_photo_id=' . $item->point_link_photo_id.'&point_id=' . $item->link_point); ?>">
  <?php echo $item->link_photo_path; ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
