<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="modal" role="dialog" id="modal-checked">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <!-- BEGIN: category -->
        <div style="overflow: auto;">
          <div style="width: 75%; float: left;">
            {category}
          </div>
          <button class="btn btn-info" style="float: right;" onclick="pickCategorySubmit({id})">
            Chọn
          </button>   
        </div>
        <hr>
        <!-- END: category -->
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

<div class="row" style="margin-bottom: 10px;">
  <div class="form-inline">
    <input type="text" class="form-control" id="insert-name" placeholder="Nhập thêm sản phẩm">
    <input type="text" class="form-control" id="insert-code" placeholder="Mã sản phẩm">
    <input type="text" class="form-control" id="insert-number" placeholder="Số lượng">
    <select class="form-control" id="insert-cate">
      <option value="0"> Chưa phân loại </option>
      <!-- BEGIN: category2 -->
      <option value="{id}"> {category} </option>
      <!-- END: category2 -->
    </select>
    <button class="btn btn-success" onclick="insert()"> Thêm hàng hóa </button>
    <button class="btn btn-info" onclick="excel()"> Thêm bằng excel </button>
  </div>
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
<button class="btn btn-info" onclick="pickCategory()">
  Cật nhật loại hàng
</button>

<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>
<script>
  var global = {
    page: 1,
    id: 0
  }
  var gals = ''
  var parse = []
  var selectFile = null

  $(document).ready(() => {
    installCheckAll()
  })
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

  function insert() {
    $.post(
      '',
      {action: 'insert', name: $("#insert-name").val(), code: $("#insert-code").val(), number: $("#insert-number").val(), cate_id: $("#insert-cate").val(), filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#insert-name").val('')
          $("#content").html(data['html'])
          installCheckAll()
        }, () => {}) 
      }
    )
  }

  function update(id) {
    $.post(
      '',
      {action: 'update', name: $("#item-" + id).val(), code: $("#item-code-" + id).val(), number: $("#item-number-" + id).val(), id: id},
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
        }, () => {}) 
      }
    )
  }
  function pickCategory(id = 0) {
    if (id) {
      global['id'] = id
    }
    $("#modal-checked").modal('show')
  }
  function pickCategorySubmit(id) {
    if (!global['id']) {
      list = []
      $(".event-checkbox:checked").each((index, item) => {
        list.push(item.getAttribute('id').replace('item-check-', ''))
      })
      global['id'] = list.join(', ');
    }
    $.post(
      '',
      {action: 'pick-category', id: id, list: global['id'], filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = 0
          $('#content').html(data['html'])
          installCheckAll()
          $("#modal-checked").modal('hide')
        }, () => {}) 
      }
    )
  }

  function installCheckAll() {
    $("#item-check-all").change((e) => {
      checked = e.currentTarget.checked 
      $(".event-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
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