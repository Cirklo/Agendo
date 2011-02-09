<?php
//session_start();	
require_once("commonCode.php");
	initSession(true);
?>

<?php
/**
  * @author Nuno Moreno
  * @copyright 2009-2010 Nuno Moreno
  * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  * @version 1.0
  * @abstract Class that magically builds properties which will then be used as table fields
 */
// This file was altered by Pedro Pires (The chosen two)

class genObj {
     
    private $vars = array();  
    public function __construct(){
    }

    public function __set($var, $val){
        $this->vars[$var] = $val;
    } 
    public function __get($var){
        if(isset($this->vars[$var])){
            return $this->vars[$var];
        } else {
            throw new Exception("Property ‘$var’ does not exist");
        }
        
    }
    /**
    * @author Nuno Moreno
    * @copyright 2009-2010 Nuno Moreno
    * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
    * @version 1.0
    * @abstract Big hack for checking if the field is a pwd ;P
    */ 
    function check_field_comment($FieldName,$TableName, $user_id) {
        $error = new errorHandler;
        mysql_select_db("information_schema");
        $db = database(1);
        $sql="SELECT COLUMN_COMMENT FROM COLUMNS WHERE COLUMN_NAME='". $FieldName ."' and TABLE_NAME='". $TableName ."' AND TABLE_SCHEMA LIKE '".$db."'";
        $res=mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
        $arr[0]= mysql_fetch_row($res);
        mysql_select_db($db);
        return $arr[0][0];
    }
    
           
    /**
    * @author João Lagarto
    * @copyright 2010 João Lagarto
    * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
    * @version 1.0
    * @abstract: method for adding multiple rows in a generic table (NOTE: table primary key must have auto increment and value set to '')
    */
    
    function multiple($ObjName, $nrows, $user_id){ //nrows stands for the number of inserts
        $error = new errorHandler;      
        $sql = "show fields from ".$ObjName;
        $res = mysql_query($sql);
        $nfields = mysql_num_rows($res);
        $i = 0; //initialize counter
        while($row = mysql_fetch_array($res)){ //table fields (number and name)
            $name[$i] = $row[0];
            $i++;
        }
        
        //Loop for debug
       /* foreach ($this->vars as $key=>$value){
            echo $key;
            echo ":".$value."<br>";
        }*/        
        
        for($i = 0; $i < $nfields; $i++){ //build control array
            $ctr .= "'',";
            if($i == ($nfields-1)){
                $ctr = "(".substr($ctr,0,strlen($ctr)-1)."),";
                //echo $ctr;
            }
        }
        
        $msql = "INSERT INTO $ObjName VALUES "; //Initialize insert query
        for ($i = 1; $i <= $nrows; $i++){ //number of rows created for insert
            for($j = 0; $j < $nfields; $j++){ //number of table fields
                if($i == 1){
                    if(datetime($name[$j]) == 'date' or datetime($name[$j]) == 'datetime') $name[$j] .= "_add_";
                    $values .= "'".$this->vars[$name[$j]]."',"; //first row to be inserted ---> needs to have datetime fields described by '_add_'
                }
                else{
                    $values .= "'".$this->vars[$name[$j]."__".$i]."',"; //rows 2, 3, 4, etc...
                }
                $arr[$i] = "(".substr($values,0, strlen($values)-1)."),";
                if($arr[$i] == $ctr) $arr[$i] = ''; // if row was deleted it can't be written in the query
            }
            $values = ''; //reinitialize query inputs for the following rows
            $msql .= $arr[$i];
        }
        $msql = substr($msql, 0 , strlen($msql)-1); //remove unwanted chars
        mysql_query($msql) or die ($error->sqlError(mysql_error(), mysql_errno(), $msql, $ObjName, $user_id));
    }
    
    /**
    * @author Nuno Moreno
    * @copyright 2009-2010 Nuno Moreno
    * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
    * @version 1.0
    * @abstract: method for adding a new row in a generic table 
    */ 
    
