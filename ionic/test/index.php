<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = 'petcoffee';
$sitekey = 'e3e052c73ae5aa678141d0b3084b9da4';

// $servername = 'localhost';
// $username = 'petcoffe_mobile';
// $password = 'Ykpl.2412';
// $database = 'petcoffe_mobile';
// $sitekey = 'e3e052c73ae5aa678141d0b3084b9da4';

define('INSERT_NOTIFY', 1);
define('EDIT_NOTIFY', 2);
define('COMPLETE_NOTIFY', 3);
define('REMOVE_NOTIFY', 4);
$mysqli = new mysqli($servername, $username, $password, $database);
if ($mysqli->connect_errno) die('error: '. $mysqli -> connect_error);
$mysqli->set_charset('utf8');
if (isset($_GET['action']) && !empty($_GET['action'])) {
    $action = $_GET['action'];
    define('ROOTDIR', NV_ROOTDIR . '/ionic/'. $branch);
    include_once(ROOTDIR . '/global_function.php');
    include_once(ROOTDIR . '/module.php');

    if (file_exists(ROOTDIR . '/' . $action . '.php')) {
        try {
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
            include_once(ROOTDIR .'/' . $action . '.php');
            echo json_encode($result);
            die();
        }
        catch (Exception $e) {
            echo json_encode(array('status' => 0, 'messenge' => $e->getMessage()));
        }
        die();
    }
}

echo json_encode(array('status' => 0, 'messenge' => 'Lỗi chức năng'));
exit();