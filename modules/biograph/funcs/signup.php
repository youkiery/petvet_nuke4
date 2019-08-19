<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}
define('BUILDER_INSERT', 0);
define('BUILDER_EDIT', 1);

$page_title = "autoload";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (!empty($userinfo)) {
  if ($userinfo['center']) {
    header('location: /biograph/center');
  }
  header('location: /biograph/private');
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'signup':
			$data = $nv_Request->get_array('data', 'post');

			if (checkObj($data)) {
				$data['username'] = strtolower($data['username']);
				if (!checkLogin($data['username'], $data['password'])) {
          // remove prefix
          $sql = 'select * from `'. PREFIX .'_user` where mobile = "'. $data['phone'] .'"';
          $query = $db->query($sql);

          if (empty($query->fetch())) {
            $sql = 'insert into `'. PREFIX .'_user` (username, password, fullname, mobile, politic, address, active, image) values("'. $data['username'] .'", "'. md5($data['password']) .'", "'. $data['fullname'] .'", "'. $data['phone'] .'", "'. $data['politic'] .'", "'. $data['address'] .'", 1, "")';
            if ($db->query($sql)) {
              $_SESSION['username']	 = $data['username'];
              $_SESSION['password'] = $data['password'];
              $result['status'] = 1;
            }
          }
          else {
            $result['error'] = 'Số điện thoại đã được sử dụng';
          }
				}
        else {
					$result['error'] = 'Tên đăng nhập hoặc mật khẩu không đúng';
        }
			}
		break;
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$global = array();
$global['login'] = 0;
$position = json_decode('[{"name":"Hồ Chí Minh","district":["Bình Chánh","Bình Tân","Bình Thạnh","Cần Giờ","Củ Chi","Gò Vấp","Hóc Môn","Nhà Bè","Phú Nhuận","Quận 1","Quận 10","Quận 11","Quận 12","Quận 2","Quận 3","Quận 4","Quận 5","Quận 6","Quận 7","Quận 8","Quận 9","Tân Bình","Tân Phú","Thủ Đức"]},{"name":"Hà Nội","district":["Ba Đình","Ba Vì","Bắc Từ Liêm","Cầu Giấy","Chương Mỹ","Đan Phượng","Đông Anh","Đống Đa","Gia Lâm","Hà Đông","Hai Bà Trưng","Hoài Đức","Hoàn Kiếm","Hoàng Mai","Long Biên","Mê Linh","Mỹ Đức","Nam Từ Liêm","Phú Xuyên","Phúc Thọ","Quốc Oai","Sóc Sơn","Sơn Tây","Tây Hồ","Thạch Thất","Thanh Oai","Thanh Trì","Thanh Xuân","Thường Tín","Ứng Hòa"]},{"name":"Đà Nẵng","district":["Cẩm Lệ","Hải Châu","Hòa Vang","Hoàng Sa","Liên Chiểu","Ngũ Hành Sơn","Sơn Trà","Thanh Khê"]},{"name":"Bình Dương","district":["Bàu Bàng","Bến Cát","Dầu Tiếng","Dĩ An","Phú Giáo","Tân Uyên","Thủ Dầu Một","Thuận An"]},{"name":"Đồng Nai","district":["Biên Hòa","Cẩm Mỹ","Định Quán","Long Khánh","Long Thành","Nhơn Trạch","Tân Phú","Thống Nhất","Trảng Bom","Vĩnh Cửu","Xuân Lộc"]},{"name":"Khánh Hòa","district":["Cam Lâm","Cam Ranh","Diên Khánh","Khánh Sơn","Khánh Vĩnh","Nha Trang","Ninh Hòa","Trường Sa","Vạn Ninh"]},{"name":"Hải Phòng","district":["An Dương","An Lão","Bạch Long Vĩ","Cát Hải","Dương Kinh","Đồ Sơn","Hải An","Hồng Bàng","Kiến An","Kiến Thụy","Lê Chân","Ngô Quyền","Thủy Nguyên","Tiên Lãng","Vĩnh Bảo"]},{"name":"Long An","district":["Bến Lức","Cần Đước","Cần Giuộc","Châu Thành","Đức Hòa","Đức Huệ","Kiến Tường","Mộc Hóa","Tân An","Tân Hưng","Tân Thạnh","Tân Trụ","Thạnh Hóa","Thủ Thừa","Vĩnh Hưng"]},{"name":"Quảng Nam","district":["Bắc Trà My","Duy Xuyên","Đại Lộc","Điện Bàn","Đông Giang","Hiệp Đức","Hội An","Nam Giang","Nam Trà My","Nông Sơn","Núi Thành","Phú Ninh","Phước Sơn","Quế Sơn","Tam Kỳ","Tây Giang","Thăng Bình","Tiên Phước"]},{"name":"Bà Rịa Vũng Tàu","district":["Bà Rịa","Châu Đức","Côn Đảo","Đất Đỏ","Long Điền","Tân Thành","Vũng Tàu","Xuyên Mộc"]},{"name":"Đắk Lắk","district":["Buôn Đôn","Buôn Hồ","Buôn Ma Thuột","Cư Kuin","Cư Mgar","Ea HLeo","Ea Kar","Ea Súp","Krông Ana","Krông Bông","Krông Buk","Krông Năng","Krông Pắc","Lăk","MĐrăk"]},{"name":"Cần Thơ","district":[" Thới Lai","Bình Thủy","Cái Răng","Cờ Đỏ","Ninh Kiều","Ô Môn","Phong Điền","Thốt Nốt","Vĩnh Thạnh"]},{"name":"Bình Thuận  ","district":["Bắc Bình","Đảo Phú Quý","Đức Linh","Hàm Tân","Hàm Thuận Bắc","Hàm Thuận Nam","La Gi","Phan Thiết","Tánh Linh","Tuy Phong"]},{"name":"Lâm Đồng","district":["Bảo Lâm","Bảo Lộc","Cát Tiên","Di Linh","Đạ Huoai","Đà Lạt","Đạ Tẻh","Đam Rông","Đơn Dương","Đức Trọng","Lạc Dương","Lâm Hà"]},{"name":"Thừa Thiên Huế","district":["A Lưới","Huế","Hương Thủy","Hương Trà","Nam Đông","Phong Điền","Phú Lộc","Phú Vang","Quảng Điền"]},{"name":"Kiên Giang","district":["An Biên","An Minh","Châu Thành","Giang Thành","Giồng Riềng","Gò Quao","Hà Tiên","Hòn Đất","Kiên Hải","Kiên Lương","Phú Quốc","Rạch Giá","Tân Hiệp","U minh Thượng","Vĩnh Thuận"]},{"name":"Bắc Ninh","district":["Bắc Ninh","Gia Bình","Lương Tài","Quế Võ","Thuận Thành","Tiên Du","Từ Sơn","Yên Phong"]},{"name":"Quảng Ninh","district":["Ba Chẽ","Bình Liêu","Cẩm Phả","Cô Tô","Đầm Hà","Đông Triều","Hạ Long","Hải Hà","Hoành Bồ","Móng Cái","Quảng Yên","Tiên Yên","Uông Bí","Vân Đồn"]},{"name":"Thanh Hóa","district":["Bá Thước","Bỉm Sơn","Cẩm Thủy","Đông Sơn","Hà Trung","Hậu Lộc","Hoằng Hóa","Lang Chánh","Mường Lát","Nga Sơn","Ngọc Lặc","Như Thanh","Như Xuân","Nông Cống","Quan Hóa","Quan Sơn","Quảng Xương","Sầm Sơn","Thạch Thành","Thanh Hóa","Thiệu Hóa","Thọ Xuân","Thường Xuân","Tĩnh Gia","Triệu Sơn","Vĩnh Lộc","Yên Định"]},{"name":"Nghệ An","district":["Anh Sơn","Con Cuông","Cửa Lò","Diễn Châu","Đô Lương","Hoàng Mai","Hưng Nguyên","Kỳ Sơn","Nam Đàn","Nghi Lộc","Nghĩa Đàn","Quế Phong","Quỳ Châu","Quỳ Hợp","Quỳnh Lưu","Tân Kỳ","Thái Hòa","Thanh Chương","Tương Dương","Vinh","Yên Thành"]},{"name":"Hải Dương","district":["Bình Giang","Cẩm Giàng","Chí Linh","Gia Lộc","Hải Dương","Kim Thành","Kinh Môn","Nam Sách","Ninh Giang","Thanh Hà","Thanh Miện","Tứ Kỳ"]},{"name":"Gia Lai","district":["An Khê","AYun Pa","Chư Păh","Chư Pưh","Chư Sê","ChưPRông","Đăk Đoa","Đăk Pơ","Đức Cơ","Ia Grai","Ia Pa","KBang","Kông Chro","Krông Pa","Mang Yang","Phú Thiện","Plei Ku"]},{"name":"Bình Phước","district":["Bình Long","Bù Đăng","Bù Đốp","Bù Gia Mập","Chơn Thành","Đồng Phú","Đồng Xoài","Hớn Quản","Lộc Ninh","Phú Riềng","Phước Long"]},{"name":"Hưng Yên","district":["Ân Thi","Hưng Yên","Khoái Châu","Kim Động","Mỹ Hào","Phù Cừ","Tiên Lữ","Văn Giang","Văn Lâm","Yên Mỹ"]},{"name":"Bình Định","district":["An Lão","An Nhơn","Hoài Ân","Hoài Nhơn","Phù Cát","Phù Mỹ","Quy Nhơn","Tây Sơn","Tuy Phước","Vân Canh","Vĩnh Thạnh"]},{"name":"Tiền Giang","district":["Cái Bè","Cai Lậy","Châu Thành","Chợ Gạo","Gò Công","Gò Công Đông","Gò Công Tây","Huyện Cai Lậy","Mỹ Tho","Tân Phú Đông","Tân Phước"]},{"name":"Thái Bình","district":["Đông Hưng","Hưng Hà","Kiến Xương","Quỳnh Phụ","Thái Bình","Thái Thuỵ","Tiền Hải","Vũ Thư"]},{"name":"Bắc Giang","district":["Bắc Giang","Hiệp Hòa","Lạng Giang","Lục Nam","Lục Ngạn","Sơn Động","Tân Yên","Việt Yên","Yên Dũng","Yên Thế"]},{"name":"Hòa Bình","district":["Cao Phong","Đà Bắc","Hòa Bình","Kim Bôi","Kỳ Sơn","Lạc Sơn","Lạc Thủy","Lương Sơn","Mai Châu","Tân Lạc","Yên Thủy"]},{"name":"An Giang","district":["An Phú","Châu Đốc","Châu Phú","Châu Thành","Chợ Mới","Long Xuyên","Phú Tân","Tân Châu","Thoại Sơn","Tịnh Biên","Tri Tôn"]},{"name":"Vĩnh Phúc","district":["Bình Xuyên","Lập Thạch","Phúc Yên","Sông Lô","Tam Dương","Tam Đảo","Vĩnh Tường","Vĩnh Yên","Yên Lạc"]},{"name":"Tây Ninh","district":["Bến Cầu","Châu Thành","Dương Minh Châu","Gò Dầu","Hòa Thành","Tân Biên","Tân Châu","Tây Ninh","Trảng Bàng"]},{"name":"Thái Nguyên","district":["Đại Từ","Định Hóa","Đồng Hỷ","Phổ Yên","Phú Bình","Phú Lương","Sông Công","Thái Nguyên","Võ Nhai"]},{"name":"Lào Cai","district":["Bắc Hà","Bảo Thắng","Bảo Yên","Bát Xát","Lào Cai","Mường Khương","Sa Pa","Văn Bàn","Xi Ma Cai"]},{"name":"Nam Định","district":["Giao Thủy","Hải Hậu","Mỹ Lộc","Nam Định","Nam Trực","Nghĩa Hưng","Trực Ninh","Vụ Bản","Xuân Trường","Ý Yên"]},{"name":"Quảng Ngãi","district":["Ba Tơ","Bình Sơn","Đức Phổ","Lý Sơn","Minh Long","Mộ Đức","Nghĩa Hành","Quảng Ngãi","Sơn Hà","Sơn Tây","Sơn Tịnh","Tây Trà","Trà Bồng","Tư Nghĩa"]},{"name":"Bến Tre","district":["Ba Tri","Bến Tre","Bình Đại","Châu Thành","Chợ Lách","Giồng Trôm","Mỏ Cày Bắc","Mỏ Cày Nam","Thạnh Phú"]},{"name":"Đắk Nông","district":["Cư Jút","Dăk GLong","Dăk Mil","Dăk RLấp","Dăk Song","Gia Nghĩa","Krông Nô","Tuy Đức"]},{"name":"Cà Mau","district":["Cà Mau","Cái Nước","Đầm Dơi","Năm Căn","Ngọc Hiển","Phú Tân","Thới Bình","Trần Văn Thời","U Minh"]},{"name":"Vĩnh Long","district":["Bình Minh","Bình Tân","Long Hồ","Mang Thít","Tam Bình","Trà Ôn","Vĩnh Long","Vũng Liêm"]},{"name":"Ninh Bình","district":["Gia Viễn","Hoa Lư","Kim Sơn","Nho Quan","Ninh Bình","Tam Điệp","Yên Khánh","Yên Mô"]},{"name":"Phú Thọ","district":["Cẩm Khê","Đoan Hùng","Hạ Hòa","Lâm Thao","Phù Ninh","Phú Thọ","Tam Nông","Tân Sơn","Thanh Ba","Thanh Sơn","Thanh Thủy","Việt Trì","Yên Lập"]},{"name":"Ninh Thuận","district":["Bác Ái","Ninh Hải","Ninh Phước","Ninh Sơn","Phan Rang - Tháp Chàm","Thuận Bắc","Thuận Nam"]},{"name":"Phú Yên","district":["Đông Hòa","Đồng Xuân","Phú Hòa","Sơn Hòa","Sông Cầu","Sông Hinh","Tây Hòa","Tuy An","Tuy Hòa"]},{"name":"Hà Nam","district":["Bình Lục","Duy Tiên","Kim Bảng","Lý Nhân","Phủ Lý","Thanh Liêm"]},{"name":"Hà Tĩnh","district":["Cẩm Xuyên","Can Lộc","Đức Thọ","Hà Tĩnh","Hồng Lĩnh","Hương Khê","Hương Sơn","Kỳ Anh","Lộc Hà","Nghi Xuân","Thạch Hà","Vũ Quang"]},{"name":"Đồng Tháp","district":["Cao Lãnh","Châu Thành","Hồng Ngự","Huyện Cao Lãnh","Huyện Hồng Ngự","Lai Vung","Lấp Vò","Sa Đéc","Tam Nông","Tân Hồng","Thanh Bình","Tháp Mười"]},{"name":"Sóc Trăng","district":["Châu Thành","Cù Lao Dung","Kế Sách","Long Phú","Mỹ Tú","Mỹ Xuyên","Ngã Năm","Sóc Trăng","Thạnh Trị","Trần Đề","Vĩnh Châu"]},{"name":"Kon Tum","district":["Đăk Glei","Đăk Hà","Đăk Tô","Ia HDrai","Kon Plông","Kon Rẫy","KonTum","Ngọc Hồi","Sa Thầy","Tu Mơ Rông"]},{"name":"Quảng Bình","district":["Ba Đồn","Bố Trạch","Đồng Hới","Lệ Thủy","Minh Hóa","Quảng Ninh","Quảng Trạch","Tuyên Hóa"]},{"name":"Quảng Trị","district":["Cam Lộ","Đa Krông","Đảo Cồn cỏ","Đông Hà","Gio Linh","Hải Lăng","Hướng Hóa","Quảng Trị","Triệu Phong","Vĩnh Linh"]},{"name":"Trà Vinh","district":["Càng Long","Cầu Kè","Cầu Ngang","Châu Thành","Duyên Hải","Tiểu Cần","Trà Cú","Trà Vinh"]},{"name":"Hậu Giang","district":["Châu Thành","Châu Thành A","Long Mỹ","Ngã Bảy","Phụng Hiệp","Vị Thanh","Vị Thủy"]},{"name":"Sơn La","district":["Bắc Yên","Mai Sơn","Mộc Châu","Mường La","Phù Yên","Quỳnh Nhai","Sơn La","Sông Mã","Sốp Cộp","Thuận Châu","Vân Hồ","Yên Châu"]},{"name":"Bạc Liêu","district":["Bạc Liêu","Đông Hải","Giá Rai","Hòa Bình","Hồng Dân","Phước Long","Vĩnh Lợi"]},{"name":"Yên Bái","district":["Lục Yên","Mù Cang Chải","Nghĩa Lộ","Trạm Tấu","Trấn Yên","Văn Chấn","Văn Yên","Yên Bái","Yên Bình"]},{"name":"Tuyên Quang","district":["Chiêm Hóa","Hàm Yên","Lâm Bình","Na Hang","Sơn Dương","Tuyên Quang","Yên Sơn"]},{"name":"Điện Biên","district":["Điện Biên","Điện Biên Đông","Điện Biên Phủ","Mường Ảng","Mường Chà","Mường Lay","Mường Nhé","Nậm Pồ","Tủa Chùa","Tuần Giáo"]},{"name":"Lai Châu","district":["Lai Châu","Mường Tè","Nậm Nhùn","Phong Thổ","Sìn Hồ","Tam Đường","Tân Uyên","Than Uyên"]},{"name":"Lạng Sơn","district":["Bắc Sơn","Bình Gia","Cao Lộc","Chi Lăng","Đình Lập","Hữu Lũng","Lạng Sơn","Lộc Bình","Tràng Định","Văn Lãng","Văn Quan"]},{"name":"Hà Giang","district":["Bắc Mê","Bắc Quang","Đồng Văn","Hà Giang","Hoàng Su Phì","Mèo Vạc","Quản Bạ","Quang Bình","Vị Xuyên","Xín Mần","Yên Minh"]},{"name":"Bắc Kạn","district":["Ba Bể","Bắc Kạn","Bạch Thông","Chợ Đồn","Chợ Mới","Na Rì","Ngân Sơn","Pác Nặm"]},{"name":"Cao Bằng","district":["Bảo Lạc","Bảo Lâm","Cao Bằng","Hạ Lang","Hà Quảng","Hòa An","Nguyên Bình","Phục Hòa","Quảng Uyên","Thạch An","Thông Nông","Trà Lĩnh","Trùng Khánh"]}]');

$xtpl = new XTemplate("signup.tpl", "modules/biograph/template");

foreach ($position as $l1i => $l1) {
	$xtpl->assign('l1name', $l1->{name});
	$xtpl->assign('l1id', $l1i);
	$xtpl->parse('main.l1');
  foreach ($l1->{district} as $l2i => $l2) {
    $xtpl->assign('l2name', $l2);
    $xtpl->assign('l2id', $l2i);
  	$xtpl->parse('main.l2.l2c');
  }

  if ($l1i == '0') {
    $xtpl->assign('active', 'block');
  }
  else {
    $xtpl->assign('active', 'none');
  }
  $xtpl->parse('main.l2');
}
// die();
$xtpl->assign('position', json_encode($position));

if (count($userinfo) > 0) {
	// logged
	$xtpl->assign('fullname', $userinfo['fullname']);
	$xtpl->assign('mobile', $userinfo['mobile']);
	$xtpl->assign('address', $userinfo['address']);
	$xtpl->assign('image', $userinfo['image']);
	$xtpl->assign('list', userDogRowByList($userinfo['id']));

	if (!empty($user_info) && !empty($user_info['userid']) && (in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {
		$xtpl->assign('userlist', userRowList());
	
		$xtpl->parse('main.log.user');
		$xtpl->parse('main.log.mod');
		$xtpl->parse('main.log.mod2');
	}

	$xtpl->parse('main.log');
}
else {
	$xtpl->parse('main.nolog');
}

$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");
