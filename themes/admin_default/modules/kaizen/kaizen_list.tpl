<!-- BEGIN: main -->
  Tổng cộng {count} giải pháp
  <!-- BEGIN: inbox -->
  <table class="table table-bordered">
    <!-- BEGIN: row -->
    <tbody class="item-border">
      <tr>
        <td class="cell-center" rowspan="3">
          {index}
        </td>
        <td class="cell-center" rowspan="1">
          {time}
        </td>
        <td>
          Vấn đề
        </td>
        <td id="p{id}">
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
        <td id="s{id}">
          {solution}
        </td>
      </tr>
      <tr>
        <td>
          kết quả
        </td>
        <td id="r{id}">
          {result}
        </td>
      </tr>
    </tbody>
    <!-- END: row -->
  </table>
  <!-- END: inbox -->
  <!-- BEGIN: empty -->
  <div>
    Chưa có giải pháp nào được gửi tới
  </div>
  <!-- END: empty -->
  <div id="nav">
    {nav}
  </div>
<!-- END: main -->