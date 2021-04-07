<?php
class Staff extends Core {
  function __construct() {
    parent::__construct();
  }

  /**
   * 1. lấy danh sách
   *  danh sách chưa gọi, đã gọi, đã tiêm
   *  danh sách cần nhắc
   *  danh sách thêm hôm nay
   *  danh sách hôm nay tiêm phòng
   * 2. lấy danh sách bác sĩ
   * 3. lấy danh sách bệnh
   * 4. thêm danh vaccine
   *  kiểm tra danh sách đã tiêm chưa nhắc
   *  xác nhận danh sách 
   * 5. ghi chú
   * 6. bỏ, có xác nhận
   * 
   */

   
  // id, petid, diseaseid, cometime, calltime, note, status, recall, doctorid, ctime

  function viewVaccineList() {
    // lọc danh sách theo ngày, status
    // quá hạn đẩy lên trước
    $today = strtotime(date('Y/m/d')) + 60 * 60 * 24;
    $sql = 'select * from pet_test_vaccine where calltime > '. $today .' and status < 2 order by calltime desc';
    $overtimeList = $this->db->fetchall($sql);

    $sql = 'select * from pet_test_vaccine where calltime <= '. $today .' and status < 2 order by calltime desc';
    $list = $this->db->fetchall($sql);
    $list = array_merge($overtimeList, $list);

    $xtpl = new XTemplate('');
  }


}
