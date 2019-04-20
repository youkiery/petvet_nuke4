<!-- BEGIN: main -->
<p>
  Từ ngày {from} đến ngày {to}
</p>
<table class="table">
  <thead>
    <tr>
      <th> STT </th>
      <th> Họ và tên</th>
      <th class="text-center"> Tổng số ngày nghỉ </th>
      <th class="text-center"> Quá ngày </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td>
        {index}
      </td>
      <td>
        {username}
      </td>
      <td class="text-center">
        {total}
      </td>
      <td class="text-center">
        {exceed}
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->