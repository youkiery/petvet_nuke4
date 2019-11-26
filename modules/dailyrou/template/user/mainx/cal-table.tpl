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
      <tr>
        <td day="{datetime}"> {date} </td>
        <td> {day} </td>
        <td class="dailyrou" datetime="{datetime}" court="0"> {p0} </td>
        <td class="dailyrou" datetime="{datetime}" court="1"> {p1} </td>
        <td class="dailyrou" datetime="{datetime}" court="2"> {p2} </td>
        <td class="dailyrou" datetime="{datetime}" court="3"> {p3} </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
<!-- END: main -->