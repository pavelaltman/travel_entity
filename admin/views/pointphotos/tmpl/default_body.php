<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo JHtml::_('grid.id', $i, $item->photo_id); ?></td>
  <td><?php echo $item->trip_name; ?></td>
  <td><?php echo $item->point_name; ?></td>
  <td><?php echo $item->menutitle." -> ".$item->articletitle; ?></td>
  <td><?php echo $item->photo_name; ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=pointphoto.edit&photo_id=' . $item->photo_id); ?>">
  <?php echo $item->photo_path; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JURI::root(); ?>/images/<?php echo $item->photo_path ; ?>"> <img src="<?php echo JURI::root(); ?>/images/<?php echo $item->photo_path ; ?>" height="64"> </a>
  </td>
  <td>
  <?php echo $item->point_datetime ; ?>
  </td>
  </tr>
<?php endforeach; ?>
