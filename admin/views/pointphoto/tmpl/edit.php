<?php
// No direct access to this file
defined('_JEXEC') or die;
JHtml::_('behavior.tooltip');
?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointphoto&layout=edit&photo_id='.(int) $this->item->photo_id); ?>"
  method="post" name="adminForm" id="pointphoto-form">
  <fieldset class="adminform">
    <legend><?php echo JText::_('COM_TRAVELENTITY_POINTPHOTO_DETAILS'); ?></legend>
    <ul class="adminformlist">
      <?php foreach($this->form->getFieldset() as $field): ?>
        <li><?php echo $field->label;echo $field->input;?></li>
      <?php endforeach; ?>
    </ul>
  </fieldset>
  <div>
    <input type="hidden" name="task" value="pointphoto.edit" />
      <?php echo JHtml::_('form.token'); ?>
  </div>
</form>
