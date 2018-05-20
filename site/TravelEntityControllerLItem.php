<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.controller');

class TravelEntityControllerLItem extends JControllerLegacy
{
 public function change_awb()
 {
  $class_id= JRequest::getInt('cl_id');
  $country_id= JRequest::getInt('co_id');
  $region_id= JRequest::getInt('re_id');
  $type_id= JRequest::getInt('ty_id');

  $new_all_want_been= JRequest::getInt('all_want_been');
  $new_want_grade= JRequest::getInt('want_grade');
  $view_str= JRequest::getCmd('viewname');
 
  $model= & $this->getModel($view_str) ;

  $rstr=$model->GetSourceRoute($class_id, $country_id, $type_id, $region_id, $view_str) ;

  $session = JFactory::getSession();

  if ($new_all_want_been)
     $session->set('all_want_been',$new_all_want_been) ;
  if ($new_want_grade)
     $session->set('want_grade',$new_want_grade) ;

  $this->setRedirect(JRoute::_($rstr)); 
 }
}
?>
