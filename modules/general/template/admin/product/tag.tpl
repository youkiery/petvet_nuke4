<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<link rel="stylesheet" href="/modules/core/css/style.css">

<style>
  .alert {
    display: none;
    text-align: center;
    font-size: 1.2em;
    z-index: 10000;
    position: fixed;
    width: 300px;
    height: 100px;
    left: calc(50% - 150px);
    top: calc(50% - 150px);
  }
</style>

<div id="msgshow"></div>
<div class="alert alert-danger alert-dismissible" onclick="killself()">
  <strong> Lỗi </strong>
  <p id="error-text">
    This alert box could indicate a dangerous or potentially negative action.
  </p>
</div>

{modal}

<ul class="nav nav-tabs">
  <li> <a href="{link}&sub=main"> Quản lý mặt hàng </a> </li>
  <li class="active"> <a href="#"> Quản lý tag </a> </li>
  <li> <a href="{link}&sub=user"> Quản lý người dùng </a> </li>
</ul>

<div class="form-group rows">
  <div class="col-6"></div>
  <div class="col-6">
    <div class="input-group">
      <input type="text" class="form-control" id="insert-tag" placeholder="Nhập tên tag mới">
      <div class="input-group-btn">
        <button class="btn btn-success" onclick="insertSubmit()">
          Thêm tag
        </button>
      </div>
    </div>
  </div>
</div>

<div class="right">
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  function insertSubmit() {
    vhttp.checkelse('', { action: 'insert', name: $('#insert-tag').val() }).then(data => {
      $('#content').html(data['html'])
    })
  }

  function editSubmit(id) {
    vhttp.checkelse('', { action: 'edit', name: $('#tag-name-' + id).val(), id: id }).then(data => {
      // do nothing
      if (data['error']) errorText(data['error'])
      else alert_msg(data['notify'])
    })
  }

  function errorText(text) {
    $('#error-text').text(text)
    $('.alert').fadeIn(100)
    setTimeout(() => {
     $('.alert').hide()
    }, 5000);
  }

  function killself() {
    $('.alert').hide(100)
  }
</script>
<!-- END: main -->