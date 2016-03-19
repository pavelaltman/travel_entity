<?php
// No direct access to this file
defined('_JEXEC') or die;

JHtml::_('behavior.tooltip');
?>
<?php echo "<a href=\"".JRoute::_('index.php?option=com_travelentity&view=points')."\">Points</a>"; ?>
<?php echo " <a href=\"".JRoute::_('index.php?option=com_travelentity&view=countries')."\">Countries</a>"; ?>
<?php echo " <a href=\"".JRoute::_('index.php?option=com_travelentity&view=regions')."\">Regions</a>"; ?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&view=subregions'); ?>" method="post" name="adminForm">
  <fieldset id="filter-bar">
    <div class="filter-select fltrt">
   	<select name="filter_subregion_region" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_REGION');?></option>
		<?php echo JHtml::_('select.options', $this->GetRegionList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.subregion_region'));?>
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