<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Người đăng ký </th>
    <th> Số điện thoại </th>
    <th> Môn đăng ký </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {name} </td>
    <td> {mobile} </td>
    <td> {court} </td>
    <td>
      <button class="btn {active_btn}" rel="{id}" onclick="activeSubmit({id}, {active})">
        <span class="glyphicon glyphicon-lock"></span>
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
