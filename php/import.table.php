<?php
$servername = "localhost";
$username = "username";
$password = "password";
$database = "outcome20";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);
mysqli_options($conn, MYSQLI_OPT_LOCAL_INFILE, true);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
for($t=1;$t<=20;$t++){

$sql = '
        LOAD DATA LOCAL INFILE "yourpath/location_'.$t.'.csv"
        INTO TABLE location'.$t.'
        FIELDS TERMINATED BY ","
        LINES TERMINATED BY "\n"
        IGNORE 1 ROWS
    ';

if ($conn->query($sql) === true) {
    echo '<br>';
    echo "succesfully imported";
} else {
    echo '<br>';
    echo "failed to import" . $conn->error;
}
}
