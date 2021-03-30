<?php
class Staff extends Core {
  function __construct() {
    parent::__construct();
  }

  // lấy danh sách nhân viên, type = 0 <=> không có quyền
  function getStaffList() {
    $sql = 'select * from pet_test_staff where type > 0 order by id desc';
    return $this->fetchall($sql);
  }

  // thêm sửa xóa dữ liệu
  // kiểm tra quyền người dùng, thực hiện thay đổi
    // nếu chưa có, thêm mới
    // nếu đã có, cập nhật
    // cập nhật type = 0 <=> xóa
  function update($userid, $type, $value) {
    $sql = 'update pet_test_staff set '. $type .' = '. $value .' where userid = '. $userid;
    $this->db->query($sql);
  }

  function insert($userid) {
    $sql = 'select * from pet_test_staff where userid = '. $userid;
    $staff = $this->fetch($sql);

    if (empty($staff)) {
      $sql = 'insert into pet_test_staff (userid) values('. $userid .')';
      $this->db->query($sql);
    }
  }

  function remove($userid) {
    $sql = 'delete from pet_test_staff where userid = '. $userid;
    $this->db->query($sql);
  }

  function viewFilter($keyword) {
    $sql = 'select * from pet_users where userid not in (select userid from pet_test_staff) and (first_name like "%'. $keyword .'%" or last_name like "%'. $keyword .'%" or username like "%'. $keyword .'%") limit 20';
    $list = $this->fetchall($sql);
    
    $xtpl = new XTemplate('staff/insert-list.tpl', PATH);
    $index = 1;
    foreach ($list as $row) {
      $xtpl->assign('index', $index ++);
      $xtpl->assign('fullname', $row['name']);
      $xtpl->assign('username', $row['username']);
      $xtpl->assign('userid', $row['userid']);
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  function viewStaffContent() {
    $xtpl = new XTemplate('staff/content.tpl', PATH);
    $xtpl->assign('content', $this->viewStaffList());
    $xtpl->parse('main');
    return $xtpl->text();
  }

  function viewStaffList() {
    $sql = 'select a.*, concat(b.last_name, "", b.first_name) as name, b.username from pet_test_staff a inner join pet_users b on a.userid = b.userid group by a.userid';
    $list = $this->fetchall($sql);
    $index = 1;
    $xtpl = new XTemplate('staff/list.tpl', PATH);
    $array = array('manager', 'accountant', 'shop', 'hopital', 'stay');
    $swap = array(0 => 'btn-info', 'btn-warning');
    foreach ($list as $row) {
      $xtpl->assign('index', $index ++);
      $xtpl->assign('fullname', $row['name']);
      $xtpl->assign('username', $row['username']);
      $xtpl->assign('userid', $row['userid']);
      foreach ($array as $value) {
        $xtpl->assign($value .'_btn', $swap[$row[$value]]);
        $xtpl->assign($value .'_value', intval(!$row[$value]));
      }
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }
}
