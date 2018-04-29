<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.controller');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";

class TravelEntityControllerPoint extends JControllerLegacy
{
 public function setgrade()
 {
  // echo "<p>THIS IS ME SHOUTING!</p>";
  $new_grade_id = JRequest::getInt('grade_id');
  $new_before_after = JRequest::getInt('before_after');
  $point_id = JRequest::getInt('id');
  $session = JFactory::getSession();
  
  $session->set('grade_id',$new_grade_id) ;
  $session->set('before_after',$new_before_after) ;

  // print_r($point_id) ;
  // print_r($session) ;
  
  $this->setRedirect(GetPointNameRoute($point_id)); 
 }
}
?>

