<?php
   if( $_POST["name"]  ) {
   	$name = $_POST["name"];
   	$servername = "localhost";
	$username = "root";
	$password = "root";
	$dbname = "test";
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	if (!$conn) {
    	die("Connection failed: " . mysqli_connect_error());
	}
	
	$sql = "INSERT INTO data (name)
    VALUES ('".$_POST["name"]."')";
	if (mysqli_query($conn, $sql)) {
    	$new_sql = "SELECT * FROM data";
    	$result = mysqli_query($conn, $new_sql);
    	if (mysqli_num_rows($result) > 0) {
		    // output data of each row
		    echo "You have entered following values.<br>";
		    while($row = mysqli_fetch_assoc($result)) {
		        echo "name: " . $row["name"]. "<br>";
		    }
		}
	} else {
	    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
	}
    mysqli_close($conn);
		
      
    exit();
   }
?>
<html>
   <body>
   
      <form action = "<?php $_PHP_SELF ?>" method = "POST">
         Name: <input type = "text" name = "name" />
         
         <input type = "submit" />
      </form>
   
   </body>
</html>