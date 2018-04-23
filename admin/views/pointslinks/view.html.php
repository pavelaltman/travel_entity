<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.view');
class TravelEntityViewPointsLinks extends JViewLegacy
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
    JToolBarHelper::title(JText::_('COM_TRAVELENTITY_MANAGER_POINTS_LINKS'));
    JToolBarHelper::deleteList('', 'pointslinks.delete');
    JToolBarHelper::editList('pointslink.edit');
    JToolBarHelper::addNew('pointslink.add');
  }      


  protected function GetPointList()
  {
   return $this->GetModel()->aux_arrays['pointlist'] ;
  }
}
?>
