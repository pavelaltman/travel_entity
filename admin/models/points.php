<?php
// No direct access to this file
defined('_JEXEC') or die;

jimport('joomla.application.component.modellist');
require_once JPATH_SITE."/components/com_travelentity/tequery.php";


class TravelEntityModelPoints extends JModelList
{
  public $aux_arrays ; 

  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'point_id', 'p.point_id',
				'point_name', 'p.point_name',
				'country_id', 'p.country_id',
				'country_name', 'p.country_name',
				'settlement_id', 'p.settlement_id',
				'settlement_name', 'p.settlement_name',
				'region_id', 'p.region_id',
				'region_name', 'p.region_name',
				'subregion_id', 'p.subregion_id',
				'subregion_name', 'p.subregion_name',
				'point_class_id', 'p.point_class_id',
				'point_class_name', 'p.point_class_name',
				'point_type_id', 'p.point_type_id',
				'point_type_name', 'p.point_type_name',
				'point_subtype_id', 'p.point_subtype_id',
				'point_subtype_name', 'p.point_subtype_name',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   // Adjust the context to support modal layouts.
   if ($layout = JRequest::getVar('layout')) {
      $this->context .= '.'.$layout;
   }

   $country_id = $this->getUserStateFromRequest($this->context.'.filter.country_id', 'filter_country_id');
   $settlement_id = $this->getUserStateFromRequest($this->context.'.filter.settlement_id', 'filter_settlement_id');
   $region_id = $this->getUserStateFromRequest($this->context.'.filter.region_id', 'filter_region_id');
   $subregion_id = $this->getUserStateFromRequest($this->context.'.filter.subregion_id', 'filter_subregion_id');
   $point_class_id = $this->getUserStateFromRequest($this->context.'.filter.point_class_id', 'filter_point_class_id');
   $point_type_id = $this->getUserStateFromRequest($this->context.'.filter.point_type_id', 'filter_point_type_id');
   $point_subtype_id = $this->getUserStateFromRequest($this->context.'.filter.point_subtype_id', 'filter_point_subtype_id');
  
   $this->setState('filter.country_id', $country_id);
   $this->setState('filter.settlement_id', $settlement_id);
   $this->setState('filter.region_id', $region_id);
   $this->setState('filter.subregion_id', $subregion_id);
   $this->setState('filter.point_class_id', $point_class_id);
   $this->setState('filter.point_type_id', $point_type_id);
   $this->setState('filter.point_subtype_id', $point_subtype_id);

   // List state information.
   parent::populateState('p.point_name', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.country_id');
   $id	.= ':'.$this->getState('filter.settlement_id');
   $id	.= ':'.$this->getState('filter.region_id');
   $id	.= ':'.$this->getState('filter.subregion_id');
   $id	.= ':'.$this->getState('filter.point_class_id');
   $id	.= ':'.$this->getState('filter.point_type_id');
   $id	.= ':'.$this->getState('filter.point_subtype_id');
   return parent::getStoreId($id);
  }

  protected function getListQuery()
  {
    $db = JFactory::getDBO();
    
    // countries
    $query = new TEQuery($db) ;
    $query->select("country_id AS value, country_name AS text") ;
    $query->from("#__te_countries") ;
    $query->order("country_name");
    $db->setQuery($query);
    $this->aux_arrays['countrylist'] = $db->loadObjectList();

    // regions
    if ($country_id = $this->getState('filter.country_id')) 
    {
     $query = new TEQuery($db) ;
     $query->select('region_id AS value, region_name AS text ');
     $query->from('#__te_regions');
     $query->where('region_country='.(int) $country_id);
     $query->order('region_name');
     $db->setQuery($query);
     $this->aux_arrays['regionlist'] = $db->loadObjectList();
    }

    // subregions
    if ($region_id = $this->getState('filter.region_id')) 
    {
     $query = new TEQuery($db) ;
     $query->select('subregion_id AS value, subregion_name AS text ');
     $query->from('#__te_subregions');
     $query->where('subregion_region='.(int) $region_id);
     $query->order('subregion_name');
     $db->setQuery($query);
     $this->aux_arrays['subregionlist'] = $db->loadObjectList();
    }

    // settlements
    if ($subregion_id = $this->getState('filter.subregion_id')) 
    {
     $query = new TEQuery($db) ;
     $query->select('settlement_id AS value, settlement_name AS text ');
     $query->from('#__te_settlements');
     $query->where('settlement_subregion='.(int) $subregion_id);
     $query->order('settlement_name') ;
     $db->setQuery($query);
     $this->aux_arrays['settlementlist'] = $db->loadObjectList();
    }

    // point classes
    $query = new TEQuery($db) ;
    $query->select('point_class_id AS value, point_class_name AS text ');
    $query->from('#__te_point_classes');
    $db->setQuery($query);
    $this->aux_arrays['pointclasslist'] = $db->loadObjectList();

    // point types
    if ($point_class_id = $this->getState('filter.point_class_id')) 
    {
     $query = new TEQuery($db) ;
     $query->select('point_type_id AS value, point_type_name AS text ');
     $query->from('#__te_point_types');
     $query->where('point_class='.(int) $point_class_id);
     $db->setQuery($query);
     $this->aux_arrays['pointtypelist'] = $db->loadObjectList();
    }

    // point subtypes
    if ($point_type_id = $this->getState('filter.point_type_id')) 
    {
     $query = new TEQuery($db) ;
     $query->select('point_subtype_id AS value, point_subtype_name AS text ');
     $query->from('#__te_point_subtypes');
     $query->where('point_type='.(int) $point_type_id);
     $db->setQuery($query);
     $this->aux_arrays['pointsubtypelist'] = $db->loadObjectList();
    }


    // Create a main list query object.
    $query = new TEQuery($db) ;
    $query->select('point_id,point_name');
    $query->from('#__te_points,#__te_subregions,#__te_regions,#__te_countries,#__te_settlements,#__te_point_subtypes,#__te_point_types,#__te_point_classes');
    $query->where('settlement_subregion=subregion_id AND subregion_region=region_id AND region_country=country_id AND point_settlement=settlement_id AND point_subtype=point_subtype_id AND point_type=point_type_id AND point_class=point_class_id');

    if ($country_id) 
      $query->where('country_id='.(int) $country_id);

    if ($region_id) 
      $query->where('region_id='.(int) $region_id);

    if ($subregion_id = $this->getState('filter.subregion_id')) 
      $query->where('subregion_id='.(int) $subregion_id);

    if ($settlement_id = $this->getState('filter.settlement_id')) 
      $query->where('settlement_id='.(int) $settlement_id);

    if ($point_class_id = $this->getState('filter.point_class_id')) 
      $query->where('point_class_id='.(int) $point_class_id);

    if ($point_type_id) 
      $query->where('point_type_id='.(int) $point_type_id);

    if ($point_subtype_id = $this->getState('filter.point_subtype_id')) 
      $query->where('point_subtype_id='.(int) $point_subtype_id);

    return $query;
  }
}
?>