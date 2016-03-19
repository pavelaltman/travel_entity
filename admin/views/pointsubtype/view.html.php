<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.view');

class TravelEntityViewPointSubType extends JView
{
  public function display($tpl = null)
  {
    // get the Data
    $form = $this->get('Form');
    $item = $this->get('Item');
    
    
    // Assign the Data
    $this->form = $form;
    $this->item = $item;
 
    // Set the toolbar
    $this->addToolBar();
 
    // Display the template
    parent::display($tpl);
  }
 
  protected function addToolBar()
  {
    JRequest::setVar('hidemainmenu', true);
    $isNew = ($this->item->point_subtype_id == 0);
    JToolBarHelper::title($isNew ? JText::_('COM_TRAVELENTITY_MANAGER_POINTSUBTYPE_NEW') : JText::_('COM_TRAVELENTITY_MANAGER_POINTSUBTYPE_EDIT'));
    JToolBarHelper::save('pointsubtype.save');
    JToolBarHelper::cancel('pointsubtype.cancel', $isNew ? 'JTOOLBAR_CANCEL' : 'JTOOLBAR_CLOSE');
  }
}
