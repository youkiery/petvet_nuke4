<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

{modal}

<div id="msgshow"></div>

<div class="form-group">
  <button class="btn btn-info" onclick='$("#modal-expire").modal("show")'>
    Danh sách vật tư hết hạn
  </button>
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

<script src="/modules/core/js/vremind-5.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
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
    },
    'type': {
      0: 'Nope'
    },
    'name': '',
    'today': '{today}'
  }
  var parseLine = {
    'import': () => {
      html = ''
      global['selected']['import'].forEach((item, index) => {
        html += `
          <tr class="import" index="`+ index +`">
            <th> `+ (index + 1) +` </th>
            <th> <input type="text" class="form-control" id="import-type-`+ index +`" value="`+ (global['type'][item['type']]) +`"> </th>
            <th> <input type="text" class="form-control date" id="import-date-`+ index +`" value="`+ item['date'] +`"> </th>
            <th> <input type="text" class="form-control" id="import-source-`+ index +`" value="`+ item['source'] +`"> </th>
            <th> <input type="text" class="form-control" id="import-number-`+ index +`" value="`+ item['number'] +`"> </th>
            <th> <input type="text" class="form-control date" id="import-expire-`+ index +`" value="`+ item['expire'] +`"> </th>
            <th> <input type="text" class="form-control" id="import-note-`+ index +`" value="`+ item['note'] +`"> </th>
          </tr>`
      })
      $('#import-insert-modal-content').html(html)
      $(".date").datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
      });
    },
    'export': () => {

    }
  }

  var getLine = {
    'import': () => {
      data = []
      $(".import").each((index, item) => {
        indexX = trim(item.getAttribute('index'))
        data.push({
          index: indexX,
          id: global['material'][indexX]['id'],
          type: $('#import-type-'+ indexX).val(),
          date: $('#import-date-'+ indexX).val(),
          source: $('#import-source-'+ indexX).val(),
          number: $('#import-number-'+ indexX).val(),
          expire: $('#import-expire-'+ indexX).val(),
          note: $('#import-note-'+ indexX).val()
        })
      })
      global['selected']['import'] = data
    },
    'export': () => {
      data = []
      $("." + name).each((index, item) => {
        indexX = trim(item.getAttribute('index'))
        // indexX = trim(item.getAttribute('id').replace('import-index-', ''))
        data.push({
          index: indexX,
          id: global['material'][indexX]['id'],
          date: $("#" + name + "-date-" + index).val(),
          number: $("#" + name + "-number-" + index).val(),
          status: $("#" + name + "-status-" + index).val()
        })
      })
      global['selected']['export'] = data
    }
  }

  function searchMaterial(keyword, name) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['material'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0) {
        count++
        html += `
            <div class="suggest-item" onclick="selectItem('`+ name + `', ` + index + `)">
              `+ item['name'] + `
            </div>`
      }
    })
    if (!html.length) return 'Không có kết quả'
    return html
  }

  $(document).ready(() => {
    vremind.install('#import-item-finder', '#import-item-finder-suggest', (input => {
      return new Promise(resolve => {
        resolve(searchMaterial(input, 'import'))
      })
    }), 300, 300)
    vremind.install('#export-item-finder', '#export-item-finder-suggest', (input => {
      return new Promise(resolve => {
        resolve(searchMaterial(input, 'export'))
      })
    }), 300, 300)
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function materialModal(name) {
    global['name'] = name
    $("#material-modal").modal('show')
  }
  // function importModal() {
  //   $("#import-modal").modal('show')
  // }
  function importModal() {
    $("#import-button").show()
    $("#edit-import-button").hide()
    global['selected']['import'] = []
    parseFormLine('import')
    $("#import-modal-insert").modal('show')
  }
  function exportModal() {
    $("#export-button").show()
    $("#edit-export-button").hide()
    $("#export-modal-insert").modal('show')
  }
  // function exportModal() {
  //   $("#export-modal").modal('show')
  // }

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
    sdata = checkMaterialData()
    vhttp.checkelse('', { action: 'insert-material', data: sdata, filter: checkFilter() }).then(data => {
      global['material'].push(data['json'])
      $("#material-name").val('')
      $("#material-unit").val('')
      $("#material-number").val('')
      $("#material-description").val('')
      $("#" + global['name'] + "-item-finder").val(sdata['name'])
      parseLine(global['name'])
      $("#content").html(data['html'])
      $("#material-modal").modal('hide')
    })
  }

  function selectItem(name, index) {
    selected = global['material'][index]
    $("#" + name + "-item-finder").val(selected['name'])
    getLine[name]()
    checkSelected(name, global['material'][index]['id'])
    parseLine[name]()
    // if (global['material'][index]['link']) {
    //   checkSelected(name, global['material'][index]['link'])
    // }
    // parseFormLine(name)
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
        checker2 = true
        // đẩy item về đầu
        for (let i = index; i > 0; i--) {
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
        type: 0,
        date: global['today'],
        source: 0,
        number: 0,
        expire: global['today'],
        note: ''
      })
      // đẩy item về đầu
      for (let i = global['selected'][name].length - 1; i > 0; i--) {
        swapItem(name, i, i - 1)
      }
    }
  }

  function expireSubmit(id) {
    $.post(
      '', { action: 'expire', id: id, limit: $("#expire-limit").val() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#expire-content").html(data['html'])
        })
      }
    )
  }

  function expireFilter() {
    $.post(
      '', { action: 'expire-filter', limit: $("#expire-limit").val() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#expire-content").html(data['html'])
        })
      }
    )
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
        <tbody class="`+ name + `" id="` + name + `-index-` + index + `" index="` + item['index'] + `">
          <tr>
            <td>
              `+ (index + 1) + `
            </td>
            <td>
              `+ (global['material'][item['index']]['name']) + `
            </td>
            <td>
              <input class="form-control date" id="`+ name + `-date-` + index + `" value="` + (item['date']) + `">
            </td>
            <td>
              <input class="form-control" id="`+ name + `-number-` + index + `" value="` + (item['number']) + `">
            </td>
            <td>
              <input class="form-control" id="`+ name + `-status-` + index + `" value="` + (item['status']) + `">
            </td>
            <td>
              <button class="btn btn-danger" onclick="removeFormLine('`+ name + `', ` + index + `)">
                <span class="glyphicon glyphicon-remove"> <span>
              </button>
            </td>
          </tr>
        </tbody>`
    })
    $("#" + name + "-insert-modal-content").html(html)
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
        date: $("#" + name + "-date-" + index).val(),
        number: $("#" + name + "-number-" + index).val(),
        status: $("#" + name + "-status-" + index).val()
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
        { action: 'insert-export', data: global['selected']['export'], filter: checkFilter() },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#export-content").html(data['html'])
            $("#content").html(data['html2'])
            $('#export-modal-insert').modal('hide')
            global['selected']['export'] = []
            parseFormLine('export')
          }, () => { })
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
        { action: 'insert-import', data: global['selected']['import'], filter: checkFilter() },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#material-content").html(data['html'])
            $("#content").html(data['html2'])
            $('#import-modal-insert').modal('hide')
            global['selected']['import'] = []
            parseFormLine('import')
            // do nothing
            // return inserted item_id
          }, () => { })
        }
      )
    }
  }

  function importRemoveSubmit() {
    $.post(
      "",
      { action: 'remove-import', id: global['id'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#material-content").html(data['html'])
          $("#content").html(data['html2'])
          $('#import-modal-remove').modal('hide')
          // do nothing
          // return inserted item_id
        }, () => { })
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
      { action: 'remove-export', id: global['id'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#export-content").html(data['html'])
          $("#content").html(data['html2'])
          $('#export-modal-remove').modal('hide')
          // do nothing
          // return inserted item_id
        }, () => { })
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
        { action: 'edit-import', data: global['selected']['import'] },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#import-modal-content").html(data['html'])
            $('#import-insert-modal').modal('hide')
            // do nothing
            // return inserted item_id
          }, () => { })
        }
      )
    }
  }

  function checkImport(id) {
    $.post(
      "",
      { action: 'get-import', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          global['import_id'] = id
          global['selected']['import'] = data['import']
          parseFormLine('import')
          $("#import-button").hide()
          $("#edit-import-button").show()
          $('#import-modal-insert').modal('show')
        }, () => { })
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
        }, () => { })
      }
    )
  }
</script>
<!-- END: main -->