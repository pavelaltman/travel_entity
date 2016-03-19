<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.controller');
class TravelEntityController extends JController
{
  function display($cachable = false)
  {
    // Set default view if not set
    JRequest::setVar('view', JRequest::getCmd('view', 'points'));
    parent::display($cachable);
  }
}
?>