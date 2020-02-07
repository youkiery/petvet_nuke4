<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

{modal}

<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="materialModal()">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
  <button class="btn btn-info" onclick="filter()">
    <span class="glyphicon glyphicon-filter"></span>
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
  <button class="btn btn-info" onclick='$("#overlow-modal").modal("show")'>
    Danh sách vật tư hết
  </button>  
  <button class="btn btn-info" onclick="importModal()">
    Phiếu nhập
  </button>  
  <button class="btn btn-info" onclick="exportModal()">
    Phiếu xuất
  </button>  
</div>

<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<!-- <button class="btn btn-info">
  edit all
</button>   -->
<!-- <button class="btn btn-danger">
  remove all
</button>   -->
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    page: {
      'main': 1,
      'report': 1
    },
    material: JSON.parse('{material}'),
    selected: {
      'import': [],
      'export': []
    }
  }

  $(document).ready(() => {
    itemFilter('import')
    itemFilter('export')
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function materialModal() {
    $("#material-modal").modal('show')
  }
  function importModal() {
    $("#import-modal").modal('show')
  }
  function insertImportModal() {
    $("#import-button").show()
    $("#edit-import-button").hide()
    global['selected']['import'] = []
    parseFormLine('import')
    $("#import-modal-insert").modal('show')
  }
  function insertExportModal() {
    $("#export-button").show()
    $("#edit-export-button").hide()
    $("#export-modal-insert").modal('show')
  }
  function exportModal() {
    $("#export-modal").modal('show')
  }

  function filter() {
    $("#filter-modal").modal('show')
  }

  function checkFilterReport() {
    return {
      page: global['page']['report'],
      limit: 10,
      keyword: $("#filter-keyword").val(),
      start: $("#filter-start").val(),
      end: $("#filter-end").val()
    }
  }

  function report(id) {
    $.post(
      "",
      { action: 'report', id: id, filter: checkFilterReport() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#report-content").html(data['html'])
          $("#report-modal").modal('show')
        })
      }
    )
  }

  function reportExcel(id) {
    $.post(
      "",
      { action: 'report-excel', id: id, filter: checkFilterReport() },
      (response, status) => {
        checkResult(response, status).then(data => {
          window.open('/assets/excel-material.xlsx?t=' + new Date())
        })
      }
    )
  }

  function goReportPage(page) {
    global['page']['report'] = page
    $.post(
      "",
      { action: 'filter-report', filter: checkFilterReport() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#filter-content").html(data['html'])
        })
      }
    )
  }

  function checkMaterialData() {
    name = $("#material-name").val()
    number = $("#material-number").val()
    unit = $("#material-unit").val()
    type = $("[name=type]")[1].checked
    type = (type ? 1 : 0)
    description = $("#material-description").val()

    if (!name.length) alert_msg('Nhập tên trước khi thêm')
    if (!number.length) number = 0

    return {
      name: name,
      number: number,
      unit: unit,
      type: type,
      description: description
    }
  }

  function checkFilter() {
    return {
      page: global['page']['main'],
      limit: $("#filter-limit").val()
    }
  }

  function goPage(page) {
    $.post(
      "",
      { action: 'insert-material', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        })
      }
    )
  }

  function insertMaterial() {
    $.post(
      "",
      { action: 'insert-material', data: checkMaterialData(), filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          global['material'].push(data['json'])
          $("#material-name").val('')
          $("#material-unit").val('')
          $("#material-number").val('')
          $("#material-description").val('')
          $("#content").html(data['html'])
          $("#material-modal").modal('hide')
        }, () => {})
      }
    )
  }

  function itemFilter(name) {
    var input = $("#"+ name +"-item-finder")
    var suggest = $("#"+ name +"-item-finder-suggest")

    input.keyup((e) => {
      keyword = convert(input.val())
      html = ''
      count = 0

      global['material'].forEach((item, index) => {
        itemName = convert(item['name'])
        if (count < 30 && itemName.search(keyword) >= 0) {
          count ++
          html += `
            <div class="suggest-item" onclick="selectItem('`+ name +`', `+ index +`)">
              `+ item['name'] +`
            </div>`
        }
      })
      if (!html.length) {
        html = 'Không có kết quả'
      }
      suggest.html(html)
    })
    input.focus(() => {
      setTimeout(() => {
        suggest.show()
      }, 300);
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 300);
    })
  }

  function selectItem(name, index) {
    selected = global['material'][index]
    $("#"+ name +"-item-finder").val(selected['name'])
    getFormLine(name)
    checkSelected(name, global['material'][index]['id'])
    if (global['material'][index]['link']) {
      checkSelected(name, global['material'][index]['link'])
    }

      // global['selected'][name].forEach((item, key) => {
      //   console.log(item['id'], global['material'][index]['link']);
      //   if (item['id'] == global['material'][index]['link']) {
      //     check = global['material'][index]['link']
      //     // swap linked item to last
      //     temp = item // current
      //     last = Object.keys(global.material)
      //     last = last[last.length - 1]
      //     global['selected'][name][key] = global['selected'][name][last]
      //     global['selected'][name][last] = temp
      //   }
      // })

      // if (!check) {
      //   // insert linked item
      //   global['selected'][name].push({
      //     index: index,
      //     id: global['material'][index]['id'],
      //     date: '',
      //     number: 1,
      //     status: '',
      //   })
      // }

    // global['selected'][name].push({
    //   index: index,
    //   id: global['material'][index]['id'],
    //   date: '',
    //   number: 1,
    //   status: '',
    // })
    parseFormLine(name)
  }

  function checkSelected(name, id) {
    checker = false
    checker2 = false
    // tìm index của id trong global.material
    // tìm trong danh sách selected có chứa item có index trên không
    // nếu có, đưa lên đầu
    // nếu không, thêm mới
    global['material'].forEach((item, index) => {
      if (item['id'] == id) {
        checker = index
      }
    });

    global['selected'][name].forEach((item, index) => {
      if (item['index'] == checker) {
        checker2 = global['material'][index]['index']
        // checkItem = item
        // đẩy item về đầu
        for (let i = index - 1; i > 0; i--) {
          swapItem(name, i, i - 1)
        }
        global['selected'][0] = item
      } 
    })

    if (!checker2) {
      // chưa swap, chỉ cần thêm mới
      global['selected'][name].push({
        index: checker,
        id: global['material'][checker]['id'],
        date: '',
        number: 1,
        status: '',
      })
    }
  }

  function swapItem(name, a, b) {
    temp = global['selected'][name][a]
    global['selected'][name][a] = global['selected'][name][b]
    global['selected'][name][b] = temp
  }

  function parseFormLine(name) {
    var html = ''
    global['selected'][name].forEach((item, index) => {
      html += `
        <tbody class="`+ name +`" id="`+ name +`-index-`+ index +`" index="`+ item['index'] +`">
          <tr>
            <td>
              `+ (index + 1) +`
            </td>
            <td>
              `+ (global['material'][item['index']]['name']) +`
            </td>
            <td>
              <input class="form-control date" id="`+ name +`-date-`+ index +`" value="`+ (item['date']) +`">
            </td>
            <td>
              <input class="form-control" id="`+ name +`-number-`+ index +`" value="`+ (item['number']) +`">
            </td>
            <td>
              <input class="form-control" id="`+ name +`-status-`+ index +`" value="`+ (item['status']) +`">
            </td>
            <td>
              <button class="btn btn-danger" onclick="removeFormLine('`+ name +`', `+ index +`)">
                <span class="glyphicon glyphicon-remove"> <span>
              </button>
            </td>
          </tr>
        </tbody>`
    })
    html = `
      <table class="table table-bordered">
        <thead>
          <tr>
            <th class="cell-center"> STT </th>
            <th class="cell-center"> Tên thiết bị </th>
            <th class="cell-center"> Ngày hết hạn </th>
            <th class="cell-center"> Số lượng </th>
            <th class="cell-center"> Chất lượng </th>
            <th></th>
          </tr>
        </thead>
        `+ html +`
      </table>`
    $("#"+ name +"-insert-modal-content").html(html)
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  }

  function getFormLine(name) {
    data = []
    $("." + name).each((index, item) => {
      indexX = trim(item.getAttribute('index'))
      // indexX = trim(item.getAttribute('id').replace('import-index-', ''))
      data.push({
        index: indexX,
        id: global['material'][indexX]['id'],
        date: $("#"+ name +"-date-" + index).val(),
        number: $("#"+ name +"-number-" + index).val(),
        status: $("#"+ name +"-status-" + index).val()
      })
    })
    global['selected'][name] = data
  }

  function removeFormLine(name, index) {
    getFormLine(name)
    global['selected'][name] = global['selected'][name].filter((item, itemIndex) => {
      return itemIndex !== index
    })
    parseFormLine(name)
  }

  function exportSubmit() {
    getFormLine('export')
    if (!global['selected']['export'].length) {
      alert_msg('Chưa nhập hàng hóa')
    }
    else {
      $.post(
        "",
        {action: 'insert-export', data: global['selected']['export'], filter: checkFilter() },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#export-content").html(data['html'])
            $("#content").html(data['html2'])
            $('#export-modal-insert').modal('hide')
            global['selected']['export'] = []
            parseFormLine('export')
          }, () => {})
        }
      )
    }
  }

  function importSubmit() {
    getFormLine('import')
    if (!global['selected']['import'].length) {
      alert_msg('Chưa nhập hàng hóa')
    }
    else {
      $.post(
        "",
        {action: 'insert-import', data: global['selected']['import'], filter: checkFilter() },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#material-content").html(data['html'])
            $("#content").html(data['html2'])
            $('#import-modal-insert').modal('hide')
            global['selected']['import'] = []
            parseFormLine('import')
            // do nothing
            // return inserted item_id
          }, () => {})
        }
      )
    }
  }

  function importRemoveSubmit() {
    $.post(
      "",
      {action: 'remove-import', id: global['id'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#material-content").html(data['html'])
          $("#content").html(data['html2'])
          $('#import-modal-remove').modal('hide')
          // do nothing
          // return inserted item_id
        }, () => {})
      }
    )
  }

  function importRemove(id) {
    global['id'] = id
    $('#import-modal-remove').modal('show')
  }

  function exportRemove(id) {
    global['id'] = id
    $('#export-modal-remove').modal('show')
  }

  function exportRemoveSubmit() {
    $.post(
      "",
      {action: 'remove-export', id: global['id'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#export-content").html(data['html'])
          $("#content").html(data['html2'])
          $('#export-modal-remove').modal('hide')
          // do nothing
          // return inserted item_id
        }, () => {})
      }
    )
  }

  function editImportSubmit() {
    getFormLine('import')
    if (!global['selected']['import'].length) {
      alert_msg('Chưa nhập hàng hóa')
    }
    else {
      $.post(
        "",
        {action: 'edit-import', data: global['selected']['import']},
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#import-modal-content").html(data['html'])
            $('#import-insert-modal').modal('hide')
            // do nothing
            // return inserted item_id
          }, () => {})
        }
      )
    }
  }

  function checkImport(id) {
    $.post(
      "",
      {action: 'get-import', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['import_id'] = id
          global['selected']['import'] = data['import']
          parseFormLine('import')
          $("#import-button").hide()
          $("#edit-import-button").show()
          $('#import-modal-insert').modal('show')
        }, () => {})
      }
    )
  }

  function overlowFilter() {
    $.post(
      "",
      { action: 'overlow' },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#overlow-content").html(data['html'])
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->