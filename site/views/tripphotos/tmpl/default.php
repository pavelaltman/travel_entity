<?php
// No direct access to this file
defined('_JEXEC') or die;

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";



//print_r($this->item);
?>

<b><?php echo $this->item['data']['trip_name']; ?></b><br>
<p><?php echo $this->item['data']['trip_descr']; ?></p><br>
<?php echo "<p>".$this->item['labs']['start_date_label'].": ".$this->item['data']['trip_start_date']; ?><br></p>

<?php

$lastpost="" ;
echo "<div class=\"row\">" ;
foreach($this->item['photos_arr'] as $i => $pointitem):

 if ($lastpost!=$pointitem['articletitle'])
 {   
    if ($lastpost!="")
        echo "</div>" ;
        echo "<div class=\"row\"><br><a href=\"".JRoute::_('index.php?option=com_content&view=article&id='.$pointitem['articleid'].'&Itemid='.$pointitem['menuid'])."\">".$pointitem['articletitle']."</a><br>" ;
 }
 echo "<div class=\"column\"><figure><img src=\"images/".$pointitem['photo_path']."\" alt=\"".$pointitem['photo_name']."\"> <figcaption>".$pointitem['photo_name']."</figcaption></figure></div>" ;
 $lastpost=$pointitem['articletitle'] ;

endforeach;
echo "</div>" ;

?>


