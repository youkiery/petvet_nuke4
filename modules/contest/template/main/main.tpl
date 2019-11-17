<!-- BEGIN: main -->
<style>
  .form-group {
    overflow: auto;
  }
</style>
<div class="container" style="margin-top: 20px;">
  <div id="msgshow"></div>
  <div style="float: right;">
    {FILE "heading.tpl"}
  </div>
  <div style="clear: right;"></div>
  <a href="/">
    <img src="/themes/default/images/banner.png" style="float: left; width: 200px;">
  </a>
  <form style="width: 60%; float: right;">
    <label class="input-group">
      <input type="hidden" name="nv" value="biograph">
      <input type="hidden" name="op" value="list">
      <input type="text" class="form-control" name="keyword" value="{keyword}" id="keyword" placeholder="Nhập tên hoặc mã số">
      <div class="input-group-btn">
        <button class="btn btn-info"> Tìm kiếm </button>
      </div>
    </label>
  </form>
  <div style="clear: both;"></div>

  <div id="content">
    <div style="max-width: 500px; margin: auto; border: 1px solid lightgray; border-radius: 10px; padding: 60px 10px 60px 10px;">
      <div class="form-group">
        <label class="label-control col-4"> Tên người/đơn vị đăng ký </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-name">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Địa chỉ </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-address">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Số điện thoại </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-mobile">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Phần thi đăng ký </label>
        <div class="col-8 checkbox">
          <!-- BEGIN: test -->
          <label style="margin-right: 10px;"> <input type="checkbox" name="test" index="{id}"> {name} <label>
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

<script>
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
