<!-- BEGIN: main -->
<tr>
  <td>{index}</td>
  <td>{name}</td>
  <td>{role}</td>
  <td>
    <!-- <button class="btn btn-info" data-toggle="modal" data-target="#edit">
      {lang.g_edit}
    </button> -->
    <button class="btn btn-info" data-toggle="modal" data-target="#remove" onclick="select({id})">
      {lang.g_remove}
    </button>
  </td>
</tr>
<!-- END: main -->
