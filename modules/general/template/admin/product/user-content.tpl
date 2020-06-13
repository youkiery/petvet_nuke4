<!-- BEGIN: main -->
<div class="row-x">
  <div class="col-1 text-center"> STT </div>
  <div class="col-3 text-center"> Tài khoản </div>
  <div class="col-3 text-center"> Tên người dùng </div>
  <div class="col-5 text-center"> Chức năng </div>
</div>
<!-- BEGIN: row -->
<div class="row-x">
  <div class="col-1 text-center"> {index} </div>
  <div class="col-3"> {username} </div>
  <div class="col-3"> {fullname} </div>
  <div class="col-5">
    <button class="btn {btn_type} btn-xs" onclick="changePermit({id}, {type})">
      {name}
    </button>
    <button class="btn btn-info btn-xs" onclick="getTagPermit({id})">
      danh mục
    </button>
    <button class="btn btn-danger btn-xs" onclick="remove({id})">
      xóa
    </button>
  </div>
</div>
<!-- END: row -->
<!-- END: main -->