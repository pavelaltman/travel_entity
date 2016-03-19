<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');
 
jimport('joomla.application.component.controller');
jimport('joomla.language.helper');
 
// Get an instance of the controller prefixed by ***
$controller = JControllerLegacy::getInstance('TravelEntity');
 

global $glt ;

$languages = JLanguageHelper::getLanguages('lang_code');
$lang_code = JFactory::getLanguage()->getTag();
$glt = $languages[$lang_code]->sef;
if ($glt=='ru') $glt='' ; 

$input = JFactory::getApplication()->input;
$controller->execute($input->getCmd('task'));
 
// Redirect if set by the controller
$controller->redirect();
