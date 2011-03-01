<html>
<body>
<?php
include_once('collection.php');

class calCell {
    var $Entry;
    private $User;
    private $SlotStart;
    
    function setUser ($arg) {
        $this->User=$arg;
    }
    function getUser (){
        return $this->User;
    }
}
class cal extends phpCollection {
    
function callm (){
    
    for ($i=0;$i<10;$i++) {
    $a=new calCell;
    $a->setUser($i);
    $this->add($i,$a);
    //echo $this->length;
    //echo $this->item($i)->getUser();
    }

}
}

$obj=new cal;
$obj->callm();
$obj->item(1).getUser();


?>
</body>
</html>