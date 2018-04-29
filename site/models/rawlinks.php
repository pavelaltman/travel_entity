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
  	// print_r(JRequest::get($_POST));
  	// print_r(JFactory::getSession());
  	 
  	$this->labs=TravelEntityGetTextLabels() ;

    $this->user =& JFactory::getUser();
    $db = JFactory::getDBO();

    if ($this->user->id)
    {
     $session = JFactory::getSession();

     $new_link = $session->get('new_link') ; $session->clear('new_link') ;
     if (strlen($new_link))
     {
       $lnk = new stdClass();
       $lnk->link_user_id = $this->user->id ;
       $lnk->link_text = $new_link ;
       $result = $db->insertObject(query_replace('#__te_rawlinks'), $lnk);
     }

     $del_link_id = $session->get('del_link_id') ; $session->clear('del_link_id') ;
     if ($del_link_id)
     {

      $dquery = new TEQuery($db) ;
      $conditions = array($db->quoteName('link_id') . '='.$del_link_id);
      $dquery->delete('#__te_rawlinks');
      $dquery->where($conditions);
      $db->setQuery($dquery);
      $result = $db->query();
     }

     $update_country_id = $session->get('update_country_id') ; $session->clear('update_country_id') ;
     $update_link_id = $session->get('update_link_id') ; $session->clear('update_link_id') ;
     if ($update_country_id)
     {
      $dquery = new TEQuery($db) ;
      $dquery->update('#__te_rawlinks');

      $setarray = array($db->quoteName('link_country') . '='.$update_country_id);
      $dquery->set($setarray);
      
      $conditions = array($db->quoteName('link_id') . '='.$update_link_id);
      $dquery->where($conditions);
      
      // echo($dquery->__toString());
         
      $db->setQuery($dquery);
      $result = $db->query();
     }
    }

    // Country list
    $p_query = new TEQuery($db) ;
    $p_query->select("country_id AS value, country_name AS text") ;
    $p_query->from("#__te_countries");
    $p_query->order("country_name");
    $db->setQuery($p_query);
    $this->aux_arrays['countrylist'] = $db->loadObjectList();
    
    
    // main list query
    $query = new TEQuery($db) ;
    $query->select('*');
    $query->from('#__te_rawlinks');
    $query->where('link_user_id='.$this->user->id);
    $query->join('LEFT OUTER','#__te_countries ON country_id=link_country');
    $query->order('country_name,link_id') ;
    
    return $query;
  }
}
?>
