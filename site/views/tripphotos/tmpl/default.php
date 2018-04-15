<?php
// No direct access to this file
defined('_JEXEC') or die;

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";



//print_r($this->item);
?>

<b><?php echo $this->item['data']['trip_name']; ?></b></br>
<p><?php echo $this->item['data']['trip_descr']; ?></p></br>
<?php echo $this->item['labs']['start_date_label'].": ".$this->item['data']['trip_start_date']; ?></br></p>

<?php

foreach($this->item['photos_arr'] as $i => $pointitem):
echo "<p>".$pointitem['photo_name']."<br>";
echo "<img src=\"images/".$pointitem['photo_path']."\" alt=\"".$pointitem['photo_name']."\" </img></p>" ;
endforeach;


?>


