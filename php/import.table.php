<?php
$servername = "localhost";
$username = "username";
$password = "password";
$database = "outcome11";
$t = $_GET['t'];
// Create connection
$conn = new mysqli($servername, $username, $password, $database);
mysqli_options($conn, MYSQLI_OPT_LOCAL_INFILE, true);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
for($i=1; $i <=$t ; $i++){

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
