<!-- BEGIN: main -->
<a href="/general/product-floor"> &lt; Danh sách tầng </a>

<form class="input-group" action="/general/product-user">
  <input type="hidden" name="id" value="{id}">
  <input type="text" class="form-control" name="keyword" value="{keyword}">
  <div class="input-group-btn">
    <button class="btn btn-success">
      tìm kiếm
    </button>
  </div>
</form>

<!-- BEGIN: search -->
<div class="form-group"></div>
<b> Danh sách tìm kiếm: {keyword} </b>
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Tên tài khoản </th>
    <th> Họ và tên </th>
    <th>  </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {username} </td>
    <td> {fullname} </td>
    <td> 
      <a class="btn btn-success btn-xs" href="/general/product-user/?id={id}&action=insert&uid={uid}">
        thêm nhân viên
      </a>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: search -->

<div class="form-group"></div>

<b> Danh sách nhân viên </b>
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Tên tài khoản </th>
    <th> Họ và tên </th>
    <th>  </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {username} </td>
    <td> {fullname} </td>
    <td> 
      <a class="btn {manager} btn-xs" href="/general/product-user/?id={id}&action=manager&value={value}&uid={uid}">
        quản lý
      </a>
      <a class="btn btn-danger btn-xs" href="/general/product-user/?id={id}&action=remove&id={uid}">
        xóa nhân viên
      </a>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
