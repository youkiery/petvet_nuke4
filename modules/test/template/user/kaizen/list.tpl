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
        <button class="edit btn btn-info btn-xs" rel="{id}" onclick="editAlert(event, {id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-danger btn-xs" onclick="removeAlert({id})">
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
      <td>
        kết quả
      </td>
      <td id="r{id}">
        {result}
      </td>
    </tr>
    <!-- BEGIN: manager2 -->
    <tr>
      <td class="cell-center" colspan="5">
        {user}
      </td>
    </tr>
    <!-- END: manager2 -->
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