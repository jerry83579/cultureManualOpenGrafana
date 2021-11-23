<?php
   $servername = 'localhost';
   $username = 'root';
   $password = '';
   $conn = new mysqli($servername, $username, $password);
   
   if(! $conn ) {
      die('Could not connect: ' . mysql_error());
   }
   
   echo 'Connected successfully';
   
   $sql = 'CREATE Database ddd';

   
   if($conn->query($sql) === true) {
      die('Could not create database: ' . mysql_error());
   }
   
   echo "Database test_db created successfully\n";

?>