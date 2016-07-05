<?php
// No direct access to this file
defined('_JEXEC') or die;
?>
<?php foreach($this->items as $i => $item): ?>
  <tr class="row<?php echo $i % 2; ?>">
  <td><?php echo $item->point_id; ?></td>
  <td><?php echo JHtml::_('grid.id', $i, $item->point_id); ?></td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&task=point.edit&point_id=' . $item->point_id); ?>">
  <?php echo $item->point_name; ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointslinks&point_id=' . $item->point_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_POINT_LIST_LINKLISTLABEL'); ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointlinkphotos&point_id=' . $item->point_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_POINT_LIST_LINKPHOTOLISTLABEL'); ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointsposts&point_id=' . $item->point_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_POINT_LIST_POSTLISTLABEL'); ?>
  </a>
  </td>
  <td>
  <a href="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointphotos&point_id=' . $item->point_id); ?>">
  <?php echo JText::_('COM_TRAVELENTITY_POINT_LIST_PHOTOSLISTLABEL'); ?>
  </a>
  </td>
  </tr>
<?php endforeach; ?>
