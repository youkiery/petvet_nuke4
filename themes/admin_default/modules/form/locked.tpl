<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<label class="form-group">
  Bật chức năng khóa văn bản:
  <input type="checkbox" class="form-control" id="checker" onchange="change()" {checked}>
</label>
<br>
<label class="form-group">
  Khóa văn bản tự động
  <input type="checkbox" class="form-control" id="auto-locker" onchange="change2()" value="1" {autolocker}>
</label>
<br>
<label class="form-group form-inline">
  Khóa văn bản từ ngày
  <input type="text" class="form-control" id="locker" value="{locked}" {lchecked} autocomplete="off">
</label>
<div class="text-center">
  <button class="btn btn-info" onclick="update()">
    Khóa văn bản
  </button>
</div>

<script>
  var checker = $("#checker")
  var locker = $("#locker")

  $("#locker").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function change() {
    if (checker.prop('checked')) {
      locker.removeAttr('disabled')
      $("#auto-locker").prop('disabled', false)
    }
    else {
      $("#auto-locker").prop('disabled', true)
      locker.attr('disabled', '')
    }
  }

  function change2() {
    if ($("#auto-locker").prop('checked')) {
      locker.attr('disabled', '')
    }
    else {
      locker.removeAttr('disabled')
    }
  }

  function update() {
    var data = {
      checker: Number(checker.prop('checked')),
      locker: locker.val(),
      auto: $("#auto-locker").prop('checked') ? 1 : 0
    }
    $.post(
      strHref,
      {action: 'update', data: data},
      (response, status) => {
        checkResult(response, status).then(data => {
          window.location.reload()
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
