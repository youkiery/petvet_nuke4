<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Mã hàng </th>
    <th> Tên hàng </th>
    <th> Loại hàng </th>
    <!-- BEGIN: m1 -->
    <th> </th>
    <!-- END: m1 -->
  </tr>
  <!-- BEGIN: row -->
  <tbody class="table-box">
    <tr>
      <td rowspan="{row}"> {index} </td>
      <td> {code} </td>
      <td> {name} </td>
      <td> {category} </td>

      <!-- BEGIN: m2 -->
      <td rowspan="{row}" style="vertical-align: inherit;">
        <button class="btn btn-info btn-sm" onclick="itemEdit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-danger btn-sm" onclick="itemRemove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </td>
      <!-- END: m2 -->
    </tr>
    <!-- BEGIN: section -->
    <tr>
      <td colspan="3">
        <!-- BEGIN: p1 -->
        Giá <span style="color: red;"> {price} VND </span>
        <!-- END: p1 -->
        <!-- BEGIN: p2 -->
        Số lượng <span style="color: red;"> {number} </span>, Giá <span style="color: red;"> {price} VND </span>
        <!-- END: p2 -->
      </td>
    </tr>
    <!-- END: section -->
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->