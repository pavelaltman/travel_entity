<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelSettlements extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'settlement_subregion', 'settlement_subregion',
				'settlement_id', 'settlement_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $subregion_id = $this->getUserStateFromRequest('com_travelentity.settlements.filter.settlement_subregion','filter_settlement_subregion');
   $this->setState('filter.settlement_subregion', $subregion_id);

   // List state information.
   parent::populateState('settlement_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.settlement_subregion');
   return parent::getStoreId($id);
  }

  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $subregion_id=JRequest::getInt('subregion_id') ;
    if ($subregion_id)
    {
     $this->setState('filter.settlement_subregion', $subregion_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.settlements.filter.settlement_subregion',$subregion_id);
    }

    $p_query = new TEQuery($db) ;
    $p_query->select("subregion_id AS value, subregion_name AS text") ;
    $p_query->from("#__te_subregions");
    $db->setQuery($p_query);
    $this->aux_arrays['subregionlist'] = $db->loadObjectList();

    $query = new TEQuery($db) ;
    $query->select('settlement_id,settlement_name,settlement_subregion');
    $query->from('#__te_settlements');
    $query->order('settlement_name');


    if ($subregion_id = $this->getState('filter.settlement_subregion')) 
      $query->where('settlement_subregion='.$subregion_id);


    return $query;
  }
}
?>