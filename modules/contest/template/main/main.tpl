<!-- BEGIN: main -->
<style>
  .form-group { clear: both; }
  .vetleft, .vetright { position: absolute; top: 0px; width: 135px; text-align: center; }
  .vetleft { left: 0px; }
  .vetright { right: 0px; }
  .vetleft img, .vetright img {
    width: 75px !important;
  }
  label {
    font-weight: normal;
  }

  @media screen and (max-width: 992px) {
    .vetleft, .vetright { position: unset; display: inline-block; width: 100%; }
  }

  @media screen and (max-width: 768px) {
    .checkbox input[type=checkbox] {
      position: inherit;
      margin-left: inherit;
    }
  }
  @media screen and (max-width: 600px) {
    .vetleft img, .vetright img { width: 50px !important; }
    .hideout {
      display: none;
    }
  }
</style>
<div class="container" style="margin-top: 20px;">
  <div id="msgshow"></div>

  <!-- <div style="position: fixed; background: red; width: 100px; height: 100px;"></div>
  <div style="position: fixed; background: blue; right: calc(25% - 125px); width: 100px; height: 100px;"></div> -->

  <div id="content" style="position: relative;">
    <div>
      <div style="max-width: 500px; margin: auto; border: 1px solid lightgray; border-radius: 10px; padding: 10px 10px 10px 10px;">
        <div class="text-center" style="font-size: 1.5em; color: green; margin-bottom: 20px;"> <b> Mẫu đăng ký </b> </div>
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
          <label class="label-control"> Môn học đăng ký </label>
          <select class="form-control" id="signup-court">
            <!-- BEGIN: court -->
            <option value="{id}"> {court} </option>
            <!-- END: court -->
          </select>
        </div>
        <div style="clear: both;"></div>
        <div class="text-center">
          <button class="btn btn-success" onclick="signupPresubmit()">
            Đăng ký
          </button>
          <div id="notify" style="color: red; font-size: 1.3em; font-weight: bold;">  </div>
        </div>
      </div>
      <div></div>
    </div>
<script>
  var global = {
    'species': JSON.parse('{species}'),
    'page': 1,
  }

  $(document).ready(() => {
    installSuggest('signup', 'species')
  })

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
            $("#modal-presignup").modal('hide')
          })
        }
      )
    }
  }

  function checkSignupData() {
    name = $("#signup-name").val()
    address = $("#signup-address").val()
    mobile = $("#signup-mobile").val()
    court = $("#signup-court").val()
    if (!name.length) return 'Nhập tên người dùng'
    if (!mobile.length) return 'Số điện thoại không được để trống'
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
