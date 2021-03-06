<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.controller');

class TravelEntityControllerRawlinks extends JControllerLegacy
{
 public function addlink()
 {
  $new_link = JRequest::getString('new_link');

  $session = JFactory::getSession();
  $session->set('new_link',$new_link) ;

  $this->setRedirect(JRoute::_('index.php? option=com_travelentity&view=rawlinks')); 
 }

 public function dellink()
 {
  $link_id = JRequest::getInt('link_id');

  $session = JFactory::getSession();
  $session->set('del_link_id',$link_id) ;
  
  $this->setRedirect(JRoute::_('index.php? option=com_travelentity&view=rawlinks')); 
 }

 public function updatecountry()
 {
  $link_id = JRequest::getInt('link_id');
  $country_id = JRequest::getInt('country_id');

  $session = JFactory::getSession();
  $session->set('update_country_id',$country_id) ;
  $session->set('update_link_id',$link_id) ;
  
  $this->setRedirect(JRoute::_('index.php? option=com_travelentity&view=rawlinks')); 
 }
}
?>

