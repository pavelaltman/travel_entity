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
<a class="modal" title="Select your image" href="index.php?option=com_media&amp;view=images&amp;tmpl=component&amp;asset=59&amp;author=42&amp;fieldid=id_field&amp;folder=" rel="{handler: 'iframe', size: {x: 800, y: 500}}">Select your image</a>