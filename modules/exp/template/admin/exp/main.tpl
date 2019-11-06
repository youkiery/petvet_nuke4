<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">

<div class="modal" id="modal-number" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div id="number-content">

        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal-excel" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div style="text-align: center; position: relative;">
          <p> Chọn file .XSLS từ thiết bị </p>
          <div style="margin: auto;">
            <div style="position: absolute;"></div>
              <label class="filebutton">
                <div style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                  +
                </div>
                
                <span>
                  <input type="file" class="fileinput" id="file" onchange="tick(event)">
                </span>
              </label>
          </div>
        </div>
        
        <div id="error" style="color: red; font-weight: bold; font-size: 1.2em;">
        
        </div>
        <div id="notice" style="color: green; font-weight: bold; font-size: 1.2em;">
        
        </div>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-8">
    <div class="relative">
      <input type="text" class="form-control" id="insert-name" placeholder="Tìm kiếm hàng hóa">
      <div class="suggest" id="insert-name-suggest"></div>
    </div>
    <p> Đang chọn: <span id="selected-item-name"> Chưa chọn </span> </p>
    <input type="hidden" id="selected-item-id" value="">
  </div>
  <div class="col-sm-8">
    <input type="text" class="form-control" id="insert-number" value="0">
  </div>
  <div class="col-sm-8">
    <input type="text" class="form-control" id="insert-date" value="{today}">
  </div>
</div>
<div class="text-center">
  <button class="btn btn-info" onclick="insert()"> Thêm hạn sử dụng </button>
  <button class="btn btn-info" onclick="excel()"> Thêm bằng excel </button>
</div>
<label class="form-inline">
  Số dòng một trang: <input type="text" class="form-control" id="filter-limit" value="10">
  <button class="btn btn-info" onclick="goPage(1)">
    Hiển thị
  </button>
</label>

<div id="msgshow"></div>

<div id="content">
  {content}
</div>
<button class="btn btn-info" onclick="updateNumber()">
  Cập nhật số lượng theo mã
</button>

