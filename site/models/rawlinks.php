<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";


class TravelEntityModelRawLinks extends JModelList
{
  public $user, $labs ;

  protected function getListQuery()
  {
    $this->labs=TravelEntityGetTextLabels() ;

    $this->user =& JFactory::getUser();
    $db = JFactory::getDBO();

    if ($this->user->id)
    {
     $session = JFactory::getSession();

     $new_link = $session->clear('new_link') ;
     if (strlen($new_link))
     {
       $lnk = new stdClass();
       $lnk->link_user_id = $this->user->id ;
       $lnk->link_text = $new_link ;
       $result = $db->insertObject(query_replace('#__te_rawlinks'), $lnk);
     }

     $del_link_id = $session->clear('del_link_id') ;
     if ($del_link_id)
     {

      $dquery = new TEQuery($db) ;
      $conditions = array($db->quoteName('link_id') . '='.$del_link_id);
      $dquery->delete($db->quoteName(query_replace('#__te_rawlinks')));
      $dquery->where($conditions);
      $db->setQuery($dquery);
      $result = $db->query();
      
/*
       $lnk = new stdClass();
       $lnk->link_id = $del_link_id ;
       $result = $db->deleteObject('#__te_rawlinks', $lnk);
*/
     }

    }

    $query = new TEQuery($db) ;
    $query->select('*');
    $query->from('#__te_rawlinks');
    $query->where('link_user_id='.$this->user->id);

    return $query;
  }
}
?>
