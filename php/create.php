<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "outcome";
$t = 20;

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

for ($i=1; $i <=$t ; $i++) { 
    $sql = "CREATE TABLE location" . $i . " (
        timestamp DATETIME NOT NULL ,
        initial_temp DECIMAL(10,2) NULL DEFAULT NULL ,
        initial_hum DECIMAL(10,2) NULL DEFAULT NULL ,
        chebychev_temp DECIMAL(10,2) NULL DEFAULT NULL ,
        chebychev_hum DECIMAL(10,2) NULL DEFAULT NULL ,
        arima_temp DECIMAL(10,2) NULL DEFAULT NULL ,
        arima_hum DECIMAL(10,2) NULL DEFAULT NULL 
        )";

        if ($conn->query($sql) === true) {
            echo "Table " . $i . " created successfully";
            echo "<br>";
        } else {
            echo "Error creating table: " . $conn->error;
            echo "<br>";
        }
        
}


