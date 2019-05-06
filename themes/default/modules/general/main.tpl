<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<script lang="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.4/xlsx.core.min.js"></script>
<div class="msgshow" id="msgshow"></div>

<!-- <style>
  .relative {
    display: inline-block;
  }
  .upload-button {
    position: absolute;
  }
  .relative, .upload-input {
    width: 32px;
    height: 32px;
  }
</style> -->

<!-- <div class="relative"> -->
  <div class="btn btn-success">
      <input type="file" class="form-control" id="bv" />
      <span class="glyphicon glyphicon-upload"></span>
  </div>
<!-- </div>
&ThinSpace;
<div class="relative"> -->
  <div class="btn btn-info">
    <input type="file" class="form-control" id="kho" />
    <span class="glyphicon glyphicon-upload"></span>
  </div>
<!-- </div> -->

<script>
  var xdata = {}
  $(function() {
    $("#bv").change((e) => {
      filePicked(e, bv, 'bv')
    })
    $("#kho").change((e) => {
      filePicked(e, kho, 'kho')
    })
  });

  function filePicked(oEvent, tail, nid) {
    var oFile = oEvent.target.files[0];
    var sFilename = oFile.name;
    var reader = new FileReader();

    reader.onload = function(e) {
        var data = e.target.result;
        var cfb = XLS.CFB.read(data, {type: 'binary'});
        var wb = XLS.parse_xlscfb(cfb);
        wb.SheetNames.forEach(function(sheetName) {
          var sCSV = XLS.utils.make_csv(wb.Sheets[sheetName]);   
          var oJS = XLS.utils.sheet_to_row_object_array(wb.Sheets[sheetName]);   
          xdata[nid] = oJS
        }
      );
    };

    reader.readAsBinaryString(oFile);
  }
</script>
<!-- END: main -->