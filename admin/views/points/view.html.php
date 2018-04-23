<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.view');
class TravelEntityViewPoints extends JViewLegacy
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
    JToolBarHelper::title(JText::_('COM_TRAVELENTITY_MANAGER_POINTS'));
    JToolBarHelper::deleteList('', 'points.delete');
    JToolBarHelper::editList('point.edit');
    JToolBarHelper::addNew('point.add');
  }      

  protected function GetCountryList()
  {
   return $this->GetModel()->aux_arrays['countrylist'] ;
  }

  protected function GetRegionList()
  {
   return $this->GetModel()->aux_arrays['regionlist'] ;
  }

  protected function GetSubRegionList()
  {
   return $this->GetModel()->aux_arrays['subregionlist'] ;
  }

  protected function GetSettlementList()
  {
   return $this->GetModel()->aux_arrays['settlementlist'] ;
  }

  protected function GetPointClassList()
  {
   return $this->GetModel()->aux_arrays['pointclasslist'] ;
  }

  protected function GetPointTypeList()
  {
   return $this->GetModel()->aux_arrays['pointtypelist'] ;
  }

  protected function GetPointSubtypeList()
  {
   return $this->GetModel()->aux_arrays['pointsubtypelist'] ;
  }
}
?>
