<?php
// No direct access to this file
defined('_JEXEC') or die;

JHtml::_('behavior.tooltip');
?>
<?php echo "<a href=\"".JRoute::_('index.php?option=com_travelentity&view=pointslinks')."\">Points links</a>"; ?>
<?php echo " <a href=\"".JRoute::_('index.php?option=com_travelentity&view=linkclasses')."\">Link Classes</a>"; ?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&view=linktypes'); ?>" method="post"  name="adminForm" id="adminForm">
  <fieldset id="filter-bar">
    <div class="filter-select fltrt">
   	<select name="filter_link_type_class" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_LINKCLASS');?></option>
		<?php echo JHtml::_('select.options', $this->GetLinkClassList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.link_type_class'));?>
	</select>
    </div>
  </fieldset>
  <table class="adminlist">
    <thead><?php echo $this->loadTemplate('head');?></thead>
    <tfoot><?php echo $this->loadTemplate('foot');?></tfoot>
    <tbody><?php echo $this->loadTemplate('body');?></tbody>
  </table>
  <div>
    <input type="hidden" name="task" value="" />
    <input type="hidden" name="boxchecked" value="0" />
    <?php echo JHtml::_('form.token'); ?>
  </div>     
</form>