<?PHP
	if(isset($_POST['image'])){
		$now = DateTime::createFromFormat('U.u',microtime(true));
		$id = "leaf";

		$upload_folder = "upload";
		$path = "$upload_folder/$id.jpg";
		$image = $_POST['image'];
		if(file_put_contents($path, base64_decode($image)) != false){
				
                             $answer = shell_exec("fnfinal.exe");
                             echo $answer;

				exit;

		}
		else{
			echo "uploaded_failed";
			exit;
		}



	}

	else{
		echo "image_not_in";
		exit;
	}


 
?>
