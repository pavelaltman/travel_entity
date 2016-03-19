<?php
// No direct access to this file
defined('_JEXEC') or die;

JHtml::_('behavior.tooltip');
?>
<?php echo "<a href=\"".JRoute::_('index.php?option=com_travelentity&view=countries')."\">Countries</a>"; ?>
<?php echo " <a href=\"".JRoute::_('index.php?option=com_travelentity&view=classes')."\">Point Classes</a>"; ?>
<?php echo " <a href=\"".JRoute::_('index.php?option=com_travelentity&view=descrs')."\">Descriptions</a>"; ?>
<?php echo " <a href=\"".JRoute::_('index.php?option=com_travelentity&view=trips')."\">Trips</a>"; ?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&view=points'); ?>" method="post" name="adminForm">
  <fieldset id="filter-bar">
    <div class="filter-select fltrt">
   	<select name="filter_country_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_COUNTRY');?></option>
		<?php echo JHtml::_('select.options', $this->GetCountryList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.country_id'));?>
	</select>
   	<select name="filter_region_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_REGION');?></option>
		<?php echo JHtml::_('select.options', $this->GetRegionList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.region_id'));?>
	</select>
   	<select name="filter_subregion_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_SUBREGION');?></option>
		<?php echo JHtml::_('select.options', $this->GetSubRegionList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.subregion_id'));?>
	</select>
   	<select name="filter_settlement_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_SETTLEMENT');?></option>
		<?php echo JHtml::_('select.options', $this->GetSettlementList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.settlement_id'));?>
	</select>
   	<select name="filter_point_class_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_POINTCLASS');?></option>
		<?php echo JHtml::_('select.options', $this->GetPointClassList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.point_class_id'));?>
	</select>
   	<select name="filter_point_type_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_POINTTYPE');?></option>
		<?php echo JHtml::_('select.options', $this->GetPointTypeList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.point_type_id'));?>
	</select>
   	<select name="filter_point_subtype_id" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_POINTSUBTYPE');?></option>
		<?php echo JHtml::_('select.options', $this->GetPointSubtypeList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.point_subtype_id'));?>
	</select>
    </div>
  </fieldset>
  <div class="clr"> </div>
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