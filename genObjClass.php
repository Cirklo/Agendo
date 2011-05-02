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
        dbHelp::mysql_select_db2("information_schema");
        $db = dbHelp::database2(1);
        $sql="SELECT COLUMN_COMMENT FROM COLUMNS WHERE COLUMN_NAME='". $FieldName ."' and TABLE_NAME='". $TableName ."' AND TABLE_SCHEMA LIKE '".$db."'";
        $res=dbHelp::mysql_query2($sql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
        $arr[0]= dbHelp::mysql_fetch_row2($res);
        dbHelp::mysql_select_db2($db);
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
        $res = dbHelp::mysql_query2($sql);
        $nfields = dbHelp::mysql_numrows2($res);
        $i = 0; //initialize counter
        while($row = dbHelp::mysql_fetch_row2($res)){ //table fields (number and name)
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
        dbHelp::mysql_query2($msql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $msql, $ObjName, $user_id));
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
        dbHelp::mysql_query2($sql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
		
		if($ObjName == "user"){
			$sql = "select max(".$ObjName."_id) from ".$ObjName; 
			$idRow = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
			$idArray = dbHelp::mysql_fetch_row2($idRow);
			$this->updatePass($ObjName, $user_id, $idArray[0]);
		}
    }
	
	// @author Pedro Pires
	// @abstract: Gets the user's password, encrypts it and updates it on the user table 
	function updatePass($ObjName, $user_id, $id){
		// Gets password
		$sql="select ".$ObjName."_passwd from ".$ObjName." where ".$ObjName."_id='$id'";
		$passRow = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
		$passArray = dbHelp::mysql_fetch_row2($passRow);
		$pass = $passArray[0];
		$pass = cryptPassword($pass);
		// Encrypts it and updates it on the table
		$sql=" update $ObjName set ".$ObjName."_passwd='".$pass."' where ".$ObjName."_id='$id'";
        dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
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
        dbHelp::mysql_query2($sql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
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
        dbHelp::mysql_query2($sql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, $ObjName, $user_id));
    }
    
    function check_foreign_key($field) {
        $db = dbHelp::database2(1);
        dbHelp::mysql_select_db2("information_schema");
        $sql = "SELECT REFERENCED_TABLE_NAME FROM KEY_COLUMN_USAGE WHERE COLUMN_NAME = '".$field."' AND TABLE_SCHEMA LIKE '".$db."'";
        $resf = dbHelp::mysql_query2($sql);
        $row = dbHelp::mysql_fetch_row2($resf);
        dbHelp::mysql_select_db2($db);
        return $row[0];        
    }
    
    function table_fields($table){
        $sql = "show fields from ".$table;
	$res = dbHelp::mysql_query2($sql) or die($sql); //mysql_error().$sql);
	$fields_table = "";
	while ($row = dbHelp::mysql_fetch_row2($res))
	{
		$fields_table .= $row[0].", ";
	}
	$fields_table = substr($fields_table, 0, strlen($fields_table)-2);
	return $fields_table;
        
    }
    
    function order_by_fk($FKtable){
        $sql = "show fields from ".$FKtable;
	$res = dbHelp::mysql_query2($sql);
	// $resdata = mysql_data_seek($res, 1);
	$row = dbHelp::mysql_fetch_row2($res);
	return $row[0];
    }
    
}

?>