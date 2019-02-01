<!-- BEGIN: main -->
<tr>
  <td>
    {index}
  </td>
  <td>
    {work_name}
  </td>
  <td>
    {work_starttime}
  </td>
  <td>
    {work_endtime}
  </td>
  <td>
    {work_customer}
  </td>
  <td>
    {work_depart}
  </td>
  <td>
    {work_employ}
  </td>
  <td>
    {work_process} %
  </td>
  <td>
    <button class="btn btn-info" onclick="edit({id})">
      {lang.g_edit}
    </button>
    <button class="btn btn-danger" onclick="remove({id})">
      {lang.g_remove}
    </button>
  </td>
</tr>
<!-- END: main -->
