<!-- BEGIN: main -->
  <table class="table text-center">
    <thead>
      <tr>
        <th class="text-center"> Ngày </th>
        <th class="text-center"> Trực sáng </th>
        <th class="text-center"> Trực tối </th>
        <th class="text-center"> Nghỉ sáng </th>
        <th class="text-center"> Nghỉ chiều </th>
      </tr>
    </thead>
    <tbody>
      <!-- BEGIN: row -->
      <tr>
        <td> {date} </td>
        <td class="dailyrou"> {morning_guard} </td>
        <td class="dailyrou"> {afternoon_guard} </td>
        <td class="dailyrou">
          {morning_rest}
        </td>
        <td class="dailyrou">
          {afternoon_rest}
        </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
<!-- END: main -->