<!-- BEGIN: main -->
<div class="row-x">
  <div class="col-1 text-center"> STT </div>
  <div class="col-5 text-center"> Giá trị </div>
  <div class="col-6 text-center"> Chức năng </div>
</div>
<!-- BEGIN: row -->
<div class="row-x">
  <div class="col-1 text-center"> {index} </div>
  <div class="col-5"> 
    <input type="text" class="form-control" id="tag-name-{id}" value="{name}">  
  </div>
  <div class="col-6">
    <button class="btn btn-info btn-xs" onclick="editSubmit({id})">
      sửa
    </button>
    <button class="btn btn-danger btn-xs" onclick="remove({id})">
      xóa
    </button>
  </div>
</div>
<!-- END: row -->
<!-- END: main -->