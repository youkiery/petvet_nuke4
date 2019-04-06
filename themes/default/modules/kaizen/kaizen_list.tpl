<!-- BEGIN: main -->
  <!-- BEGIN: inbox -->
  <table class="table">
    <thead>
      <tr>
        <th>
          STT
        </th>
        <th>
          Vấn đề
        </th>
        <th>
          Giải quyết
        </th>
        <th>
          Hiệu quả
        </th>
        <th>
          Thời gian
        </th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <!-- BEGIN: row -->
      <tr>
        <td>
          {index}
        </td>
        <td>
          {problem}
        </td>
        <td>
          {solution}
        </td>
        <td>
          {result}
        </td>
        <td>
          {time}
        </td>
        <td>
          <button class="edit btn btn-info" rel="{id}" onclick="editAlert(event, {id})">
            <span class="glyphicon glyphicon-edit"></span>
          </button>
          <button class="btn btn-danger" onclick="removeAlert({id})">
            <span class="glyphicon glyphicon-remove"></span>
          </button>
        </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
  <!-- END: inbox -->
  <!-- BEGIN: empty -->
  <div>
    Bạn chưa gửi giải pháp nào cả
  </div>
  <!-- END: empty -->
<!-- END: main -->