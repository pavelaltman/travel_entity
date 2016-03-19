<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.view');
class TravelEntityViewTripsMoves extends JView
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
    JToolBarHelper::title(JText::_('COM_TRAVELENTITY_MANAGER_TRIPSMOVES'));
    JToolBarHelper::deleteListX('', 'tripsmoves.delete');
    JToolBarHelper::editListX('tripsmove.edit');
    JToolBarHelper::addNewX('tripsmove.add');
  }      

  protected function GetTripList()
  {
   return $this->GetModel()->aux_arrays['triplist'] ;
  }
}
?>
