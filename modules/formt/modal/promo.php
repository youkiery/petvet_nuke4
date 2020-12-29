<?php
include_once(MODAL_PATH . '/employ.php');
class Promo {
  public $employ;
  public $prefix;
  public $db;
  public function __construct() {
    global $db;

    $this->db = $db;
    $this->employ = new Employ();
    $this->prefix = PREFIX .'_salary_promo';
    $this->default = array(
      'id' => 0,
      'employid' => 0,
      'last_promo' => 0,
      'next_promo' => 0,
      'note' => '',
      'file' => ''
    );
  }

  // id, employid, note, file, time, next_time
  function insert($data) {
    $time = totime($data['time']);
    $next_time = $time + 60 * 60 * 24 * 365.25 * 5; // sau 5 nam bao lai

    $sql = 'insert into `'. $this->prefix .'` (employid, note, time, next_time, file) values('. $data['employid'] .', "'. $data['note'] .'", '. $time .', '. $next_time .', "'. $data['file'] .'")';

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  function remove($employid) {
    $sql = 'delete from `'. $this->prefix .'` where employid = '. $employid;

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  public function promo_content() {
    $xtpl = new XTemplate("promo-list.tpl", PATH2);

    $employ_list = $this->employ->get_list();
    $index = 1;
    $time = time();
    foreach ($employ_list as $employid => $employ) {
      $promo = $this->get_last_promo($employid);
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $promo['id']);
      $xtpl->assign('employid', $employid);
      $xtpl->assign('name', $employ);
      $xtpl->assign('last_promo', $this->parse_time($promo['time']));
      $xtpl->assign('next_promo', $this->parse_time($promo['next_time']));
      $xtpl->assign('note', $promo['note']);
      $xtpl->assign('file', $promo['file']);
      if ($time > $promo['next_time']) $xtpl->assign('color', 'red');
      else $xtpl->assign('color', '');
      if (strlen($promo['file'])) $xtpl->parse('main.row.file');
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  public function history($employid) {
    $xtpl = new XTemplate("promo-history.tpl", PATH2);

    $list = $this->promo_employ($employid);
    $index = 1;
    foreach ($list as $promo) {
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $promo['id']);
      $xtpl->assign('last_promo', $this->parse_time($promo['time']));
      $xtpl->assign('next_promo', $this->parse_time($promo['next_time']));
      $xtpl->assign('note', $promo['note']);
      $xtpl->assign('file', $promo['file']);
      if (strlen($promo['file'])) $xtpl->parse('main.row.file');
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  public function promo_employ($employid) {
    $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
    $query = $this->db->query($sql);

    $list = array();
    while ($promo = $query->fetch()) {
      $list []= $promo;
    }
    return $list;
  }

  public function get_last_promo($employid) {
    $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
    $query = $this->db->query($sql);
    $promo = $query->fetch();
    if (empty($promo)) return $this->default;
    return $promo;
  }

  public function parse_time($time) {
    if (intval($time) > 0) return date('d/m/Y', $time);
    return 'Chưa bổ nhiệm';
  }
}
