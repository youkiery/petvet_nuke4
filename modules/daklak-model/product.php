<?php
class Product extends Core {
  function __construct() {
    parent::__construct();
  }

  function getById($id) {
    $sql = "select * from pet_daklak_product where id = $id";
    return $this->db->fetch($sql);
  }

  function content($filter) {
    $sql = "select * from pet_daklak_product where keyword = $filter[keyword] and catid = $filter[catid] limit $filter[limit] offset". ($filter['page'] - 1) * $filter['limit'];
    $list = $this->fetchall($sql);

    $xtpl = new XTemplate("/product/content.tpl", VIEW);
    foreach ($list as $data) {
      $xtpl->assign('id', $data['id']);
      $xtpl->assign('code', $data['code']);
      $xtpl->assign('name', $data['name']);
      $xtpl->assign('image', $data['image']);
      $xtpl->assign('werehouse', $data['n1'] + $data['n2']);
      $xtpl->assign('limitup', $data['limitup']); // giới hạn trên, dưới thì nhập hàng
      $xtpl->assign('limitdown', $data['limitdown']); // giới hạn dưới, dưới thì chuyển hàng
      $xtpl->parse("main.row");
    }
    $xtpl->parse("main.row");
    return $xtpl->text();
  }
}
