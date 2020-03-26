<!-- BEGIN: main -->
<tr>
  <td>
    {index}
  </td>
  <!-- <td>
    {spa_doctor}
  </td> -->
  <td>
    {customer_name}
  </td>
  <td>
    {customer_number}
  </td>
  <!-- <td>
    {spa_from}
  </td> -->
  <td>
    {spa_end}
  </td>
  <td>
    <button class="btn btn-info" onclick="view_detail({id})">
      {lang.spa_edit}
    </button>
    <button class="btn btn-info" onclick="remove_confirm({id})">
      {lang.remove}
    </button>
  </td>
</tr>
<!-- END: main -->
