<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{device_modal}
{remove_modal}
{remove_all_modal}
<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="deviceInsert()">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<div class="form-group form-inline">
  Số dòng mỗi trang
  <div class="input-group">
    <input type="text" class="form-control" id="filter-limit" value="10">
    <div class="input-group-btn">
      <button class="btn btn-info" onclick="goPage(1)"> Hiển thị </button>
    </div>
  </div>
</div>

<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<!-- <button class="btn btn-info">
  edit all
</button>   -->
<button class="btn btn-danger" onclick="removeAll()">
  Xóa mục đã chọn
</button>  
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    id: 0,
    page: {
      'main': 1
    },
    depart: {
      list: JSON.parse('{depart}'),
      selected: {}
    },
    remind: JSON.parse('{remind}')
  }

  $(document).ready(() => {
    installCheckAll('device')
    input = $("#device-depart-input")
    suggest = $("#device-depart-suggest")
    input.keyup((e) => {
      keyword = e.currentTarget.value
      html = ''
      count = 0

      global['depart']['list'].forEach((depart, index) => {
        if (count < 30 && depart['name'].search(keyword) >= 0) {
          count ++
          html += `
            <div class="suggest-item" onclick="selectDepart(`+ index +`)">
              `+ depart['name'] +`
            </div>`
        }
      })
      if (!html.length) {
        html = 'Không có kết quả'
      }
      suggest.html(html)
    })

    input.focus(() => {
      suggest.show()
    })

    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 300);
    })
  })

  function selectDepart(index) {
    global['depart']['selected'][index] = 1
    $("#device-depart-input").val('')
    val = []
    for (const key in global['depart']['selected']) {
      if (global['depart']['selected'].hasOwnProperty(key)) {
        val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart('+ key +')"> '+ global['depart']['list'][key]['name'] +' </span>')
      }
    }
    $("#device-depart").html(val.join(', '))
  }

  function deselectDepart(index) {
    delete global['depart']['selected'][index]
    val = []
    for (const key in global['depart']['selected']) {
      if (global['depart']['selected'].hasOwnProperty(key)) {
        val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart('+ key +')"> '+ global['depart']['list'][key]['name'] +' </span>')
      }
    }
    $("#device-depart").html(val.join(', '))
  }

  function insertDepart() {
    depart = $("#device-depart-input").val()
    if (!depart.length) {
      alert_msg('Điền tên đơn vị trước khi thêm mới')
    }
    else {
      $.post(
        '',
        { action: 'insert-depart', name: depart },
        (response, status) => {
          checkResult(response, status).then(data => {
            global['depart']['list'].push(data['inserted'])
            selectDepart(global['depart']['list'].length - 1)
          }, () => {})
        }
      )
    }
  }

  function checkFilter() {
    limit = $("#filter-limit").val()
    if (limit < 10) {
      $("#filter-limit").val(10)
    }
    else if (limit > 200) {
      $("#filter-limit").val(200)
    }
    return {
      page: global['page']['main'],
      limit: $("#filter-limit").val()
    }
  }

  function checkDeviceData() {
    list = []
    for (const key in global['depart']['selected']) {
      if (global['depart']['selected'].hasOwnProperty(key)) {
        list.push(global['depart']['list'][key]['id'])
      }
    }
    return {
      name: $("#device-name").val(),
      unit: $("#device-unit").val(),
      number: $("#device-number").val(),
      year: $("#device-year").val(),
      intro: $("#device-intro").val(),
      source: $("#device-source").val(),
      status: $("#device-status").val(),
      depart: list,
      description: $("#device-description").val()
    }
  }

  function deviceInsert() {
    $("#content").html(data['html'])
    $("#device-name").val(''),
    $("#device-unit").val(''),
    $("#device-number").val(''),
    $("#device-year").val(''),
    $("#device-intro").val(''),
    $("#device-source").val(''),
    $("#device-status").val(''),
    $("#device-description").val('')
    global['depart']['selected'] = {}
    $("#device-depart").html('')
    $('#device-modal').modal('show')
  }

  function deviceInsertsubmit() {
    $.post(
      '',
      { action: 'insert-device', filter: checkFilter(), data: checkDeviceData() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $("#device-name").val(''),
          $("#device-unit").val(''),
          $("#device-number").val(''),
          $("#device-year").val(''),
          $("#device-intro").val(''),
          $("#device-source").val(''),
          $("#device-status").val(''),
          $("#device-description").val('')
          global['depart']['selected'] = {}
          $("#device-depart").html('')
          $('#device-modal').modal('hide')
        }, () => {})
      }
    )
  }

  function deviceEdit(id) {
    $.post(
      '',
      { action: 'get-device', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $("#device-name").val(data['device']['name']),
          $("#device-unit").val(data['device']['unit']),
          $("#device-number").val(data['device']['number']),
          $("#device-year").val(data['device']['year']),
          $("#device-intro").val(data['device']['intro']),
          $("#device-source").val(data['device']['source']),
          $("#device-status").val(data['device']['status']),
          $("#device-description").val(data['device']['description'])
          global['depart']['selected'] = {}
          data['device']['depart'].forEach(depart => {
            global['depart']['list'].forEach((item, index) => {
              if (item['id'] == depart) {
                selectDepart(index)
              }
            })
          })
          $('#device-modal').modal('show')
        }, () => {})
      }
    )
  }

  function loadDefault() {
    $("#device-name").val(),
    $("#device-unit").val(global['remind']['unit']),
    $("#device-number").val(global['remind']['number']),
    $("#device-year").val(global['remind']['year']),
    $("#device-intro").val(global['remind']['intro']),
    $("#device-source").val(global['remind']['source']),
    $("#device-status").val(global['remind']['status']),
    $("#device-description").val('')
  }

  function deviceRemove(id) {
    $('#remove-modal').modal('show')
    global['id'] = id
  }

  function deviceRemoveSubmit() {
    $.post(
      '',
      { action: 'remove-device', filter: checkFilter(), id: global['id'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $('#remove-modal').modal('hide')
        }, () => {})
      }
    )
  }

  function removeAll() {
    list = []
    $(".device-checkbox:checked").each((index, item) => {
      if (item.checked) {
        console.log(item);
        
        list.push(item.getAttribute('id').replace('device-checkbox-', ''))
      }
    })
    if (!list.length) {
      alert_msg('Chọn ít nhất một thiết bị')
    }
    else {
      $.post(
      '',
      { action: 'remove-all-device', filter: checkFilter(), list: list },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $('#remove-all-modal').modal('hide')
        }, () => {})
      })
    }
  }

  function installCheckAll(name) {
    $("#"+ name +"-check-all").change((e) => {
      checked = e.currentTarget.checked 
      $("."+ name +"-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }
</script>
<!-- END: main -->
