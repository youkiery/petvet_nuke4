<!-- BEGIN: main -->
<style>
  .form-group {
    clear: both;
  }
  .box-bordered {
    margin: auto; border: 1px solid lightgray; border-radius: 10px; padding: 10px;
  }

  .vetleft,
  .vetright {
    position: absolute;
    top: 0px;
    width: 135px;
    text-align: center;
  }

  .vetleft {
    left: 0px;
  }

  .vetright {
    right: 0px;
  }

  .vetleft img,
  .vetright img {
    width: 75px !important;
  }

  label {
    font-weight: normal;
  }

  @media screen and (max-width: 992px) {

    .vetleft,
    .vetright {
      position: unset;
      display: inline-block;
      width: 100%;
    }
  }

  @media screen and (max-width: 768px) {
    .checkbox input[type=checkbox] {
      position: inherit;
      margin-left: inherit;
    }
  }

  @media screen and (max-width: 600px) {

    .vetleft img,
    .vetright img {
      width: 50px !important;
    }

    .hideout {
      display: none;
    }
  }
</style>
<div class="container" style="margin-top: 20px;">
  <div id="msgshow"></div>
  <div class="text-center">
    <img src="" alt="">
  </div>

  <!-- <div style="position: fixed; background: red; width: 100px; height: 100px;"></div>
  <div style="position: fixed; background: blue; right: calc(25% - 125px); width: 100px; height: 100px;"></div> -->

  <div id="content" style="position: relative;">
    <div class="vetleft">
      <img src="/assets/images/1.jpg">
      <p style="font-weight: bold; margin: 14px; font-size: 1.25em; color: deepskyblue; text-shadow: 2px 2px 6px;">Đăng
        ký khóa học thú y</p>
    </div>
    <div>
      <div class="box-bordered" style="max-width: 500px;">
        <div class="text-center" style="font-size: 1.5em; color: green; margin-bottom: 20px;"> <b> Mẫu đăng ký </b>
        </div>
        <div class="form-group">
          <label class="label-control"> Họ và tên </label>
          <div>
            <input type="text" class="form-control" id="signup-name">
          </div>
        </div>
        <div class="form-group">
          <label class="label-control"> Địa chỉ </label>
          <div>
            <input type="text" class="form-control" id="signup-address">
          </div>
        </div>
        <div class="form-group">
          <label class="label-control"> Số điện thoại </label>
          <div class="relative">
            <input type="text" class="form-control" id="signup-mobile">
          </div>
        </div>
        <div class="form-group">
          <label class="label-control"> Môn học đăng ký </label><br>
          <!-- BEGIN: court -->
          <label>
            <input type="checkbox" name="court" value="{id}"> {court} <br>
          </label>
          <!-- END: court -->
        </div>
        <div style="clear: both;"></div>
        <div class="text-center">
          <button class="btn btn-success" onclick="signupPresubmit()">
            Đăng ký
          </button>
          <div id="notify" style="color: red; font-size: 1.3em; font-weight: bold;"> </div>
        </div>
      </div>
      <div></div>
    </div>
    <div class="vetright">
      <img src="/assets/images/2.jpg">
      <p style="font-weight: bold; margin: 14px; font-size: 1.25em; color: deepskyblue; text-shadow: 2px 2px 6px;"> Đăng ký khóa học thú y</p>
    </div>
    <br>
    <div class="box-bordered" style="max-width: 500px;">
      <p>BỆNH VIỆN THÚ CƯNG THANH XUÂN</p>
      <p>Địa chỉ: 12-14 Lê Đại Hành, Buôn Ma Thuột</p>
      <p>Số điện thoại: 02626.290.609</p>
    </div>
  </div>
  <div class="box-bordered" id="notify-content" style="display: none;">
    <p>Bạn đã đăng ký thành công <span id="regiesting"></span>, chúng tôi sẽ liên hệ với bạn theo số điện thoại cung cấp để thông báo về lịch học cùng các vấn đề liên quan</p>
    <p>
      Các khóa học bạn đã đăng ký: <span id="regiested"></span>
    </p>
    <p class="text-center">
      Bạn có thể muốn: <br>
      <a href="/contest"> Đăng ký thêm </a> |
      <a href="/"> Trở về trang chủ </a>
    </p>
  </div>
</div>
<script>
  function signupPresubmit() {
    data = checkSignupData()
    if (!data['name']) {
      notify(data)
    }
    else {
      $.post(
        '',
        { action: 'signup', data: data },
        (response, status) => {
          checkResult(response, status).then(data => {
            // hiển thị thông báo liên hệ
            $("#regiesting").html(data['data']['no'].join(', '))
            $("#regiested").html(data['data']['list'].join(', '))
            $("#content").hide()
            $("#notify-content").show()
          })
        }
      )
    }
  }

  function checkSignupData() {
    name = $("#signup-name").val()
    address = $("#signup-address").val()
    mobile = $("#signup-mobile").val()
    court = []
    $("[name=court]:checked").each((index, item) => {
      console.log(item);
      court.push(item.value)
    })
    if (!name.length) return 'Nhập tên người dùng'
    if (!mobile.length) return 'Số điện thoại không được để trống'
    if (!court.length) return 'Chọn ít nhất 1 khóa học'
    return {
      name: name,
      address: address,
      mobile: mobile,
      court: court,
    }
  }

  function notify(text) {
    $("#notify").show()
    $("#notify").text(text)
    $("#notify").delay(1000).fadeOut(1000)
  }
</script>
<!-- END: main -->