<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> Hình ảnh </th>
    <th> Chủ nuôi </th>
    <th> Tên thú cưng </th>
    <th> Số điện thoại </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> <img src="{image}" class="img-responsive" style="max-width: 50px; max-height: 50px;"> </td>
    <td> {fullname} </td>
    <td> {name} </td>
    <td> {mobile} </td>
    <td>
      <button class="btn btn-info btn-xs" onclick="preview({id})">
        chi tiết
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->