<!-- BEGIN: main -->
<thead>
  <tr>
    <th>
      {lang.work_name}
    </th>
    <th>
      {lang.user}
    </th>
    <th>
      {lang.work_depart}
    </th>
    <th>
      {lang.work_endtime}
    </th>
    <th>
      {lang.work_process}
    </th>
    <th>
    </th>
  </tr>
</thead>
<tbody>
  <!-- BEGIN: loop -->
  <tr class="{overtime}">
    <td data-toggle="modal" data-target="#detail">
      {work_name}
    </td>
    <td>
      {work_employ}
    </td>
    <td>
      {work_depart}
    </td>
    <td data-toggle="modal" data-target="#detail">
      {work_endtime}
    </td>
    <!-- <td data-toggle="modal" data-target="#detail">
      {work_customer}
    </td> -->
    <td data-toggle="modal" data-target="#detail" id="process_{id}">
      {work_process}%
    </td>
    <td>
      <!-- BEGIN: manager -->
      <button class="btn btn-info" onclick="edit({id})">
        {lang.update}
      </button>
      <!-- END: manager -->
      <button class="btn btn-info" onclick="change_confirm({id})" {disable}>
        {lang.change_confirm}
      </button>
      {confirm}
      <span style="color: {color}">
        {review}
      </span>
    </td>
  </tr>
</tbody>
<!-- END: loop -->
