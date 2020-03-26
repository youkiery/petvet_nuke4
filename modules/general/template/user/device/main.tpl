<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
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
<div class="form-group">
  Lọc danh sách phòng ban
  <div class="relative">
    <div class="input-group">
      <input type="text" class="form-control" id="filter-depart-input">
      <div class="input-group-btn">
        <button class="btn btn-info" onclick="goPage(1)"> Hiển thị </button>
      </div>
    </div>
    <div class="suggest" id="filter-depart-suggest"></div>
  </div>
  <span id="filter-depart"></span>
</div>
<div class="form-group">
  <button class="btn btn-info" onclick="excel()"> Xuất excel </button>
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
    selected: {
      filter: {},
      device: {}
    },
    filter: {
      selected: {}
    },
    list: JSON.parse('{depart}'),
    today: '{today}',
    remind: JSON.parse('{remind}'),
    remindv2: JSON.parse('{remindv2}')
  }

  $(document).ready(() => {
    installCheckAll('device')
    installRemindv2('device', 'name')
    installRemindv2('device', 'intro')
    installRemindv2('device', 'source')
    installDepart('filter')
    installDepart('device')
    $("#device-import-time").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function excel() {
    $.post(
      '',
      {action: 'excel'},
      (response, status) => {
    		window.open(strHref + '?excel=1')
      }
    )
  }

  function selectDepart(prefix, index) {
    global['selected'][prefix][index] = 1
    $("#"+ prefix +"-depart-input").val('')
    val = []
    for (const key in global['selected'][prefix]) {
      if (global['selected'][prefix].hasOwnProperty(key)) {
        val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart(\''+ prefix +'\', '+ key +')"> '+ global['list'][key]['name'] +' </span>')
      }
    }
    
    $("#"+ prefix +"-depart").html(val.join(', '))
  }

  function deselectDepart(prefix, index) {
    delete global['selected'][prefix][index]
    val = []
    for (const key in global['selected'][prefix]) {
      if (global['selected'][prefix].hasOwnProperty(key)) {
        val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart(\''+ prefix +'\', '+ key +')"> '+ global['list'][key]['name'] +' </span>')
      }
    }

    $("#"+ prefix +"-depart").html(val.join(', '))
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
            selectDepart('device', global['depart']['list'].length - 1)
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
    list = []
    for (const key in global['selected']['filter']) {
      if (global['selected']['filter'].hasOwnProperty(key)) {
        list.push(global['list'][key]['id'])
      }
    }
    return {
      page: global['page']['main'],
      limit: $("#filter-limit").val(),
      depart: list
    }
  }

  function checkDeviceData() {
    list = []
    for (const key in global['selected']['device']) {
      if (global['selected']['device'].hasOwnProperty(key)) {
        list.push(global['list'][key]['id'])
      }
    }
    name = $("#device-name").val()

    if (!name.length) {
      return 'Điền tên thiết bị'
    }

    return {
      name: name,
      unit: $("#device-unit").val(),
      number: $("#device-number").val(),
      year: $("#device-year").val(),
      intro: $("#device-intro").val(),
      source: $("#device-source").val(),
      status: $("#device-status").val(),
      depart: list,
      description: $("#device-description").val(),
      import: $("#device-import-time").val()
    }
  }

  function deviceInsert() {
    $("#device-name").val(''),
    $("#device-unit").val(''),
    $("#device-number").val(''),
    $("#device-year").val(''),
    $("#device-intro").val(''),
    $("#device-source").val(''),
    $("#device-status").val(''),
    $("#device-description").val('')
    $("#device-import-time").val(global['today'])
    $("#device-insert").show()
    $("#device-edit").hide()
    global['selected']['device'] = {}
    $("#device-depart").html('')
    $('#device-modal').modal('show')
  }

  function deviceInsertSubmit() {
    data = checkDeviceData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $.post(
        '',
        { action: 'insert-device', filter: checkFilter(), data: data },
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
  }

  function deviceEditSubmit() {
    data = checkDeviceData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $.post(
        '',
        { action: 'edit-device', filter: checkFilter(), data: data, id: global['id'] },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#content").html(data['html'])
            $('#device-modal').modal('hide')
          }, () => {})
        }
      )
    }
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
          $("#device-import-time").val(data['device']['import'])
          $("#device-insert").hide()
          $("#device-edit").show()
          global['selected']['depart'] = {}
          data['device']['depart'].forEach(depart => {
            global['list'].forEach((item, index) => {
              if (item['id'] == depart) {
                selectDepart('device', index)
              }
            })
          })
          global['id'] = id
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
    $("#device-import-time").val(global['today']),
    $("#device-import-description").val('')
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

  function goPage(page) {
    global['page']['main'] = page
    $.post(
      '',
      { action: 'filter', 'device_filter': checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        }, () => {})
      }
    )
  }

  function removeAll() {
    list = []
    $(".device-checkbox:checked").each((index, item) => {
      if (item.checked) {
        list.push(item.getAttribute('id').replace('device-checkbox-', ''))
      }
    })
    if (!list.length) {
      alert_msg('Chọn ít nhất một thiết bị')
    }
    else {
      $("#remove-all-modal").modal('show')
    }
  }

  function removeAllSubmit() {
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

  function installCheckAll(name) {
    $("#"+ name +"-check-all").change((e) => {
      checked = e.currentTarget.checked 
      $("."+ name +"-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }

  function installRemindv2(prefix, type) {
    var timeout
    var input = $("#"+ prefix +"-" + type)
    var suggest = $("#"+ prefix + '-' + type + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = convert(input.val())
        var html = ''
        
        for (const index in global['remindv2'][type]) {
          if (global['remindv2'][type].hasOwnProperty(index)) {
            const element = convert(global['remindv2'][type][index]);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest-item" onclick="selectRemindv2(\'' + prefix + '\', \'' + type + '\', \'' + global['remindv2'][type][index] + '\')"><p class="right-click">' + global['remindv2'][type][index] + '</p></div>'
            }
          }
        }
        suggest.html(html)
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

  function installDepart(prefix) {
    var input = $("#"+ prefix +"-depart-input")
    var suggest = $("#"+ prefix +"-depart-suggest")
    
    input.keyup((e) => {
      keyword = e.currentTarget.value
      html = ''
      count = 0
      

      global['list'].forEach((depart, index) => {
        if (count < 30 && depart['name'].search(keyword) >= 0) {
          count ++
          html += `
            <div class="suggest-item" onclick="selectDepart('`+ prefix +`', `+ index +`)">
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
  }

  function selectRemindv2(prefix, type, value) {
    $("#" + prefix + "-" + type).val(value)
  }
</script>
<!-- END: main -->
