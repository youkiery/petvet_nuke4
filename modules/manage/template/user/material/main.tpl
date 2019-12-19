<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{import_modal}
{import_modal_insert}
{import_modal_remove}
{export_modal}
{export_modal_insert}
{export_modal_remove}
{material_modal}
<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="materialModal()">
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
<button class="btn btn-danger">
  remove all
</button>  
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    page: {
      'main': 1
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

  function insertMaterial() {
    $.post(
      "",
      { action: 'insert-material', data: checkMaterialData() },
      (response, status) => {
        checkResult(response, status).then(data => {
          global['material'].push(data['json'])
          $("#material-name").val('')
          $("#material-unit").val('')
          $("#material-description").val('')
          $("#content").html(data['html'])
        }, () => {})
      }
    )
  }

  function itemFilter(name) {
    input = $("#"+ name +"-item-finder")
    suggest = $("#"+ name +"-item-finder-suggest")
    count = 0

    input.keyup((e) => {
      keyword = input.val()
      html = ''

      global['material'].forEach((item, index) => {
        if (count < 30 && item['name'].search(keyword) >= 0) {
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
    global['selected'][name].push({
      index: index,
      id: global['material'][index]['id'],
      date: '',
      number: 1,
      status: '',
    })
    parseFormLine(name)
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
              <input class="form-control" id="`+ name +`-date-`+ index +`" value="`+ (item['date']) +`">
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
        {action: 'insert-export', data: global['selected']['export']},
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
        {action: 'insert-import', data: global['selected']['import']},
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
      {action: 'remove-import', id: global['id']},
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
      {action: 'remove-export', id: global['id']},
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
</script>
<!-- END: main -->