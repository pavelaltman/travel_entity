<?php
// No direct access to this file
defined('_JEXEC') or die;
JHtml::_('behavior.tooltip');
?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&layout=edit&subregion_id='.(int) $this->item->subregion_id); ?>"
  method="post" name="adminForm" id="subregion-form">
  <fieldset class="adminform">
    <legend><?php echo JText::_('COM_TRAVELENTITY_SUBREGION_DETAILS'); ?></legend>
    <ul class="adminformlist">
      <?php foreach($this->form->getFieldset() as $field): ?>
        <li><?php echo $field->label;echo $field->input;?></li>
      <?php endforeach; ?>
    </ul>
  </fieldset>
  <div>
    <input type="hidden" name="task" value="subregion.edit" />
      <?php echo JHtml::_('form.token'); ?>
  </div>
</form>
