<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo JHtml::_('grid.id', $i, $item->post_article_point_id); ?></td>
  <td><?php echo $item->menutitle; ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=pointspost.edit&post_article_point_id=' . $item->post_article_point_id.'&point_id=' . $item->post_point); ?>">
  <?php echo $item->articletitle; ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
