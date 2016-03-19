<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.view');

class TravelEntityViewPointsPost extends JView
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
    $isNew = ($this->item->post_article_point_id == 0);
    JToolBarHelper::title($isNew ? JText::_('COM_TRAVELENTITY_MANAGER_POINTSPOST_NEW') : JText::_('COM_TRAVELENTITY_MANAGER_POINTSPOST_EDIT'));
    JToolBarHelper::save('pointspost.save');
    JToolBarHelper::cancel('pointspost.cancel', $isNew ? 'JTOOLBAR_CANCEL' : 'JTOOLBAR_CLOSE');
  }
}
