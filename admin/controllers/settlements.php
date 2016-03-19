<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class TravelEntityControllerSettlements extends JControllerAdmin
{
  public function getModel($name = 'Settlements', $prefix = 'TravelEntityModel')         {
    $model = parent::getModel($name, $prefix, array('ignore_request' => true));
    return $model;
  }
}
