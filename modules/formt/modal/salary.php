<?php
include_once(MODAL_PATH . '/employ.php');
class Salary {
  public $employ;
  public $prefix;
  public $db;
  public function __construct() {
    global $db;

    $this->db = $db;
    $this->employ = new Employ();
    $this->prefix = PREFIX .'_salary';
    $this->default = array(
      'id' => 0,
      'employid' => 0,
      'last_salary' => 0,
      'next_salary' => 0,
      'formal' => '',
      'note' => '',
      'file' => ''
    );
  }

  // id, employid, formal, note, time, file, next_time
  function insert($data) {
    $time = totime($data['time']);
    $next_time = $time + 60 * 60 * 24 * 365.25 * 3; // sau 3 nam bao lai

    $sql = 'insert into `'. $this->prefix .'` (employid, formal, note, time, next_time, file) values('. $data['employid'] .', "'. $data['formal'] .'", "'. $data['note'] .'", '. $time .', '. $next_time .', "'. $data['file'] .'")';

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  function remove($employid) {
    $sql = 'delete from `'. $this->prefix .'` where employid = '. $employid;

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  public function history($employid) {
    $xtpl = new XTemplate("salary-history.tpl", PATH2);

    $list = $this->salary_employ($employid);
    $index = 1;
    foreach ($list as $salary) {
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $salary['id']);
      $xtpl->assign('last_salary', $this->parse_time($salary['time']));
      $xtpl->assign('next_salary', $this->parse_time($salary['next_time']));
      $xtpl->assign('formal', $salary['formal']);
      $xtpl->assign('note', $salary['note']);
      $xtpl->assign('file', $salary['file']);
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  public function salary_employ($employid) {
    $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
    $query = $this->db->query($sql);

    $list = array();
    while ($salary = $query->fetch()) {
      $list []= $salary;
    }
    return $list;
  }

  public function salary_content() {
    $xtpl = new XTemplate("list.tpl", PATH2);

    $employ_list = $this->employ->get_list();
    $index = 1;
    $time = time();
    foreach ($employ_list as $employid => $employ) {
      $salary = $this->get_last_salary($employid);
      if ($time > $salary['next_time']) $xtpl->assign('color', 'red');
      else $xtpl->assign('color', '');
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $salary['id']);
      $xtpl->assign('employid', $employid);
      $xtpl->assign('name', $employ);
      $xtpl->assign('last_salary', $this->parse_time($salary['time']));
      $xtpl->assign('next_salary', $this->parse_time($salary['next_time']));
      $xtpl->assign('formal', $salary['formal']);
      $xtpl->assign('note', $salary['note']);
      $xtpl->assign('file', $salary['file']);
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  public function employ_content() {
    $xtpl = new XTemplate("employ-content.tpl", PATH2);

    $employ_list = $this->employ->get_list();
    $index = 1;
    foreach ($employ_list as $employid => $employ) {
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $employid);
      $xtpl->assign('name', $employ);
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  public function get_last_salary($employid) {
    $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
    $query = $this->db->query($sql);
    $salary = $query->fetch();
    if (empty($salary)) return $this->default;
    return $salary;
  }

  public function parse_time($time) {
    if (intval($time) > 0) return date('d/m/Y', $time);
    return 'Chưa nâng lương';
  }
}
