<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> <input type="checkbox" id="test-check-all"> </th>
    <th> Phần thi </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td>
      <input type="checkbox" class="test-checkbox" id="test-check-{id}">
    </td>
    <td> 
      <input type="test" class="form-control test-name" id="test-name-{id}" value="{name}">
    </td>
    <td>
      <button class="btn btn-info" onclick="updateTestSubmit({id})">
        <span class="glyphicon glyphicon-refresh"></span>
      </button>
      <button class="btn btn-info" onclick="hideTestSubmit({id})">
        <span class="glyphicon glyphicon-eye-close"></span>
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
