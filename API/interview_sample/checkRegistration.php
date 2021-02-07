 <?php
	include 'conn.php';

	$reqJSON = file_get_contents('php://input');
	$req = json_decode( $reqJSON, TRUE );

	
	$email = $req['email'];
	$password = $req['password'];
	
	//$queryResult = $connect->query("SELECT * FROM user WHERE email = '".eee."' and password = '".rrrr."'");
	
	$queryResult = $connect->query("SELECT * FROM user WHERE email ='".$email."' and password ='".$password."'");
	
	/*//SELECT * FROM `user` WHERE email = "eee" and password = "rrrr"*/

	$result = array();
	
	while($fetchData=$queryResult->fetch_assoc()){
		$result[] = $fetchData;
	}
	
	echo json_encode($result);
 ?>