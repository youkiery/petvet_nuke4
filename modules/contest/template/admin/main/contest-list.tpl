<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> <input type="checkbox" id="contest-check-all"> </th>
    <th> Người tham gia </th>
    <th> Địa chỉ </th>
    <th> Số điện thoại </th>
    <th> Mục tham gia </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td>
      <input type="checkbox" class="contest-checkbox" index="{id}" id="contest-check-{id}">
    </td>
    <td> 
      {name}
      <!-- <input type="contest" class="form-control contest-name" id="contest-name-{id}" value="{name}"> -->
    </td>
    <td> 
      {address}
      <!-- <input type="contest" class="form-control contest-name" id="contest-name-{id}" value="{name}"> -->
    </td>
    <td> 
      {mobile}
      <!-- <input type="contest" class="form-control contest-name" id="contest-name-{id}" value="{name}"> -->
    </td>
    <td> 
      {contest}
      <!-- <input type="contest" class="form-control contest-name" id="contest-name-{id}" value="{name}"> -->
    </td>
    <td>
      <button class="btn btn-danger" onclick="removeRow({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
