<?php
// prx là prefix
// kiểm tra prx_config, config_name là vmodule
// kiểm tra file, class mang tên config_value đường dẫn modules/modal/config_value.php
$sql = "select * from `$db_config[prefix]_config` where config_name = 'vmodule'";
$query = $db->query($sql);

while ($row = $query->fetch()) {
    $var_name = $row['config_value'];
    $class_name = ucfirst($row['config_value']);
    $check_file = file_exists(NV_ROOTDIR . '/modules/modal/' . $var_name . '.php');
    if ($check_file) {
        require_once(NV_ROOTDIR . '/modules/modal/' . $var_name . '.php');
        $check_class = class_exists($class_name);
        if ($check_class) $$row['config_value'] = new $class_name();
    }
}
