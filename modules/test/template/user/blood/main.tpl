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

  .text-red {
    color: red;
  }
</style>

<div id="msgshow"></div>

{modal}

<div class="form-group" style="float: right">
  <button class="btn btn-info" onclick="loadModal('statistic-modal')">
    Thống kê
  </button>
  <button class="btn btn-success" onclick="bloodInsertModal()">
    Thêm mẫu
  </button>
  <button class="btn btn-success" onclick="importInsertModal()">
    Nhập hóa chất
  </button>
</div>

<div style="clear: both;"></div>

<div class="rows">
  <div class="col-4">
    <p> <b> Số mẫu trong máy: <span id="sample-number"> {number} </span> </b> </p>
    <p> <b> Số hóa chất 1: <span id="sample-number1"> {number1} </span> </b> </p>
    <p> <b> Số hóa chất 2: <span id="sample-number2"> {number2} </span> </b> </p>
    <p> <b> Số hóa chất 3: <span id="sample-number3"> {number3} </span> </b> </p>
  </div>
  <div class="col-4">
    <form class="text-center form-group">
      <!-- BEGIN: http -->
      <input type="hidden" name="nv" value="{nv}">
      <input type="hidden" name="op" value="{op}">
      <!-- END: http -->
      <input type="hidden" name="page" value="{page}">
      <input type="hidden" name="limit" value="{limit}">
      <label> <input type="radio" name="type" class="page-type" value="0" {type0}> Tất cả </label>
      <label> <input type="radio" name="type" class="page-type" value="1" {type1}> Phiếu xét nghiệm </label>
      <label> <input type="radio" name="type" class="page-type" value="2" {type2}> Phiếu nhập </label>
      <button class="btn btn-success">
        Lọc danh sách
      </button>
    </form>
  </div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
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
    vremind.install('#insert-name', '#insert-name-suggest', (input) => {
      return new Promise(resolve => {
        keyword = convert(input)
        html = ''

        for (const index in global['remind']) {
          if (global['remind'].hasOwnProperty(index)) {
            const item = global['remind'][index];
            spitem = convert(item)
            if (spitem.search(keyword) >= 0) {
              html += `
                <div class="suggest-item" onclick="selectItem('insert-name', '` + item + `', ` + index + `)">
                    `+ item + `
                </div>`
            }
          }
        }
        if (!html) html = 'không tìm thấy kết quả'
        resolve(html)
      })
    }, 300, 300)
    // installRemind('insert-name')

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

  function pushSample() {
    $('#sample-value').val(0)
    $('#sample-value1').val(1)
    $('#sample-value2').val(1)
    $('#sample-value3').val(1)
    $('#sample-modal').modal('show')
  }

  function pullSample() {
    $('#pull-value').val(0)
    $('#pull-modal').modal('show')
  }

  function pushSampleSubmit(event) {
    event.preventDefault()
    vhttp.checkelse('', { action: 'push', number: $('#sample-value').val(), number1: $('#sample-value-1').val(), number2: $('#sample-value-2').val(), number3: $('#sample-value-3').val() }).then(data => {
      parseSample(data['number'], data['total'])
      $('#sample-modal').modal('hide')
    })
    return 0
  }

  function pullSampleSubmit() {
    event.preventDefault()
    vhttp.checkelse('', { action: 'pull', number: $('#pull-value').val() }).then(data => {
      parseSample(data['number'], data['total'])
      $('#content').html(data['html'])
      $('#pull-modal').modal('hide')
    })
    return 0
  }

  function parseSample(number, total) {
    $('#sample-number').text(number)
    $('#sample-number1').text(total['number1'])
    $('#sample-number2').text(total['number2'])
    $('#sample-number3').text(total['number3'])
    $('#sample-limit').text(number)
    $('#sample-limit1').text(total['number1'])
    $('#sample-limit2').text(total['number2'])
    $('#sample-limit3').text(total['number3'])
    $('#insert-start').val(number)
    $('#insert-end').val(number - $('#insert-number').val())
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
      vhttp.checkelse('', { action: 'insert-blood', data: insertData }).then(data => {
        parseSample(data['number'], data['total'])
        $("#content").html(data['html'])
        $("#insert-start").val(insertData['end'])
        $("#insert-end").val(insertData['end'] - 1)
        loadBloodDefault()
        $("#insert-modal").modal('hide')
      })
    }
  }

  function checkImportData() {
    return {
      time: $("#import-time").val(),
      number1: $("#import-number-1").val(),
      number2: $("#import-number-2").val(),
      number3: $("#import-number-3").val(),
      price: $("#import-price ").val(),
      note: $("#import-note").val()
    }
  }

  function loadImportDefault() {
    $("#import-time").val(global['today'])
    $("#import-number-1").val(0)
    $("#import-number-2").val(0)
    $("#import-number-3").val(0)
    $("#import-price").val(0)
    $("#import-note").val('')
  }

  function insertImport() {
    insertData = checkImportData()
    if (insertData['number'] <= 0) alert_msg('Số lượng mẫu phải lớn hơn 0')
    else {
      vhttp.checkelse('', { action: 'insert-import', data: insertData }).then(data => {
        $("#content").html(data['html'])
        parseSample(data['number'], data['total'])
        loadImportDefault()
        $("#import-modal").modal('hide')
      })
    }
  }

  function remove(typeid, id) {
    global['type'] = typeid
    global['id'] = id
    $("#remove-modal").modal('show')
  }

  function removeSubmit() {
    vhttp.checkelse('', { action: 'remove', typeid: global['type'], id: global['id'] }).then(data => {
      $("#content").html(data['html'])
      parseSample(data['number'], data['total'])
      $("#remove-modal").modal('hide')
    })
  }

  function statisticFilter() {
    vhttp.checkelse('', {
      action: "statistic", filter: {
        from: $("#from").val(),
        end: $("#end").val()
      }
    }).then(data => {
      $("#statistic-content").html(data['html'])
    })
  }

  // function editBlood() {
  //   insertData = checkBloodData()
  //   if (insertData['number'] <= 0) {
  //     alert_msg('Số lượng mẫu phải lớn hơn 0')
  //   }
  //   else if (insertData['start'] <= insertData['end']) {
  //     alert_msg('Số cuối phải nhỏ hơn số đầu')
  //   }
  //   else {
  //     $.post(
  //       '',
  //       { action: 'edit-blood', id: global['id'], data: insertData },
  //       (reponse, status) => {
  //         checkResult(reponse, status).then(data => {
  //           $("#content").html(data['html'])
  //           $("#insert-start").val(insertData['end'])
  //           $("#insert-end").val(insertData['end'] - 1)
  //           loadBloodDefault()
  //           $("#insert-number").prop('readonly', true)
  //           $("#insert-modal").modal('hide')
  //         })
  //       }
  //     )
  //   }
  // }

    // function editImport() {
  //   insertData = checkImportData()
  //   if (insertData['number'] <= 0) {
  //     alert_msg('Số lượng mẫu phải lớn hơn 0')
  //   }
  //   else {
  //     $.post(
  //       '',
  //       { action: 'edit-import', id: global['id'], data: insertData },
  //       (reponse, status) => {
  //         checkResult(reponse, status).then(data => {
  //           $("#content").html(data['html'])
  //           loadImportDefault()
  //           $("#insert-start").val(data['number'])
  //           $("#insert-end").val(data['number'] - 1)
  //           $("#import-modal").modal('hide')
  //         })
  //       }
  //     )
  //   }
  // }

  // function edit(type, id) {
  //   $.post(
  //     '',
  //     { action: 'edit', id: id, type: type },
  //     (reponse, status) => {
  //       checkResult(reponse, status).then(data => {
  //         if (type) {
  //           $("#import-time").val(data['time'])
  //           $("#import-number").val(data['number'])
  //           $("#import-price").val(data['price'])
  //           $("#import-note").val(data['note'])
  //           $("#import-insert-button").hide()
  //           $("#import-edit-button").show()
  //           $("#import-modal").modal('show')
  //         }
  //         else {
  //           $("#insert-time").val(data['time'])
  //           $("#insert-number").val(data['number'])
  //           $("#insert-start").val(data['start'])
  //           $("#insert-end").val(data['end'])
  //           $("#insert-name").val(data['target'])
  //           $("#blood-insert-button").hide()
  //           $("#blood-edit-button").show()
  //           $("#insert-modal").modal('show')
  //         }
  //         global['id'] = id
  //         $("#content").html(data['html'])
  //       })
  //     }
  //   )
  // }
</script>
<!-- END: main -->