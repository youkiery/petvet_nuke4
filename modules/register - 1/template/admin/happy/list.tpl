<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> Hình ảnh </th>
    <th> Chủ nuôi </th>
    <th> Số điện thoại </th>
    <th> Giống loài </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> <img src="{image}" class="img-responsive" style="max-width: 40px; max-height: 40px; margin: auto;"> </td>
    <td> {fullname} </td>
    <td> {mobile} </td>
    <td> {species} </td>
    <td>
      <button class="btn btn-info btn-xs" onclick="edit({id})">
        sửa
      </button>
      <button class="btn btn-danger btn-xs" onclick="remove({id})">
        xóa
      </button>
      <button class="btn {done_btn} btn-xs" onclick="done({id}, {type})">
        {done}
      </button>
      <button class="btn btn-info btn-xs" onclick="preview({id})">
        chi tiết
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->