<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<div id="msgshow"></div>
<style>
  .form-group { overflow: auto; }
</style>

{modal_test}
{remove_contest_modal}
{remove_all_contest_modal}

<div style="float: right; margin: 10px 0px;">
  <button class="btn btn-success" onclick="testModal()">
    Danh sách phần thi
  </button>
</div>

<div id="content">
  {content}
</div>
<button class="btn btn-danger" onclick="removeAllRow()">
  Xóa mục đã chọn
</button>


<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var global = {
    id: 0
  }

  $(document).ready(() => {
    installCheckbox('test')
    installCheckbox('contest')
  })

  function testModal() {
    $("#modal-test").modal('show')
  }

  function hideTestSubmit(id) {
    $.post(
      '',
      { action: 'hide-test', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#test-content").html(data['html'])
          installCheckbox('test')
        })
      }
    )
  }

  function updateTestSubmit(id) {
    name = $("#test-name-" + id).val()
    if (!name.length) alert_msg('Điền nội dung trước khi cập nhật')
    else {
      $.post(
        '',
        { action: 'update-test', name: name, id: id },
        (response, status) => {
          checkResult(response, status).then(data => {
            // do nothing
          })
        }
      )
    }
  }

  function updateTestAllSubmit() {
    data = {}
    $(".test-name").each((index, item) => {
      id = trim(item.getAttribute('id').replace('test-name-', ''))
      data[id] = item.value
    })
    if (!Object.keys(data).length) {
      alert_msg('Thêm ít nhất 1 mục trước khi cập nhật')      
    }
    else {
      $.post(
        '',
        { action: 'update-test-all', data: data },
        (response, status) => {
          checkResult(response, status).then(data => {
            // do nothing
          })
        }
      )
    }
  }

  function testInsertSubmit() {
    name = $("#test-input").val()
    if (!name.length) {
      alert_msg('Nhập nội dung trước khi thêm')
    }
    else {
      $.post(
        '',
        { action: 'insert-test', name: name },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#test-content").html(data['html'])
            installCheckbox('test')
          })
        }
      )
    }
  }

  function installCheckbox(name) {
    $("#" + name + "-check-all").change(e => {
      checked = e.currentTarget.checked
      $("." + name + "-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }

  function removeRow(id) {
    global['id'] = id
    $("#remove-contest-modal").modal('show')
  }

  function removeAllRow() {
    list = []
    $('.contest-checkbox').each((index, item) => {
      indexkey = item.getAttribute('index')
      if (item.checked) list.push(indexkey)
    })
    if (!list.length) alert_msg('Chọn ít nhất 1 mục để xóa')
    else $("#remove-all-contest-modal").modal('show')
  }

  function removeRowSubmit() {
    if (!global['id']) {
      alert_msg('Mục chọn không tồn tại')
    }
    else {
      $.post(
        '',
        { action: 'remove-contest', id: global['id'] },
        (response, status) => {
          checkResult(response, status).then(data => {
            global['id'] = 0
            $("#remove-contest-modal").modal('hide')
            $("#content").html(data['html'])
            installCheckbox('contest')
          })
        }
      )
    }
  }

  function removeAllRowSubmit() {
    list = []
    $('.contest-checkbox').each((index, item) => {
      indexkey = item.getAttribute('index')
      if (item.checked) list.push(indexkey)
    })
    if (!list.length) alert_msg('Chọn ít nhất 1 mục để xóa')
    else {
      $.post(
        '',
        { action: 'remove-all-contest', list: list },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#remove-all-contest-modal").modal('hide')
            $("#content").html(data['html'])
            installCheckbox('contest')
          })
        }
      )
    }
  }
</script>
<!-- END: main -->
