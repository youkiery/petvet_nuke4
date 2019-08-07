<!-- BEGIN: main -->
<div>
  <!-- BEGIN: row -->
  <div style="float: left;">
    {title}
  </div>
  <div style="float: right; width: 150px;">
    <!-- BEGIN: request -->
    <button class="btn btn-info" onclick="requestSubmit({id}, {type})">
      yêu cầu
    </button>
    <!-- END: request -->
    <!-- BEGIN: rerequest -->
    <button class="btn btn-warning" onclick="requestSubmit({id}, {type})">
      yêu cầu lại
    </button>
    <!-- END: rerequest -->
    <!-- BEGIN: cancel -->
    <button class="btn btn-danger" onclick="cancelSubmit({id}, {type})">
      hủy
    </button>
    <!-- END: cancel -->
  </div>
  <div style="clear: both;"></div>
  <!-- END: row -->
</div>
<!-- END: main -->
