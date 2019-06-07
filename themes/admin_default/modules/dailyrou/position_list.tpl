<!-- BEGIN: main -->
  <table class="table table-bordered">
    <tr>
      <th>
        Số thứ tự
      </th>
      <th>
        Tên tầng
      </th>
      <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td>
        {index}
      </td>
      <td>
        {name}
      </td>
      <td>
        <button class="btn btn-danger" onclick="removePositionModal({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </table>
<!-- END: main -->
