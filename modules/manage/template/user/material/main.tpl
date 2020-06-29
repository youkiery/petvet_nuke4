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
      console.log(global['material'][index]);
      
      global['material'][index]['detail'].forEach((detail) => {
        $(`
          <tbody class="export" index="`+ detail['id'] + `" ia="` + global['ia'] + `">
            <tr>
              <td>
                `+ global['material'][index]['name'] + `
              </td>
              <td> <input class="form-control date-`+ global['ia'] + `" id="export-date-`+ global['ia'] + `" value="` + global['today'] + `"> </td>
              <td> `+ global['source'][detail['source']]['name'] +` </td>
              <td> <input class="form-control" id="export-number-`+ global['ia'] + `" value="`+ detail['number'] +`"> </td>
              <td> `+ parseTime(detail['expire']) +` </td>
              <td> <input class="form-control" id="export-note-`+ global['ia'] + `"> </td>
            </tr>
          </tbody>
        `).insertAfter('#export-insert-modal-content')
        $(".date-" + global['ia']).datepicker({
          format: 'dd/mm/yyyy',
          changeMonth: true,
          changeYear: true
        });
      });
    }
  }

  var getLine = {
    'import': () => {
      data = []
      msg = ''
      $(".import").each((index, item) => {
        ia = trim(item.getAttribute('ia'))
        temp = {
          id: global['material'][$('#import-type-val-' + ia).val()]['id'],
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
      msg = ''
      $(".export").each((index, item) => {
        ia = trim(item.getAttribute('ia'))
        id = trim(item.getAttribute('index'))
        temp = {
          id: id,
          date: $("#export-date-" + ia).val(),
          number: $("#export-number-" + ia).val(),
          note: $("#export-note-" + ia).val()
        }
        if (temp['number'] < 0) return msg = 'Số lượng đang âm'
        data.push(temp)
      })
      if (msg.length) return msg
      if (!data.length) return 'Chưa nhập mục nào'
      return data
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

  function searchAvaiableMaterial(keyword, name) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['material'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0 && item['detail'].length > 0) {
        count++
        html += `
          <div class="suggest-item" onclick="insertLine.export(` + index + `)">
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
        resolve(searchAvaiableMaterial(input, 'export'))
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
    global['ia'] = 0
    $("#export-button").show()
    $("#edit-export-button").hide()
    $("#export-insert-modal-content").html('')
    $("#export-modal-insert").modal('show')
  }
  // function exportModal() {
  //   $("#export-modal").modal('show')
  // }

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

  function exportSubmit() {
    sdata = getLine['export']()
    if (typeof (sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'insert-export', data: sdata }
      ).then(data => {
        alert_msg('Đã thêm toa xuất')
        global['material'] = data['material']
        $("#content").html(data['html'])
        $('#export-modal-insert').modal('hide')
        $('.export').remove()
      })
    }
  }

  function importSubmit() {
    sdata = getLine['import']()
    if (typeof (sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'insert-import', data: sdata }
      ).then(data => {
        alert_msg('Đã thêm toa nhập')
        global['material'] = data['material']
        $("#content").html(data['html'])
        $('#import-modal-insert').modal('hide')
        $('.import').remove()
      })
    }
  }

  function parseTime(time) {
    datetime = new Date(time * 1000)
    var date = datetime.getDate()
    var month = datetime.getMonth() + 1
    var year = datetime.getFullYear()
    return (date < 10 ? '0' : '') + date + '/' + (month < 10 ? '0' : '') + month + '/' + year
  }
</script>
<!-- END: main -->