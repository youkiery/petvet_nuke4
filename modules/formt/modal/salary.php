<?php
include_once(MODAL_PATH . '/remind.php');
class Salary {
  public $remind;
  public $prefix;
  public $db;
  public function __construct() {
    global $db;

    $this->db = $db;
    $this->remind = new Remind();
    $this->prefix = PREFIX .'_salary';
    $this->default = array(
      'id' => 0,
      'employ' => '',
      'level' => 0,
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
    $next_time = totime($data['next_time']);
    $this->remind->check($data['name'], 'employ');
    $this->remind->check($data['formal'], 'formal');

    $sql = 'insert into `'. $this->prefix .'` (employ, formal, note, level, time, next_time, file) values("'. $data['name'] .'", "'. $data['formal'] .'", "'. $data['note'] .'", "'. $data['level'] .'", '. $time .', '. $next_time .', "'. $data['file'] .'")';

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  function remove($id) {
    $sql = 'delete from `'. $this->prefix .'` where id = '. $id;

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  // public function history($employid) {
  //   $xtpl = new XTemplate("salary-history.tpl", PATH2);

  //   $list = $this->salary_employ($employid);
  //   $index = 1;
  //   foreach ($list as $salary) {
  //     $xtpl->assign('index', $index++);
  //     $xtpl->assign('id', $salary['id']);
  //     $xtpl->assign('last_salary', $this->parse_time($salary['time']));
  //     $xtpl->assign('next_salary', $this->parse_time($salary['next_time']));
  //     $xtpl->assign('formal', $salary['formal']);
  //     $xtpl->assign('note', $salary['note']);
  //     $xtpl->assign('file', $salary['file']);
  //     if (strlen($salary['file'])) $xtpl->parse('main.row.file');
  //     $xtpl->parse('main.row');
  //   }
  //   $xtpl->parse('main');
  //   return $xtpl->text();
  // }

  // public function salary_employ($employid) {
  //   $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
  //   $query = $this->db->query($sql);

  //   $list = array();
  //   while ($salary = $query->fetch()) {
  //     $list []= $salary;
  //   }
  //   return $list;
  // }

  public function salary_content() {
    global $filter, $user_info, $const;
    $xtpl = new XTemplate("salary-list.tpl", PATH2);

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
    if (in_array('1', $user_info['in_groups'])) $check = true;
    else $check = false;

    while ($salary = $query->fetch()) {
      $check_time = strtotime(date('Y/1/1', $salary['next_time']));
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $salary['id']);
      $xtpl->assign('employ', $salary['employ']);
      $xtpl->assign('last_salary', $this->parse_time($salary['time']));
      $xtpl->assign('next_salary', $this->parse_time($salary['next_time']));
      $xtpl->assign('level_const', $salary['level']);
      $xtpl->assign('level', getLevel($salary['level']));
      $xtpl->assign('formal', $salary['formal']);
      $xtpl->assign('note', $salary['note']);
      $xtpl->assign('file', $salary['file']);
      if ($time > $check_time) $xtpl->assign('color', 'red');
      else $xtpl->assign('color', '');
      if (strlen($salary['file'])) $xtpl->parse('main.row.file');
      if ($check) $xtpl->parse('main.row.manager');
      $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
  }

  // public function employ_content() {
  //   $xtpl = new XTemplate("employ-content.tpl", PATH2);

  //   $employ_list = $this->employ->get_list();
  //   $index = 1;
  //   foreach ($employ_list as $employid => $employ) {
  //     $xtpl->assign('index', $index++);
  //     $xtpl->assign('id', $employid);
  //     $xtpl->assign('name', $employ);
  //     $xtpl->parse('main.row');
  //   }
  //   $xtpl->assign('nav', navi_generater($number, $filter['page'], $filter['limit']));
  //   $xtpl->parse('main');
  //   return $xtpl->text();
  // }

  // public function get_last_salary($employid) {
  //   $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
  //   $query = $this->db->query($sql);
  //   $salary = $query->fetch();
  //   if (empty($salary)) return $this->default;
  //   return $salary;
  // }

  public function parse_time($time) {
    if (intval($time) > 0) return date('d/m/Y', $time);
    return 'Chưa nâng lương';
  }
}
