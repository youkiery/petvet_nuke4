<!-- BEGIN: main -->
<div>
  {select_doctor}
</div>
<div> Lịch trực từ ngày {from} đến ngày {to} của {doctor} </div>
<button class="btn btn-success" onclick="insertWconfirm()">
  <span class="glyphicon glyphicon-plus">
  </span>
</button>
<!-- BEGIN: row -->
<div class="item">
  {date}: {type}
  <button class="btn btn-danger right" onclick="removeWconfirm({date2}, {type2})">
    <span class="glyphicon glyphicon-remove">

    </span>
  </button>
</div>
<!-- END: row -->
<!-- END: main -->