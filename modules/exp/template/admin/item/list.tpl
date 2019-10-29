<!-- BEGIN: main -->
<div class="row-x">
  <div class="col-3">
    Số thứ tự
  </div>
  <div class="col-6">
    Tên hàng
  </div>
  <div class="col-3">

  </div>
</div>
<!-- BEGIN: row -->
<div class="row-x">
  <div class="col-3">
    {index}
  </div>
  <div class="col-6">
    <input type="text" class="form-control" id="item-{id}" value="{name}">
  </div>
  <div class="col-3">
    <button class="btn btn-info" onclick="update({id})">
      <span class="glyphicon glyphicon-refresh"></span>
    </button>
    <button class="btn btn-danger" onclick="remove({id})">
      <span class="glyphicon glyphicon-remove"></span>
    </button>
  </div>
</div>
<!-- END: row -->
{nav}
<!-- END: main -->
