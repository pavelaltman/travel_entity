<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.view');
class TravelEntityViewSettlements extends JViewLegacy
{
  protected $items ;
  protected $pagination ;
  protected $state ;

  function display($tpl = null)
  {
    $this->items = $this->get('Items');
    $this->pagination = $this->get('Pagination');
    $this->state = $this->get('State');
                
    // Set the toolbar
    $this->addToolBar();
 
    // Display the template
    parent::display($tpl);
  }
        
  protected function addToolBar()
  {
    JToolBarHelper::title(JText::_('COM_TRAVELENTITY_MANAGER_SETTLEMENTS'));
    JToolBarHelper::deleteList('', 'settlements.delete');
    JToolBarHelper::editList('settlement.edit');
    JToolBarHelper::addNew('settlement.add');
  }      

  protected function GetSubRegionList()
  {
   return $this->GetModel()->aux_arrays['subregionlist'] ;
  }
}
?>
