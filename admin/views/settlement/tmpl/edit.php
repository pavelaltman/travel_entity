<?php
// No direct access to this file
defined('_JEXEC') or die;
JHtml::_('behavior.tooltip');
?>

<?php
print_r($this->GetModel()->aux_arrays) ;
?>

<form action="<?php echo JRoute::_('index.php?option=com_travelentity&layout=edit&settlement_id='.(int) $this->item->settlement_id); ?>"
  method="post"  name="adminForm" id="adminForm">
  <fieldset class="adminform">
    <legend><?php echo JText::_('COM_TRAVELENTITY_SETTLEMENT_DETAILS'); ?></legend>
    <ul class="adminformlist">
      <?php foreach($this->form->getFieldset() as $field): ?>
        <li><?php echo $field->label;echo $field->input;?></li>
      <?php endforeach; ?>
    </ul>
  </fieldset>
  <div>
    <input type="hidden" name="task" value="settlement.edit" />
      <?php echo JHtml::_('form.token'); ?>
  </div>
</form>
