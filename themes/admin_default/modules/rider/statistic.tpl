<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<style>
  label {
    width: 100%;
  }
</style>
  

<div class="row">
  <label> 
    <div class="col-sm-6">
      Ngày bắt đầu
    </div>  
    <div class="col-sm-6">
      <input type="text" class="form-control" id="from" value="{from}">
    </div>
  </label>
  <label> 
    <div class="col-sm-6">
      Ngày kết thúc
    </div>  
    <div class="col-sm-6">
      <input type="text" class="form-control" id="end" value="{end}">
    </div>
  </label>
</div>
<div class="text-center">
  <button class="btn btn-info" onclick="filter()">
    Xem thống kế
  </button>
</div>

<div id="content">
  {content}
</div>

<script>
  var content = $("#content")

  $("#from, #end").datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  function checkFilter() {
    return {
      from: $("#from").val(),
      end: $("#end").val()
    }
  }

  function filter() {
    $.post(
      strHref,
      {action: "filter", filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data['html'])
        }, () => { })
      }
    )
  }
</script>
<!-- END: main -->