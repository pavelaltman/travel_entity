<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.view');
class TravelEntityViewTrips extends JViewLegacy
{
  function display($tpl = null)
  {
    // Get data from the model
    $items = $this->get('Items');
    $pagination = $this->get('Pagination');
 
    // Assign data to the view
    $this->items = $items;
    $this->pagination = $pagination;
                

    // Display the template
    parent::display($tpl);
  }
        
}
?>
