<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/{module_file}/src/style.css">
<script src="/modules/{module_file}/src/script.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<style>
  label {
    width: 100%;
  }
</style>

<div id="msgshow"></div>

{modal}

<div class="form-group" style="float: right">
  <button class="btn btn-info" onclick="loadModal('statistic-modal')">
    Thống kê
  </button>
  <button class="btn btn-success" onclick="bloodInsertModal()">
    Thêm Mẫu xét nghiệm
  </button>
  <button class="btn btn-success" onclick="importInsertModal()">
    Nhập hóa chất
  </button>
</div>

<div style="clear: both;"></div>

<label> <input type="checkbox" class="page-type" value="0" checked> Phiếu xét nghiệm </label>
<label> <input type="checkbox" class="page-type" value="1" checked> Phiếu nhập </label>

<div class="text-center form-group">
  <button class="btn btn-success" onclick="goPage(1)">
    Lọc danh sách
  </button>
</div>

<div id="content">
  {content}
</div>

<script>
  var global = {
    page: 1,
    limit: 10,
    today: '{today}',
    type: 0,
    id: 0,
    prv: 0,
    index: 0,
    remind: JSON.parse('{remind_data}')
  }
  const formatter = new Intl.NumberFormat('vi-VI', {
    style: 'currency',
    currency: 'VND'
  })

  $(document).ready(() => {
    installRemind('insert-name')

    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });

    $("#insert-number").keyup((e) => {
      value = e.currentTarget.value
      start = $("#insert-start").val()
      if (value && !Number(value)) {
        $("#insert-number").val(global['prv'])
      }
      else {
        $("#insert-end").val(start - value)
      }
    })
    $("#insert-number").keydown((e) => {
      value = e.currentTarget.value
      if (Number(value)) global['prv'] = value
    })

    $("#import-price").keyup((e) => {
      var current = e.currentTarget
      var val = Number(current['value'].replace(/\,/g, ""));
      if (Number.isFinite(val)) {
        money = val
      }

      val = formatter.format(val).replace(/ ₫/g, "").replace(/\./g, ",");
      current.value = val
    })

  })

  function installRemind(name) {
    var input = $("#" + name)
    var suggest = $("#" + name + "-suggest")
    var timeout

    input.keyup((e) => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        keyword = convert(e.currentTarget.value)
        html = ''

        for (const index in global.remind) {
          if (global.remind.hasOwnProperty(index)) {
            const item = global.remind[index];
            spitem = convert(item)
            if (spitem.search(keyword) >= 0) {
              html += `
                <div class="suggest-item" onclick="selectItem('`+ name + `', '` + item + `', ` + index + `)">
                    `+ item + `
                </div>`
            }
          }
        }
        if (!html) suggest.text('Không tìm thấy kết quả')
        else suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 200);
    })
  }

  function selectItem(name, value, index) {
    global['index'] = index
    $("#" + name).val(value)
  }

  function bloodInsertModal() {
    $("#blood-insert-button").show()
    $("#blood-edit-button").hide()
    loadBloodDefault()
    $("#insert-number").prop('readonly', false)
    $("#insert-modal").modal('show')
  }
  function importInsertModal() {
    $("#import-insert-button").show()
    $("#import-edit-button").hide()
    loadImportDefault()
    $("#import-modal").modal('show')
  }

  function edit(type, id) {
    $.post(
      '',
      { action: 'edit', id: id, type: type },
      (reponse, status) => {
        checkResult(reponse, status).then(data => {
          if (type) {
            $("#import-time").val(data['time'])
            $("#import-number").val(data['number'])
            $("#import-price").val(data['price'])
            $("#import-note").val(data['note'])
            $("#import-insert-button").hide()
            $("#import-edit-button").show()
            $("#import-modal").modal('show')
          }
          else {
            $("#insert-time").val(data['time'])
            $("#insert-number").val(data['number'])
            $("#insert-start").val(data['start'])
            $("#insert-end").val(data['end'])
            $("#insert-name").val(data['target'])
            $("#blood-insert-button").hide()
            $("#blood-edit-button").show()
            $("#insert-modal").modal('show')
          }
          global['id'] = id
          $("#content").html(data['html'])
        })
      }
    )
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      '',
      { action: 'filter', filter: checkFilter() },
      (reponse, status) => {
        checkResult(reponse, status).then(data => {
          $("#content").html(data['html'])
        })
      }
    )
  }

  function checkFilter() {
    type = (() => {
      list = []
      $('.page-type:checked').each((index, item) => { list.push(item.value) })
      return list
    })()
    return {
      page: global['page'],
      limit: global['limit'],
      type: type
    }
  }

  function checkBloodData() {
    return {
      name: $("#insert-name").val(),
      time: $("#insert-time").val(),
      number: $("#insert-number").val(),
      start: Number($("#insert-start").val()),
      end: Number($("#insert-end").val()),
      doctor: $("#insert-doctor").val()
    }
  }

  function loadBloodDefault() {
    $("#insert-time").val(global['today'])
    $("#insert-number").val(1)
    $("#insert-name").val('')
  }

  function insertBlood() {
    insertData = checkBloodData()

    if (insertData['number'] <= 0) {
      alert_msg('Số lượng mẫu phải lớn hơn 0')
    }
    else if (insertData['start'] <= insertData['end']) {
      alert_msg('Số cuối phải nhỏ hơn số đầu')
    }
    else if (!insertData['name'].length) {
      alert_msg('Nhập mục đích sử dụng trước khi thêm')
    }
    else {
      $.post(
        '',
        { action: 'insert-blood', data: insertData, filter: checkFilter() },
        (reponse, status) => {
          checkResult(reponse, status).then(data => {
            $("#content").html(data['html'])
            $("#insert-start").val(insertData['end'])
            $("#insert-end").val(insertData['end'] - 1)
            loadBloodDefault()
            $("#insert-modal").modal('hide')
          })
        }
      )
    }
  }

  function editBlood() {
    insertData = checkBloodData()
    if (insertData['number'] <= 0) {
      alert_msg('Số lượng mẫu phải lớn hơn 0')
    }
    else if (insertData['start'] <= insertData['end']) {
      alert_msg('Số cuối phải nhỏ hơn số đầu')
    }
    else {
      $.post(
        '',
        { action: 'edit-blood', id: global['id'], data: insertData, filter: checkFilter() },
        (reponse, status) => {
          checkResult(reponse, status).then(data => {
            $("#content").html(data['html'])
            $("#insert-start").val(insertData['end'])
            $("#insert-end").val(insertData['end'] - 1)
            loadBloodDefault()
            $("#insert-number").prop('readonly', true)
            $("#insert-modal").modal('hide')
          })
        }
      )
    }
  }

  function checkImportData() {
    return {
      time: $("#import-time").val(),
      number: $("#import-number").val(),
      price: $("#import-price ").val(),
      note: $("#import-note").val()
    }
  }

  function loadImportDefault() {
    $("#import-time").val(global['today'])
    $("#import-number").val(0)
    $("#import-price").val(0)
    $("#import-note").val('')
  }

  function insertImport() {
    insertData = checkImportData()
    if (insertData['number'] <= 0) {
      alert_msg('Số lượng mẫu phải lớn hơn 0')
    }
    else {
      $.post(
        '',
        { action: 'insert-import', data: insertData, filter: checkFilter() },
        (reponse, status) => {
          checkResult(reponse, status).then(data => {
            $("#content").html(data['html'])
            loadImportDefault()
            $("#insert-start").val(data['number'])
            $("#insert-end").val(data['number'] - 1)
            $("#import-modal").modal('hide')
          })
        }
      )
    }
  }

  function editImport() {
    insertData = checkImportData()
    if (insertData['number'] <= 0) {
      alert_msg('Số lượng mẫu phải lớn hơn 0')
    }
    else {
      $.post(
        '',
        { action: 'edit-import', id: global['id'], data: insertData, filter: checkFilter() },
        (reponse, status) => {
          checkResult(reponse, status).then(data => {
            $("#content").html(data['html'])
            loadImportDefault()
            $("#insert-start").val(data['number'])
            $("#insert-end").val(data['number'] - 1)
            $("#import-modal").modal('hide')
          })
        }
      )
    }
  }

  function remove(typeid, id) {
    global['type'] = typeid
    global['id'] = id
    $("#remove-modal").modal('show')
  }

  function removeSubmit() {
    $.post(
      '',
      { action: 'remove', typeid: global['type'], id: global['id'], filter: checkFilter() },
      (reponse, status) => {
        checkResult(reponse, status).then(data => {
          $("#content").html(data['html'])
          $("#insert-start").val(data['number'])
          $("#insert-end").val(data['number'] - 1)
          $("#remove-modal").modal('hide')
        })
      }
    )
  }

  function statisticFilter() {
    $.post(
      '',
      {
        action: "statistic", filter: {
          from: $("#from").val(),
          end: $("#end").val()
        }
      },
      (response, status) => {
        checkResult(response, status).then((data) => {
          $("#statistic-content").html(data['html'])
        }, () => { })
      }
    )
  }
</script>
<!-- END: main -->