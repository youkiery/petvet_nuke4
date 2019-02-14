<!-- BEGIN: main -->
<tr>
  <td>
    {index}
  </td>
  <td>
    {username}
  </td>
  <td>
    {name}
  </td>
  <td>
    {roles}
  </td>
  <td>
    <button class="btn btn-info" onclick="get_employ({id})">
      {lang.g_edit}
    </button>
    <button class="btn btn-danger" data-toggle="modal" data-target="#remove" onclick="select({id})">
      {lang.g_remove}
    </button>
  </td>
</tr>
<!-- END: main -->
