<!-- BEGIN: main -->
<tr>
  <th>
    {index}
  </th>
  <th>
    {name}
  </th>
  <th>
    {roles}
  </th>
  <th>
    <button class="btn btn-info" onclick="get_employ({id})">
      {lang.g_edit}
    </button>
    <button class="btn btn-info" data-toggle="modal" data-target="#remove" onclick="select({id})">
      {lang.g_remove}
    </button>
  </th>
</tr>
<!-- END: main -->
