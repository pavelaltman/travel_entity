<?php
// No direct access to this file
defined('_JEXEC') or die;

JHtml::_('behavior.tooltip');
?>
<?php echo "<a href=\"".JRoute::_('index.php?option=com_travelentity&view=points')."\">Points</a>"; ?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&view=pointlinkphoto'); ?>" method="post" name="adminForm">
  <fieldset id="filter-bar">
    <div class="filter-select fltrt">
   	<select name="filter_link_point" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_POINT');?></option>
		<?php echo JHtml::_('select.options', $this->GetPointList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.point_id'));?>
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