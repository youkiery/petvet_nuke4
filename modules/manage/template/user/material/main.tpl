<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

{modal}

<style>
  select.form-control {
    padding: 0px;
  }

  .suggest {
    z-index: 10;
  }
</style>

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
    'ia': 0,
    'index': 0,
    'name': '',
    'today': '{today}',
    'source': JSON.parse('{source}')
  }
  var insertLine = {
    'import': () => {
      global['ia']++
      $(`
        <tbody class="import" ia="` + global['ia'] + `">
          <tr>
            <td>
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="import-type-`+ global['ia'] + `">
                  <input type="hidden" class="form-control" id="import-type-val-`+ global['ia'] + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="materialModal('import', `+ global['ia'] + `)">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="import-type-suggest-`+ global['ia'] + `"></div>
              </div>
            </td>
            <td> <input class="form-control date-`+ global['ia'] + `" id="import-date-` + global['ia'] + `" value="` + global['today'] + `"> </td>
            <td> 
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="import-source-`+ global['ia'] + `">
                  <input type="hidden" class="form-control" id="import-source-val-`+ global['ia'] + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="insertSource('import', `+ global['ia'] + `)">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="import-source-suggest-`+ global['ia'] + `"></div>
              </div>
            </td>
            <td> <input class="form-control" id="import-number-`+ global['ia'] + `" value="0"> </td>
            <td> <input class="form-control date-`+ global['ia'] + `" id="import-expire-` + global['ia'] + `" value="` + global['today'] + `"> </td>
            <td> <input class="form-control" id="import-note-`+ global['ia'] + `"> </td>
          </tr>
        </tbody>
      `).insertAfter('#import-insert-modal-content')
      vremind.install('#import-type-' + global['ia'], '#import-type-suggest-' + global['ia'], (input => {
        return new Promise(resolve => {
          resolve(searchMaterial(input, 'import', global['ia']))
        })
      }), 300, 300)
      vremind.install('#import-source-' + global['ia'], '#import-source-suggest-' + global['ia'], (input => {
        return new Promise(resolve => {
          resolve(searchSource(input, 'import', global['ia']))
        })
      }), 300, 300)
      $(".date-" + global['ia']).datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
      });
    },
    'export': (index) => {
      global['ia']++
      $(`
        <tbody class="export" index="`+ index + `" ia="` + global['ia'] + `">
          <tr>
            <td>
              `+ global['material'][index]['name'] + `
            </td>
            <td>
              <div class="input-group">
                <select class="form-control" id="import-type-`+ global['ia'] + `">
                  `+ global['type_option'] + `
                </select>
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="insertType('import', `+ global['ia'] + `)">
                    <span class="glyphicon glyphicon-plus"></span>
                  </button>
                </div>
              </div>
            </td>
            <td> <input class="form-control date" id="import-date-`+ global['ia'] + `" value="` + global['today'] + `"> </td>
            <td> 
              <div class="input-group">
                <select class="form-control" id="import-source-`+ global['ia'] + `">
                  `+ global['source_option'] + `
                </select>
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="insertSource('import', `+ global['ia'] + `)">
                    <span class="glyphicon glyphicon-plus"></span>
                  </button>
                </div>
              </div>
            </td>
            <td> <input class="form-control" id="import-number-`+ global['ia'] + `" value="0"> </td>
            <td> <input class="form-control date" id="import-expire-`+ global['ia'] + `" value="` + global['today'] + `"> </td>
            <td> <input class="form-control" id="import-note-`+ global['ia'] + `"> </td>
          </tr>
        </tbody>
      `).insertAfter('#export-insert-modal-content')
      $(".date").datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
      });
    },
  }

  var getLine = {
    'import': () => {
      data = []
      msg = ''
      $(".import").each((index, item) => {
        ia = trim(item.getAttribute('ia'))
        temp = {
          id: $('#import-type-val-' + ia).val(),
          date: $('#import-date-' + ia).val(),
          source: $('#import-source-val-' + ia).val(),
          number: $('#import-number-' + ia).val(),
          expire: $('#import-expire-' + ia).val(),
          note: $('#import-note-' + ia).val()
        }
        if (!temp['id']) return msg = 'Chưa chọn hóa chất'
        if (!temp['source']) return msg = 'Chưa chọn nguồn cung'
        data.push(temp)
      })
      if (msg.length) return msg
      if (!data.length) return 'Chưa nhập mục nào'
      return data
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

  function searchMaterial(keyword, name, ia) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['material'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0) {
        count++
        html += `
            <div class="suggest-item" onclick="selectItem('`+ name + `', ` + index + `, ` + ia + `)">
              `+ item['name'] + `
            </div>`
      }
    })
    if (!html.length) return 'Không có kết quả'
    return html
  }

  function searchSource(keyword, name, ia) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['source'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0) {
        count++
        html += `
          <div class="suggest-item" onclick="selectSource('`+ name + `', ` + index + `, ` + ia + `)">
            `+ item['name'] + `
          </div>`
      }
    })
    if (!html.length) return 'Không có kết quả'
    return html
  }

  $(document).ready(() => {
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

  function materialModal(name, ia) {
    global['name'] = name
    global['ia'] = ia
    $("#material-name").val('')
    $("#material-unit").val('')
    $("#material-number").val('')
    $("#material-description").val('')
    $("#material-modal").modal('show')
  }
  // function importModal() {
  //   $("#import-modal").modal('show')
  // }
  function importModal() {
    // $("#import-button").show()
    // $("#edit-import-button").hide()
    // global['selected']['import'] = []
    // parseFormLine('import')
    global['ia'] = 0
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
    unit = $("#material-unit").val()
    description = $("#material-description").val()

    if (!name.length) alert_msg('Nhập tên trước khi thêm')

    return {
      name: name,
      unit: unit,
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

  function insertType(name, index) {
    global['name'] = name
    global['index'] = index
    $('#type-name').val('')
    $('#type-modal').modal('show')
  }

  function insertTypeSubmit() {
    vhttp.checkelse('', { action: 'insert-type', name: $('#type-name').val() }).then(data => {
      global['type_option'] = data['html']
      $('#' + global['name'] + '-type-' + global['index']).html(global['type_option'])
      $('#' + global['name'] + '-type-' + global['index']).val(data['id'])
      $('#type-modal').modal('hide')
    })
  }

  function insertSource(name, index) {
    global['name'] = name
    global['index'] = index
    $('#source-name').val('')
    $('#source-note').val('')
    $('#source-modal').modal('show')
  }

  function insertSourceSubmit() {
    vhttp.checkelse('', { action: 'insert-source', name: $('#source-name').val(), name: trim($('#source-note').val()) }).then(data => {
      global['source_option'] = data['html']
      $('#' + global['name'] + '-source-' + global['index']).val($('#source-name').val())
      $('#' + global['name'] + '-source-val-' + global['index']).val(data['id'])
      $('#source-modal').modal('hide')
    })
  }

  function insertMaterial() {
    sdata = checkMaterialData()
    vhttp.checkelse('', { action: 'insert-material', data: sdata, filter: checkFilter() }).then(data => {
      global['material'].push(data['json'])
      selected = global['material'][global['material'].length - 1]
      $("#" + global['name'] + "-type-val-" + global['ia']).val(selected['id'])
      $("#" + global['name'] + "-type-" + global['ia']).val(selected['name'])
      $("#content").html(data['html'])
      $("#material-modal").modal('hide')
    })
  }

  function selectItem(name, index, ia) {
    selected = global['material'][index]
    $("#" + name + "-type-val-" + ia).val(selected['id'])
    $("#" + name + "-type-" + ia).val(selected['name'])
  }

  function selectSource(name, index, ia) {
    selected = global['source'][index]
    $("#" + name + "-source-val-" + ia).val(selected['id'])
    $("#" + name + "-source-" + ia).val(selected['name'])
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
    sdata = getLine['import']()
    if (typeof(sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'insert-import', data: sdata }
      ).then(data => {
        alert_msg('Đã thêm toa nhập')
        $("#content").html(data['html'])
        $('#import-modal-insert').modal('hide')
        $('.import').remove()
      })
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