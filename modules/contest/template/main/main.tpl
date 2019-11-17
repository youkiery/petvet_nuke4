<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<style>
  .form-group {
    overflow: auto;
  }
</style>

<div id="msgshow"></div>

<div class="modal" id="modal-signup" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        <div class="form-group">
          <label class="label-control col-sm-8"> Tên người/đơn vị đăng ký </label>
          <div class="col-sm-16">
            <input type="text" class="form-control" id="signup-name">
          </div>
        </div>

        <div class="form-group">
          <label class="label-control col-sm-8"> Địa chỉ </label>
          <div class="col-sm-16">
            <input type="text" class="form-control" id="signup-address">
          </div>
        </div>

        <div class="form-group">
          <label class="label-control col-sm-8"> Số điện thoại </label>
          <div class="col-sm-16">
            <input type="text" class="form-control" id="signup-mobile">
          </div>
        </div>

        <div class="form-group">
          <label class="label-control col-sm-8"> Phần thi đăng ký </label>
          <div class="col-sm-16 checkbox">
            <!-- BEGIN: test -->
            <label style="margin-right: 10px;"> <input type="checkbox" name="test" index="{id}"> {name} </label>
            <!-- END: test -->
          </div>
        </div>

        <div class="text-center">
          <button class="btn btn-success" onclick="signupPresubmit()">
            Đăng ký
          </button>
        </div>

      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal-presignup" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div type="button" class="close" data-dismiss="modal"> &times; </div> <br>
        
        <div class="text-center">
          <p> Xác nhận thông tin đăng ký </p>
          <p> Sau khi xác nhận, thông tin dưới đây sẽ không thể thay đổi </p>
          <button class="btn btn-info" onclick="signupSubmit()">
            Xác nhận đăng ký
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="content">
  <p> <span> Đăng ký phần thi cuộc thi </span> <button class="btn btn-info" onclick="signup()"> Đăng ký </button> </p>
</div>

<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  function signup() {
    $("#modal-signup").modal('show')
  }
  function signupPresubmit() {
    data = checkSignupData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $("#modal-presignup").modal('show')
    }
  }

  function checkSignupData() {
    test = []
    name = $("#signup-name").val()
    address = $("#signup-address").val()
    mobile = $("#signup-mobile").val()
    if (!name.length) return 'Tên người/đơn vị không được để trống'
    if (!address.length) return 'Địa chỉ không được để trống'
    if (!mobile.length) return 'Số điện thoại không được để trống'
    $("[name=test]").each((index, item) => {
      indexkey = item.getAttribute('index')
      if (item.checked) test.push(indexkey)
    })
    if (!test.length) return 'Chọn ít nhất 1 phần thi'
    return {
      name: name,
      address: address,
      mobile: mobile,
      test: test
    }
  }

  function signupSubmit() {
    data = checkSignupData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $.post(
        '',
        { action: 'signup', data: data },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#modal-signup").modal('hide')
            $("#modal-presignup").modal('hide')
            $("#content").html(data['notify'])
            // $("#signup-name").val('')
            // $("#signup-address").val('')
            // $("#signup-mobile").val('')
            // $("[name=test]").each((index, item) => {
            //   item.checked = false
            // })
          })
        }
      )
    }
  }
</script>
<!-- END: main -->
