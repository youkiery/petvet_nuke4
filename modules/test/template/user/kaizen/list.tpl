<!-- BEGIN: main -->
<p>
  Bạn đã gửi {count} giải pháp
</p>
<!-- BEGIN: inbox -->
<table class="table table-bordered">
  <!-- BEGIN: row -->
  <tbody class="item-border">
    <tr>
      <td class="cell-center" rowspan="3">
        {index}
      </td>
      <td class="cell-center" rowspan="{time_cell}">
        {time}
      </td>
      <td>
        Vấn đề
      </td>
      <td id="p{id}">
        {problem}
      </td>
      <!-- BEGIN: manager -->
      <td class="cell-center" rowspan="3">
        <button class="edit btn btn-info btn-sm" rel="{id}" onclick="editAlert(event, {id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-danger btn-sm" onclick="removeAlert({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </td>
      <!-- END: manager -->
    </tr>
    <tr>
      <td>
        Giải quyết
      </td>
      <td id="s{id}">
        {solution}
      </td>
    </tr>
    <tr>
      <!-- BEGIN: manager2 -->
      <td class="cell-center">
        {user}
      </td>
      <!-- END: manager2 -->
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
  Bạn chưa gửi giải pháp nào cả
</div>
<!-- END: empty -->
<div id="nav">
  {nav}
</div>
<!-- END: main -->