<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var global = {
    page: 1,
    item: JSON.parse('{item}'),
    items: JSON.parse('{items}'),
    selected: {
      id: 0, name: ''
    }
  }
  var gals = ''
  var parse = []
  var selectFile = null

  $(document).ready(() => {
    installSuggest('insert-name', 'insert-name-suggest', 'selected-item-id')
    global['items'].forEach(item => {
      installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
    })
    $("#insert-date, .date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
    installCheckAll()
  })

  function insert() {
    id = $("#selected-item-id").val()
    if (!id) {
      alert_msg('Chưa chọn sản phẩm')
    }
    else {
      $.post(
        '',
        {action: 'insert', id: id, number: $("#insert-number").val(), date: $("#insert-date").val(), filter: checkFilter()},
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#content").html(data['html'])
            installCheckAll()
            data['list'].forEach(item => {
              installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
            })
            $(".date").datepicker({
              format: 'dd/mm/yyyy',
              changeMonth: true,
              changeYear: true
            })
          }, () => {}) 
        }
      )
    }
  }

  function update(id) {
    $.post(
      '',
      {action: 'update', name: $("#item-" + id).val(), number: $("#item-number-" + id).val(), date: $("#item-date-" + id).val(), id: id, rid: $("#item-id-" + id).val()},
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => {}) 
      }
    )
  }

  function remove(id) {
    $.post(
      '',
      {action: 'remove', id: id, filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          installCheckAll()
          data['list'].forEach(item => {
            installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
          })
          $(".date").datepicker({
            format: 'dd/mm/yyyy',
            changeMonth: true,
            changeYear: true
          })
        }, () => {}) 
      }
    )
  }

  function checkFilter() {
    page = global['page']
    limit = $("#filter-limit").val()
    if (Number(page) < 0) {
      page = 1
    }
    if (Number(limit) < 10) {
      limit = 10
    }
    return {
      page: page,
      limit: limit
    }
  }

  function goPage(page) {
    $.post(
      '',
      {action: 'filter', filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['page'] = page
          $('#content').html(data['html'])
          installCheckAll()
        }, () => {}) 
      }
    )
  }

  function selectItem(id, name, input, hidden) {
    global['selected'] = {
      id: id,
      name: name
    }
    $("#" + input).val(name)
    $("#" + hidden).val(id)
    if (input == 'insert-name') $("#selected-item-name").text(name)
  }

  function installCheckAll() {
    $("#item-check-all").change((e) => {
      checked = e.currentTarget.checked 
      $(".event-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }

  function updateNumber() {
    list = []
    $('.event-checkbox:checked').each((index, item) => {
      list.push(item.getAttribute('id').replace('item-check-', ''))
    })
    if (list.length) {
      $.post(
        '',
        {action: 'get-update-number', list: list},
        (response, status) => {
          checkResult(response, status).then(data => {
            $('#number-content').html(data['html'])
            $("#modal-number").modal('show')
            installCheckAll()
          }, () => {}) 
        }
      )
    }
  }

  function updateNumberSubmit() {
    list = {}
    $(".number").each((index, item) => {
      list[item.getAttribute('id').replace('number-', '')] = item.value
    })    
    $.post(
      '',
      {action: 'update-number', list: list, filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#content').html(data['html'])
          $("#modal-number").modal('hide')
          installCheckAll()
        }, () => {}) 
      }
    )
  }

  function installSuggest(input, suggest, hidden) {
    var inputObj = $("#" + input)
    var suggestObj = $("#" + suggest)
    inputObj.keyup(e => {
      key = convert(e.currentTarget.value)
      
      list = global['item'].filter(item => {
        return item['key'].search(key) >= 0
      })
      html = ''
      if (list.length) {
        list.forEach(item => {
          html += `
            <div class="suggest-item" onclick="selectItem(`+ item['id'] +`, '`+ item['name'] +`', '`+ input +`', '`+ hidden +`')">
              `+ item['name'] +`
            </div>
          `
        })
      }
      else {
        html = 'Không có kết quả'
      }
      suggestObj.html(html)
    })
    inputObj.focus(() => {
      suggestObj.show()
    })
    inputObj.blur(() => {
      setTimeout(() => {
        suggestObj.hide()
      }, 200);
    })
  }

  function excel() {
    $("#modal-excel").modal('show')
  }

  var ExcelToJSON = function() {
    this.parseExcel = function(file) {
      reset()
      var reader = new FileReader();

      reader.onload = function(e) {
        var data = e.target.result;
        var workbook = XLSX.read(data, {
          type: 'binary'
        });

        // workbook.SheetNames.forEach(function(sheetName) {
          // Here is your object
          var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[workbook.SheetNames[0]]);
          pars = JSON.stringify(XL_row_object);
          
          if (pars.length > 10) {
            gals = convertobj(XL_row_object)
            posted()
          }
        // })
        document.getElementById('file').value = null;
      };

      reader.onerror = function(ex) {
        showNotice("Tệp excel chọn bị lỗi, không thể trích xuất dữ liệu")
        console.log(ex);
      };

      if (file) {
        reader.readAsBinaryString(file);
      }
    };
  };
  var js = new ExcelToJSON()

  function tick(e) {
    selectFile = e.target.files[0]
    js.parseExcel(selectFile)
    reset()
  }

  function refresh() {
    js.parseExcel(selectFile)
  }

  function reset() {
    $("#notice").html('')
    $("#error").html('')
  }

  function showNotice(text) {
    $("#error").text(text)
    $("#error").show()
    setTimeout(() => {
      $("#error").fadeOut(1000)
    }, 1000);
  }

  function posted() {
    $.post(
      strHref,
      {action: 'check', data: gals, filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $("#notice").html(data['notify'])
          if (data['error']) {
            $("#error").html(data['error'])
          }
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
