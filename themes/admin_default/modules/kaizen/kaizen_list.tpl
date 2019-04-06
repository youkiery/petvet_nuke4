<!-- BEGIN: main -->
  <!-- BEGIN: inbox -->
  <table class="table table-bordered">
    <tbody>
      <!-- BEGIN: row -->
      <tr>
        <td class="cell-center" rowspan="1">
          {time}
        </td>
        <td>
          Vấn đề
        </td>
        <td>
          {problem}
        </td>
        <td class="cell-center" rowspan="3">
          <button class="edit btn btn-info" rel="{id}" onclick="editAlert(event, {id})">
            <span class="glyphicon glyphicon-edit"></span>
          </button>
          <button class="btn btn-danger" onclick="removeAlert({id})">
            <span class="glyphicon glyphicon-remove"></span>
          </button>
        </td>
      </tr>
      <tr>
        <td class="cell-center" rowspan="2">
          {user}
        </td>
        <td>
          Giải quyết
        </td>
        <td>
          {solution}
        </td>
      </tr>
      <tr>
        <td>
          kết quả
        </td>
        <td>
          {result}
        </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
  <!-- END: inbox -->
  <!-- BEGIN: empty -->
  <div>
    Chưa có giải pháp nào được gửi tới
  </div>
  <!-- END: empty -->
<!-- END: main -->