<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{import_modal}
{import_modal_insert}
{export_modal}
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
    import
  </button>  
  <button class="btn btn-info">
    export
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
      'import': []
    }
  }

  $(document).ready(() => {
    itemFilter()
    input = $("#import-item-finder")
    suggest = $("#import-item-finder-suggest")
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
  })

  function materialModal() {
    $("#material-modal").modal('show')
  }
  function importModal() {
    $("#import-modal").modal('show')
  }
  function insertImportModal() {
    $("#import-modal-insert").modal('show')
  }
  function exportModal() {
    $("#export-modal").modal('show')
  }

  function checkMaterialData() {
    type = $("[name=type]")[1].checked
    type = (type ? 1 : 0)
    return {
      name: $("#material-name").val(),
      unit: $("#material-unit").val(),
      type: type,
      description: $("#material-description").val(),
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

  function itemFilter() {
    input = $("#import-item-finder")
    suggest = $("#import-item-finder-suggest")
    keyword = input.value
    html = ''
    count = 0

    global['material'].forEach((item, index) => {
      if (count < 30 && item['name'].search(keyword) >= 0) {
        count ++
        html += `
          <div class="suggest-item" onclick="selectItem(`+ index +`)">
            `+ item['name'] +`
          </div>`
      }
    })
    if (!html.length) {
      html = 'Không có kết quả'
    }
    suggest.html(html)
    input.focus()
  }

  function selectItem(index) {
    selected = global['material'][index]
    $("#import-item-finder").val(selected['name'])
    getImport()
    global['selected']['import'].push({
      index: index,
      id: global['material'][index]['id'],
      date: '',
      number: 1,
      status: '',
    })
    parseImport()
  }

  function parseImport() {
    var html = ''
    global['selected']['import'].forEach((item, index) => {
      html += `
        <tbody class="import" id="import-index-`+ index +`" index="`+ item['index'] +`">
          <tr>
            <td>
              `+ (index + 1) +`
            </td>
            <td>
              `+ (global['material'][item['index']]['name']) +`
            </td>
            <td>
              <input class="form-control" id="import-date-`+ index +`" value="`+ (item['date']) +`">
            </td>
            <td>
              <input class="form-control" id="import-number-`+ index +`" value="`+ (item['number']) +`">
            </td>
            <td>
              <input class="form-control" id="import-status-`+ index +`" value="`+ (item['status']) +`">
            </td>
            <td>
              <button class="btn btn-danger" onclick="removeImport(`+ index +`)">
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
    $("#import-insert-modal-content").html(html)
  }

  function getImport() {
    data = []
    $(".import").each((index, item) => {
      indexX = trim(item.getAttribute('index'))
      // indexX = trim(item.getAttribute('id').replace('import-index-', ''))
      data.push({
        index: indexX,
        id: global['selected']['import'][indexX]['id'],
        date: $("#import-date-" + index).val(),
        number: $("#import-number-" + index).val(),
        status: $("#import-status-" + index).val()
      })
    })
    global['selected']['import'] = data
  }

  function removeImport(index) {
    getImport()
    global['selected']['import'] = global['selected']['import'].filter((item, itemIndex) => {
      return itemIndex !== index
    })
    parseImport()
  }

  function importSubmit() {
    getImport()
    if (!global['selected']['import'].length) {
      alert_msg('Chưa nhập hàng hóa')
    }
    else {
      $.post(
        "",
        {action: 'insert-import', data: global['selected']['import']},
        (response, status) => {
          checkResult(response, status).then(data => {
            console.log(data);
            
            $("#material-content").html(data['html'])
            $('#import-modal-insert').modal('hide')
            // do nothing
            // return inserted item_id
          }, () => {})
        }
      )
    }
  }

  function editImportSubmit() {
    getImport()
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
          global['import'] = data['import']
          parseImport()
          $("#import-button").hide()
          $("#edit-import-button").show()
          $('#import-insert-modal').modal('show')
        }, () => {})
      }
    )
  }


  // function checkItemData() {
  //   name = $("#item-name").val()
  //   unit = $("#item-unit").val()
  //   number = $("#item-number").val()
  //   status = $("#item-status").val()
  //   company = $("#item-company").val()
  //   description = $("#item-description").val()
  //   if (!name.length) {
  //     alert_msg('Tên thiết bị trống')
  //     return false
  //   }
  //   else {
  //     return {
  //       name: name,
  //       unit: unit,
  //       number: number > 0 ? number : 0,
  //       status: status,
  //       company: company,
  //       description: description
  //     }
  //   }
  // }

  // function itemInsertsubmit() {
  //   if (data = checkItemData()) {
  //     $.post(
  //       "",
  //       {action: 'insert-item', data: data},
  //       (response, status) => {
  //         checkResult(response, status).then(data => {
  //           // do nothing
  //           // return inserted item_id
  //         }, () => {})
  //       }
  //     )
  //   }
  // }

  // function importSubmit() {
  //   getImport()
  //   if (!global['import'].length) {
  //     alert_msg('Chưa nhập hàng hóa')
  //   }
  //   else {
  //     $.post(
  //       "",
  //       {action: 'insert-import', data: global['import']},
  //       (response, status) => {
  //         checkResult(response, status).then(data => {
  //           $("#import-modal-content").html(data['html'])
  //           $('#import-insert-modal').modal('hide')
  //           // do nothing
  //           // return inserted item_id
  //         }, () => {})
  //       }
  //     )
  //   }
  // }

  // function editImportSubmit() {
  //   getImport()
  //   if (!global['import'].length) {
  //     alert_msg('Chưa nhập hàng hóa')
  //   }
  //   else {
  //     $.post(
  //       "",
  //       {action: 'edit-import', data: global['import']},
  //       (response, status) => {
  //         checkResult(response, status).then(data => {
  //           $("#import-modal-content").html(data['html'])
  //           $('#import-insert-modal').modal('hide')
  //           // do nothing
  //           // return inserted item_id
  //         }, () => {})
  //       }
  //     )
  //   }
  // }

  // function importInsert() {
  //   global['import'] = []
  //   parseImport()
  //   $("#import-button").show()
  //   $("#edit-import-button").hide()
  //   $('#import-insert-modal').modal('show')
  // }

  // function checkImport(id) {
  //   $.post(
  //     "",
  //     {action: 'get-import', id: id},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         global['import_id'] = id
  //         global['import'] = data['import']
  //         parseImport()
  //         $("#import-button").hide()
  //         $("#edit-import-button").show()
  //         $('#import-insert-modal').modal('show')
  //       }, () => {})
  //     }
  //   )
  // }

  // function checkFilter() {
  //   limit = $("#filter-limit").val()
  //   return {
  //     page: global['page'],
  //     limit: limit > 10 ? limit : 10
  //   }
  // }

  // function goPage(page) {
  //   global['page'] = page
  //   $.post(
  //     "",
  //     {action: 'filter', filter: checkFilter()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         $("#content").html(data['html'])
  //       }, () => {})
  //     }
  //   )
  // }

  // function itemFilter() {
  //   input = $("#import-item-finder")
  //   suggest = $("#import-item-finder-suggest")
  //   keyword = input.value
  //   html = ''
  //   count = 0

  //   global['item'].forEach((item, index) => {
  //     if (count < 30 && item['name'].search(keyword) >= 0) {
  //       count ++
  //       html += `
  //         <div class="suggest-item" onclick="selectItem(`+ index +`)">
  //           `+ item['name'] +`
  //         </div>`
  //     }
  //   })
  //   if (!html.length) {
  //     html = 'Không có kết quả'
  //   }
  //   suggest.html(html)
  //   input.focus()
  // }

  // function selectItem(index) {
  //   selected = global['item'][index]
  //   $("#import-item-finder").val(selected['name'])
  //   getImport()
  //   global['import'].push({
  //     index: index,
  //     id: global['item'][index]['id'],
  //     date: '',
  //     number: 1,
  //     status: '',
  //   })
  //   parseImport()
  // }

  // function removeImport(index) {
  //   getImport()
  //   global['import'] = global['import'].filter((item, itemIndex) => {
  //     return itemIndex !== index
  //   })
  //   parseImport()
  // }

  // function parseImport() {
  //   var html = ''
  //   global['import'].forEach((item, index) => {
  //     html += `
  //       <tbody class="import" id="export-index-`+ index +`" index="`+ item['index'] +`">
  //         <tr>
  //           <td>
  //             `+ (index + 1) +`
  //           </td>
  //           <td>
  //             `+ (global['item'][item['index']]['name']) +`
  //           </td>
  //           <td>
  //             <input class="form-control" id="export-date-`+ index +`" value="`+ (item['date']) +`">
  //           </td>
  //           <td>
  //             <input class="form-control" id="export-number-`+ index +`" value="`+ (item['number']) +`">
  //           </td>
  //           <td>
  //             <input class="form-control" id="export-status-`+ index +`" value="`+ (item['status']) +`">
  //           </td>
  //           <td>
  //             <button class="btn btn-danger" onclick="removeImport(`+ index +`)">
  //               <span class="glyphicon glyphicon-remove"> <span>
  //             </button>
  //           </td>
  //         </tr>
  //       </tbody>`
  //   })
  //   html = `
  //     <table class="table table-bordered">
  //       <thead>
  //         <tr>
  //           <th class="cell-center"> STT </th>
  //           <th class="cell-center"> Tên thiết bị </th>
  //           <th class="cell-center"> Ngày hết hạn </th>
  //           <th class="cell-center"> Số lượng </th>
  //           <th class="cell-center"> Chất lượng </th>
  //           <th></th>
  //         </tr>
  //       </thead>
  //       `+ html +`
  //     </table>`
  //   $("#import-insert-modal-content").html(html)
  // }

  // function getImport() {
  //   data = []
  //   $(".import").each((index, item) => {
  //     index = trim(item.getAttribute('id').replace('export-index-', ''))
  //     data.push({
  //       index: item.getAttribute('index'),
  //       id: global['item'][index]['id'],
  //       date: $("#export-date-" + index).val(),
  //       number: $("#export-number-" + index).val(),
  //       status: $("#export-status-" + index).val()
  //     })
  //   })
  //   global['import'] = data
  // }
</script>
<!-- END: main -->