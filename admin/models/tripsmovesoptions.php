<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelTripsMovesOptions extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'trip_move', 'trip_move',
				'trip_move_option_id', 'trip_move_option_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $trip_move = $this->getUserStateFromRequest('com_travelentity.tripsmovesoptions.filter.trip_move', 'filter_trip_move');
   $this->setState('filter.trip_move', $trip_move);

   // List state information.
   parent::populateState('trip_move', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.trip_move');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $trip_move=JRequest::getInt('trip_move_id') ;
    if ($trip_move)
    {
     $this->setState('filter.trip_move', $trip_move);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.tripsmovesoptions.filter.trip_move',$trip_move);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("trip_move_id AS value, trip_move_id AS text") ;
    $p_query->from("#__te_trips_moves");
    $db->setQuery($p_query);
    $this->aux_arrays['moveslist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('trip_move_option_id,trip_move_option_comment');
    $query->from('#__te_trips_moves_options');
    $query->order('trip_move_option_order');

    if ($trip_move = $this->getState('filter.trip_move')) 
      $query->where('trip_move='.$trip_move);

    return $query;
  }
}
?>
