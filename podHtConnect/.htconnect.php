<?php

/**
 * @author João Lagarto / Nuno Moreno
 * @version Datumo 2.0
 * @copyright EUPL
 * @abstract Class to handle DB connections
 */

class dbConnection extends PDO{
	
	private $engine;
	private $host;
	private $database;
	private $username;
	private $password;
	private $dsn;
	private $schemaQuery;
	private $schemaName;
		
	public function __construct(){
		$this->engine = "pgsql"; //"mysql" OR "pgsql"
		// $this->engine = "mysql"; //"mysql" OR "pgsql"
		$this->database = "postgres";//"dbtest" or "postgres"
		// $this->database = "dbtest";//"dbtest" or "postgres"
		$this->username = "postgres"; //"root" OR "postgres"
		// $this->username = "root"; //"root" OR "postgres"
		$this->password = "nasaki"; // "" OR "nasaki"
		// $this->password = ""; // "" OR "nasaki"
		$this->host = "localhost";
		$this->schemaName = "dbtest";// Name of the schema (same as database for mysql)
		$this->dsn = $this->engine.":dbname=".$this->database.";host=".$this->host;
		try {
			//database connection
			parent::__construct($this->dsn, $this->username, $this->password);
			//PDO error handling
			parent::setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			// Sets to the right schema
			$this->dbSchemaSet();
		} catch (PDOException $e) {
			echo $e->getMessage();
			exit();
		}
	}
	
	public function getEngine(){ return $this->engine;}
	public function getDatabase(){ return $this->database;}
	public function getSchema(){ return $this->schemaQuery;}
	public function getSchemaName(){ return $this->schemaName;}
	
/**
 * @author João Lagarto / Nuno Moreno
 * @version Datumo 2.0
 * @copyright EUPL
 * @abstract method to return original database
 */
	
	public function dbConn(){
		$this->schemaSelect($this->engine, $this->getDatabase());
		$sql = parent::prepare($this->schemaQuery);
		$sql->execute();
	}
	
/**
 * @author João Lagarto / Nuno Moreno
 * @version Datumo 2.0
 * @copyright EUPL
 * @abstract method to select information schema
 */
	
	public function dbInfo(){
		$this->schemaSelect($this->engine, "information_schema");
		$sql = parent::prepare($this->schemaQuery);
		$sql->execute();
	}
	
/**
 * @author João Lagarto / Nuno Moreno
 * @version Datumo 2.0
 * @copyright EUPL
 * @abstract method to handle different database engines
 */
	
	public function schemaSelect(){ 
		switch($this->engine){
			case "mysql": //query to change database in mysql
				$this->schemaQuery = "use ".$this->schemaName;
				break;
			case "pgsql"; //query to change database in postgresql
				$this->schemaQuery = "set search_path to ".$this->schemaName.",public";
				break;
		}
	}
	
/**
 * @author Pedro Pires
 * @version Datumo 2.0
 * @copyright EUPL
 * @abstract method to handle different database engines
 */
	public function dbSelect($db){ 
		$this->database = $db;
		$this->dbConn();
	}
	
	public function dbSchemaSet(){ 
		$this->schemaSelect();
		$sql = parent::prepare($this->schemaQuery);
		$sql->execute();
	}
	
}

?>