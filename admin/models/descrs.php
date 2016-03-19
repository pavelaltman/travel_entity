<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelDescrs extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'mix_id', 'mix_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   // List state information.
   parent::populateState('mix_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();


    $query = new TEQuery($db) ;
    $query->select('mix_id,point_class_name,point_type_name,country_name,region_name');
    $query->from('#__te_class_type_country_region m') ; 

    $query->leftJoin('#__te_point_classes AS pc ON m.class_id=pc.point_class_id');
    $query->leftJoin('#__te_point_types AS pt ON m.type_id=pt.point_type_id');
    $query->leftJoin('#__te_countries AS c ON m.country_id=c.country_id');
    $query->leftJoin('#__te_regions AS r ON m.region_id=r.region_id');


    // $query->where(' AND m.type_id=pt.point_type_id AND m.country_id=c.country_id AND m.region_id=r.region_id') ;

    // print_r($query->dump()) ;

    return $query;
  }
}
?>
