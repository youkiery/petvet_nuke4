<?php
include_once(MODAL_PATH . '/remind.php');
class Promo {
  public $remind;
  public $prefix;
  public $db;
  public function __construct() {
    global $db;

    $this->db = $db;
    $this->remind = new Remind();
    $this->prefix = PREFIX .'_salary_promo';
    $this->default = array(
      'id' => 0,
      'employ' => '',
      'last_promo' => 0,
      'next_promo' => 0,
      'note' => '',
      'file' => ''
    );
  }

  // id, employid, note, file, time, next_time
  function insert($data) {
    $time = totime($data['time']);
    $next_time = totime($data['next_time']);
    $this->remind->check($data['name'], 'employ');

    $sql = 'insert into `'. $this->prefix .'` (employ, note, time, next_time, file) values("'. $data['name'] .'", "'. $data['note'] .'", '. $time .', '. $next_time .', "'. $data['file'] .'")';

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  function remove($id) {
    $sql = 'delete from `'. $this->prefix .'` where id = '. $id;

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  public function promo_content() {
    global $filter, $user_info, $user_list;
    $xtpl = new XTemplate("promo-list.tpl", PATH2);

    $xtra = array('employ like "%'. $filter['name'] .'%"');
    $tick = 0;
    if ($filter['timestart']) $tick += 1;
    if ($filter['timeend']) $tick += 2;
    switch ($tick) {
      case 1:
        $filter['timestart'] = totime($filter['timestart']);
        $xtra []= 'time > '. $filter['timestart'];
        break;
      case 2:
        $filter['timeend'] = totime($filter['timeend']);
        $xtra []= 'time < '. $filter['timeend'];
        break;
      case 3:
        $filter['timestart'] = totime($filter['timestart']);
        $filter['timeend'] = totime($filter['timeend']);
        $xtra []= '(time between '. $filter['timestart'] . ' and '. $filter['timeend'] .')';
        break;
    }

    $tick = 0;
    if ($filter['nexttimestart']) $tick += 1;
    if ($filter['nexttimeend']) $tick += 2;
    switch ($tick) {
      case 1:
        $filter['nexttimestart'] = totime($filter['nexttimestart']);
        $xtra []= 'next_time > '. $filter['nexttimestart'];
        break;
      case 2:
        $filter['nexttimeend'] = totime($filter['nexttimeend']);
        $xtra []= 'next_time < '. $filter['nexttimeend'];
        break;
      case 3:
        $filter['nexttimestart'] = totime($filter['nexttimestart']);
        $filter['nexttimeend'] = totime($filter['nexttimeend']);
        $xtra []= '(next_time between '. $filter['nexttimestart'] . ' and '. $filter['nexttimeend'] .')';
        break;
    }

    $sql = 'select count(id) as number from `'. $this->prefix .'` where ' . implode(' and ', $xtra);
    $query = $this->db->query($sql);
    $number = $query->fetch()['number'];

    $sql = 'select * from `'. $this->prefix .'` where ' . implode(' and ', $xtra) .' order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
    $query = $this->db->query($sql);
    $index = ($filter['page'] - 1) * $filter['limit'] + 1;
    $time = time();
    if (in_array($user_info['userid'], $user_list)) $check = true;
    else $check = false;

    while ($promo = $query->fetch()) {
      $check_time = strtotime(date('Y/1/1', $promo['next_time']));
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $promo['id']);
      $xtpl->assign('employ', $promo['employ']);
      $xtpl->assign('last_promo', $this->parse_time($promo['time']));
      $xtpl->assign('next_promo', $this->parse_time($promo['next_time']));
      $xtpl->assign('note', $promo['note']);
      $xtpl->assign('file', $promo['file']);
      if ($time > $check_time) $xtpl->assign('color', 'red');
      else $xtpl->assign('color', '');
      if (strlen($promo['file'])) $xtpl->parse('main.row.file');
      if ($check) $xtpl->parse('main.row.manager');
      $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', navi_generater($number, $filter['page'], $filter['limit']));
    $xtpl->parse('main');
    return $xtpl->text();
  }

  // public function history($employid) {
  //   $xtpl = new XTemplate("promo-history.tpl", PATH2);

  //   $list = $this->promo_employ($employid);
  //   $index = 1;
  //   foreach ($list as $promo) {
  //     $xtpl->assign('index', $index++);
  //     $xtpl->assign('id', $promo['id']);
  //     $xtpl->assign('last_promo', $this->parse_time($promo['time']));
  //     $xtpl->assign('next_promo', $this->parse_time($promo['next_time']));
  //     $xtpl->assign('note', $promo['note']);
  //     $xtpl->assign('file', $promo['file']);
  //     if (strlen($promo['file'])) $xtpl->parse('main.row.file');
  //     $xtpl->parse('main.row');
  //   }
  //   $xtpl->parse('main');
  //   return $xtpl->text();
  // }

  // public function promo_employ($employid) {
  //   $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
  //   $query = $this->db->query($sql);

  //   $list = array();
  //   while ($promo = $query->fetch()) {
  //     $list []= $promo;
  //   }
  //   return $list;
  // }

  // public function get_last_promo($employid) {
  //   $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
  //   $query = $this->db->query($sql);
  //   $promo = $query->fetch();
  //   if (empty($promo)) return $this->default;
  //   return $promo;
  // }

  public function parse_time($time) {
    if (intval($time) > 0) return date('d/m/Y', $time);
    return 'Chưa bổ nhiệm';
  }
}
