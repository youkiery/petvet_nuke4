<!-- BEGIN: main -->
<div id="remove-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa tầng, các nhân viên cũng sẽ bị xóa </h4>
      </div>

      <div class="modal-body">
        <a class="btn btn-danger btn-block" id="remove-button">
          Xác nhận
        </a>
      </div>
    </div>
  </div>
</div>

<a href="/general/product"> &lt; Danh sách hàng hóa </a>
<form action="/general/product-floor/" method="get" class="form-group" style="width: 50%;">
  <div class="input-group">
    <input type="hidden" name="action" value="insert">
    <input type="text" class="form-control" name="name" placeholder="Nhập tên tầng">
    <div class="input-group-btn">
      <button class="btn btn-success">
        thêm tầng
      </button>
    </div>
  </div>
</form>

<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Tên tầng </th>
    <th> Số nhân viên </th>
    <th> Số mặt hàng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {name} </td> 
    <td> {user} </td>
    <td> {item} </td>
    <td>  
      <a class="btn btn-info btn-xs" href="/general/product-user/?id={id}">
        danh sách nhân viên
      </a>
      <a class="btn btn-danger btn-xs" onclick="remove({id})">
        xóa tầng
      </a>
    </td>
  </tr>
  <!-- END: row -->
</table>

<script>
  function remove(id) {
    $('#remove-button').attr('href', '/general/product-floor/?action=remove&id='+ id)
    $('#remove-modal').modal('show')
  }
</script>
<!-- END: main -->
