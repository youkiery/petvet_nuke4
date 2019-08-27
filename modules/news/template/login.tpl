<!-- BEGIN: main -->

<style>
  label {
    width: 100%;
  }
  .col-sm-4 {
    text-align: left;
  }
</style>

<div class="container">
  <div class="text-center start-content" style="max-width: 450px; margin: auto; padding-top: 50px; border: 1px solid lightgray; padding: 15px; border-radius: 20px;">
    <a href="/biograph/">
      <img src="/modules/news/src/banner.png" style="width: 200px; margin: 20px 20px;">
    </a>

    <div style="margin-top: 20px;"></div>
    <div class="row">
      <label>
        <div class="col-sm-4">
          Tên đăng nhập
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="username" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Mật khẩu
        </div>
        <div class="col-sm-8">
          <input type="password" class="form-control" id="password">
        </div>
      </label>
    </div>

    <div class="text-center">
      <button class="btn btn-info" onclick="login()">
        Đăng nhập
      </button>
    </div>
    <div id="error"> </div>
    <br>
    Chưa có tài khoản? <a href="/biograph/signup"> Đăng ký ngay!</a>
  </div>
</div>

<script>
  var global = {
    url: '{origin}'
  }
  var username = $("#username")
  var password = $("#password")
  var error = $("#error")

  function displayError(errorText) {
    var text = ''
    
    if (errorText) {
      text = errorText
    }

    error.text(text)
  }

  function checkLogin() {
    var data = {
      username: username.val(),
      password: password.val()
    }

    if (data['username'] && data['password']) {
      return data
    }
    return false
  }

  function login() {
    if (loginData = checkLogin()) {
      $.post(
        global['url'],
        {action: 'login', data: loginData},
        (response, status) => {
          checkResult(response, status).then(data => {
            window.location.reload() 
          }, (data) => {
            displayError(data['error'])
          })
        }
      )
    }
    else {
      displayError('Chưa điền đủ thông tin')
    }
  }
</script>
<!-- END: main -->
