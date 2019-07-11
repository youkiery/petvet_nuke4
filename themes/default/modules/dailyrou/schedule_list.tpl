<!-- BEGIN: main -->
  <table class="table text-center">
    <thead>
      <tr>
        <th class="text-center"> Ngày </th>
        <th class="text-center"> Thứ </th>
        <th class="text-center"> Trực sáng </th>
        <th class="text-center"> Trực tối </th>
        <th class="text-center"> Nghỉ sáng </th>
        <th class="text-center"> Nghỉ chiều </th>
      </tr>
    </thead>
    <tbody>
      <!-- BEGIN: row -->
      <tr id="{day}" time="{time}">
        <td> {date} </td>
        <td> {daytime} </td>
        <td class="dailyrou" id="{day}_0">
          {morning_guard}
        </td>
        <td class="dailyrou" id="{day}_1">
          {afternoon_guard}
        </td>
        <td class="dailyrou" id="{day}_2">
          {morning_rest}
        </td>
        <td class="dailyrou" id="{day}_3">
          {afternoon_rest}
        </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
<!-- END: main -->