<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/contest/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<div id="msgshow"></div>
<style>
  .form-group { clear: both; }
</style>

{modal_test}
{remove_contest_modal}
{remove_all_contest_modal}

<div style="float: right; margin: 10px 0px;">
  <button class="btn btn-success" onclick="testModal()">
    Danh sách phần thi
  </button>
</div>

<div class="form-group form-inline">
  <div class="input-group">
    <input type="text" class="form-control" id="filter-limit" value="10">
    <div class="input-group-btn">
      <button class="btn btn-info" onclick="goPage(1)">
        Hiển thị
      </button>
    </div>
  </div>
  <select class="form-control" id="filter-species">
    <option value="0" checked> Toàn bộ </option>
    <!-- BEGIN: species -->
    <option value="{id}" checked> {species} </option>
    <!-- END: species -->
  </select>
</div>
<div class="form-group form-inline">
  Danh sách phần thi
  <!-- BEGIN: contest -->
  <label class="checkbox" style="margin-right: 10px"> <input type="checkbox" class="filter-contest" index="{id}" checked> {contest} </label>
  <!-- END: contest -->
</div>
<div class="form-group text-center">
  <button class="btn btn-info" onclick="goPage(1)">
    Lọc danh sách
  </button>
</div>

<div id="content">
  {content}
</div>
<button class="btn btn-info" onclick="confirmAllSubmit(1)">
  Duyệt các mục đã chọn
</button>
<button class="btn btn-warning" onclick="confirmAllSubmit(0)">
  Bỏ duyệt các mục đã chọn
</button>
<button class="btn btn-danger" onclick="removeAllRow()">
  Xóa các mục đã chọn
</button>


<script src="/modules/contest/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var global = {
    id: 0,
    page: 1
  }

  $(document).ready(() => {
    installCheckbox('test')
    installCheckbox('contest')
  })

  function checkFilter() {
    limit = $("#filter-limit")
    if (!(limit > 10)) limit = 10

    contest = []
    $(".filter-contest").each((index, item) => {
      if (item.checked) contest.push(item.getAttribute('index'))
    })
    
    return {
      page: global['page'],
      limit: limit,
      species: $("#filter-species").val(),
      contest: contest
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      '',
      { action: 'filter', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#content').html(data['html'])
        })
      }
    )
  }

  function testModal() {
    $("#modal-test").modal('show')
  }

  function toggleTestSubmit(id, type) {
    $.post(
      '',
      { action: 'toggle-test', id: id, type: type },
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

  function confirmSubmit(id, type) {
    $.post(
      '',
      { action: 'confirm-contest', filter: checkFilter(), id: id, type: type },
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = 0
          $("#content").html(data['html'])
          installCheckbox('contest')
        })
      }
    )
  }

  function confirmAllSubmit(type) {
    list = []
    $('.contest-checkbox').each((index, item) => {
      indexkey = item.getAttribute('index')
      if (item.checked) list.push(indexkey)
    })
    if (!list.length) alert_msg('Chọn ít nhất 1 mục để duyệt')
    else {
      $.post(
        '',
        { action: 'done-all-contest', filter: checkFilter(), list: list, type: type },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#content").html(data['html'])
            installCheckbox('contest')
          })
        }
      )
    }
  }

  function removeRowSubmit() {
    if (!global['id']) {
      alert_msg('Mục chọn không tồn tại')
    }
    else {
      $.post(
        '',
        { action: 'remove-contest', filter: checkFilter(), id: global['id'] },
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
        { action: 'remove-all-contest', filter: checkFilter(), list: list },
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