    function add($ObjName, $user_id){
        $error = new errorHandler;
        $sql="insert into $ObjName values ('" . implode("','", $this->vars) . "')";
        mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
		
		if($ObjName == "user"){
			$sql = "select max(".$ObjName."_id) from ".$ObjName; 
			$idRow = mysql_query($sql) or die (mysql_error().$sql);
			$idArray = mysql_fetch_row($idRow);
			$this->updatePass($ObjName, $user_id, $idArray[0]);
		}
    }
	
	// @author Pedro Pires
	// @abstract: Gets the user's password, encrypts it and updates it on the user table 
	function updatePass($ObjName, $user_id, $id){
		// require_once("commonCode.php");
		// Gets password
		$sql="select ".$ObjName."_passwd from ".$ObjName." where ".$ObjName."_id='$id'";
		$passRow = mysql_query($sql) or die (mysql_error().$sql);
		$passArray = mysql_fetch_row($passRow);
		$pass = $passArray[0];
		$pass = cryptPassword($pass);
		// Encrypts it and updates it on the table
		$sql=" update $ObjName set ".$ObjName."_passwd='".$pass."' where ".$ObjName."_id='$id'";
        mysql_query($sql) or die (mysql_error().$sql);
	}
	
    /**
    * @author Nuno Moreno
    * @copyright 2009-2010 Nuno Moreno
    * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
    * @version 1.0
    * @abstract: method for deleting a row in a generic table. Note that all tables have a Pkey!
    */
    
    function delete($ObjName, $user_id){
        $error = new errorHandler;
        $pkey=$ObjName. "_id";
        $sql="delete from $ObjName where $pkey=" .$this->vars[$pkey];
        usleep(100000);
        mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
    }
    /**
    * @author Nuno Moreno
    * @copyright 2009-2010 Nuno Moreno
    * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
    * @version 1.0
    * @abstract: method for updating a row in a generic table. Note that hack in the pwd!
    */ 
    function update($ObjName, $user_id, $id){
        $error = new errorHandler;
        $pkey=$ObjName. "_id";
        $a='';
        $counter = 0; //initialize counter
        foreach ($this->vars as $key=>$value){
            $comment=$this->check_field_comment($key,$ObjName,$user_id);
            // this is a hack! in the future I need a more elegant way of doing it
			// pedro confirms, this is rather horrible and hates himself for doing it this way but... it works for now
            if ($comment=='pwd') {
                if (((substr($value,0,1)=="*") and (strlen($value)==41)) || strlen($value)==64) {//quando se alterar o método de cifra vai ser preciso alterar isto
                    $a.= $key."='".$value. "'," ;
                } else {
					$value = cryptPassword($value);
                    $a.= $key."='".$value. "'," ;
                }
            } else {
                if(substr($key, strlen($key)-5,5) == '_sel_'){
                    $key = substr($key, 0, strlen($key)-5-strlen($id));
                }
                if($counter != 0)
                    $a.= $key."='".$value. "'," ;
            }
            $counter++;
        }
        $a=substr($a,0,(strlen($a)-1));
        $sql=" update $ObjName set $a where $pkey='" .$this->vars[$pkey] . "'";
        mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
    }
    
    function check_foreign_key($field) {
        $db = database(1);
        mysql_select_db("information_schema");
        $sql = "SELECT REFERENCED_TABLE_NAME FROM KEY_COLUMN_USAGE WHERE COLUMN_NAME = '".$field."' AND CONSTRAINT_SCHEMA LIKE '".$db."'";
        $resf = mysql_query($sql);
        $row = mysql_fetch_row($resf);
        mysql_select_db($db);
        return $row[0];        
    }
    
    function table_fields($table){
        $sql = "show fields from ".$table;
	$res = mysql_query($sql) or die(mysql_error().$sql);
	$fields_table = "";
	while ($row = mysql_fetch_array($res))
	{
		$fields_table .= $row[0].", ";
	}
	$fields_table = substr($fields_table, 0, strlen($fields_table)-2);
	return $fields_table;
        
    }
    
    function order_by_fk($FKtable){
        $sql = "show fields from ".$FKtable;
	$res = mysql_query($sql);
	$resdata = mysql_data_seek($res, 1);
	$row = mysql_fetch_array($res);
	return $row[0];
    }
    
}

?>