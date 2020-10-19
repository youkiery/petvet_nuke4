<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = 'petcoffee';
$sitekey = 'e3e052c73ae5aa678141d0b3084b9da4';

define('INSERT_NOTIFY', 1);
define('EDIT_NOTIFY', 2);
define('COMPLETE_NOTIFY', 3);
define('REMOVE_NOTIFY', 4);

$mysqli = new mysqli($servername, $username, $password, $database);
if ($mysqli->connect_errno) die('error: '. $mysqli -> connect_error);
$mysqli->set_charset('utf8');

if (!empty($_GET['action'])) {
    $action = $_GET['action'];
    if (file_exists(NV_ROOTDIR . '/ionic/' . $action . '.php')) {
        try {
            include_once(NV_ROOTDIR . '/ionic/global_function.php');
            include_once(NV_ROOTDIR . '/ionic/module.php');
            if ($action !== 'login' && $action !== 'version') {
                if (empty($_GET['userid'])) throw new Exception('no user');
                else {
                    $userid = $_GET['userid'];
                    $user = checkUserId($userid);
                    if (empty($user)) throw new Exception('no user exist');
                }
            }
            $result = array(
                'status' => 0,
                'messenger' => ''
            );
            date_default_timezone_set('asia/ho_chi_minh');
            include_once(NV_ROOTDIR . '/ionic/' . $action . '.php');
            echo json_encode($result);
            die();
        }
        catch (Exception $e) {
            echo json_encode(array('status' => 0, 'messenge' => $e->getMessage()));
        }
        die();
    }
}

echo json_encode(array('status' => 0, 'messenge' => 'no action allow'));
