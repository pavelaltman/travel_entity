<?php
// No direct access to this file
defined('_JEXEC') or die;

JHtml::_('behavior.tooltip');
?>
<?php echo "<a href=\"".JRoute::_('index.php?option=com_travelentity&view=points')."\">Points</a>"; ?>
<?php echo "  <a href=\"".JRoute::_('index.php?option=com_travelentity&view=trips')."\">Trips</a>"; ?>
<?php echo "  <a href=\"".JRoute::_('index.php?option=com_travelentity&view=tripsstaypoints&trip_id='.$this->state->get('filter.trip_id'))."\">Trip Stay Points</a>"; ?>
<?php echo "  <a href=\"".JRoute::_('index.php?option=com_travelentity&view=tripsmoves&trip_id='.$this->state->get('filter.trip_id'))."\">Trip Moves</a>"; ?>
<?php echo "  <a href=\"".JRoute::_('index.php?option=com_travelentity&view=tripsmovesoptions')."\">Trips Moves Options</a>"; ?>
<form action="<?php echo JRoute::_('index.php?option=com_travelentity&view=tripsmovesoptionspoints'); ?>" method="post"  name="adminForm" id="adminForm">
  <fieldset id="filter-bar">
    <div class="filter-select fltrt">
   	<select name="filter_trip_move_option" class="inputbox" onchange="this.form.submit()">
		<option value=""><?php echo JText::_('TE_SELECT_TRIPMOVE');?></option>
		<?php echo JHtml::_('select.options', $this->GetMovesOptionsList(), 'value', 'text', 0 ? 0 : $this->state->get('filter.trip_move_option'));?>
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