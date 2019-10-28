<!-- BEGIN: main -->
<style>
  label.filebutton {
      widows: 300px;
      height: 200px;
      overflow:hidden;
      position:relative;
  }
  
  label span input {
      z-index: 999;
      line-height: 0;
      font-size: 50px;
      position: absolute;
      top: -2px;
      left: -700px;
      opacity: 0;
      filter: alpha(opacity = 0);
      -ms-filter: "alpha(opacity=0)";
      cursor: pointer;
      _cursor: hand;
      margin: 0;
      padding:0;
  }
  </style>
  
  <a href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/dispatch.xlsx"> Tải về tệp mẫu </a>
  
  <div style="text-align: center; position: relative;">
    <div style="margin: auto;">
      <div style="position: absolute;"></div>
        <label class="filebutton">
          <div style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
            +
          </div>
          
          <!-- <img src="/themes/admin_default/images/logo_small.png" alt=""> -->
          <span>
            <input type="file" id="file" onchange="tick(event)">
          </span>
        </label>
    </div>
  </div>
  
  
  <!-- <button class="btn btn-info">
    Tải lại
  </button>
  
  <button class="btn btn-info" onclick="posted()">
    Thử lại
  </button> -->
  
  <div id="error" style="color: red; font-weight: bold; font-size: 1.2em;">
  
  </div>
  <div id="notice" style="color: green; font-weight: bold; font-size: 1.2em;">
  
  </div>
  
  <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
  <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>
  <script>
    var global = ''
    var parse = []
    var selectFile = null
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
            
            if (pars.length > 100) {
              global = XL_row_object
              console.log(global);
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
        {action: 'check', data: global},
        (response, status) => {
          var error = 1
  
          if (status == 'success' && response) {
            try {
              data = JSON.parse(response)
              $("#notice").html(data['html'])
              if (data['error']) {
                $("#error").html(data['error'])
              }
              error = 0
            }
            catch (e) {
              // error
            }
          }
          if (error) {
            showNotice("Có lỗi xảy ra trên đường truyền")
          }
        }
      )
    }
  </script>
  <!-- END: main -->