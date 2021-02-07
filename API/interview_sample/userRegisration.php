 <?php
	 include 'conn.php';

	 $reqJSON = file_get_contents('php://input');
	 $req = json_decode( $reqJSON, TRUE );
	 
	 
	 $first_name = $req['first_name'];
	 $last_name = $req['last_name'];
	 $email = $req['email'];
	 $password = $req['password'];
	 $image = $req['image'];
	 
	 
	 $queryResult = $connect->query("INSERT INTO user (first_name, last_name, email, password, image,status) 
	 VALUES ('".$first_name."', '".$last_name."', '".$email."', '".$password."','".$image."', 1)");

	
	if($queryResult){
     echo (json_encode(array('code' =>1, 'message' => 'Login Success')));
	}
	else 
	{
	 echo(json_encode(array('code' =>2, 'message' => $queryResult)));
	}
 ?>


