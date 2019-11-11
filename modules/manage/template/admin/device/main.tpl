<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{device_modal}
<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="$('#device-modal').modal('show')">
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

<button class="btn btn-info">
  edit all
</button>  
<button class="btn btn-danger">
  remove all
</button>  
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    page: {
      'main': 1
    },
    depart: {
      list: JSON.parse('{depart}'),
      selected: {}
    }
  }

  $(document).ready(() => {
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

  function deviceInsertsubmit() {
    $.post(
      '',
      { action: 'insert-device', filter: checkFilter(), data: checkDeviceData() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        })
      }
    )
  }
</script>
<!-- END: main -->