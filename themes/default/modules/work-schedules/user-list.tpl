<!-- BEGIN: main -->
<!-- BEGIN: loop -->
  <tbody class="item-border">
  <tr>
    <td rowspan="2" class="cell-center">
      {work_endtime}
    </td>
    <td>
      Tên công việc
    </td>
    <td>
      {work_name}
    </td>
    <td rowspan="3" class="cell-center">
      <button class="btn btn-info" onclick="change_process({id})">
        {lang.change_process}
      </button>
      <!-- BEGIN: manager -->
      <button class="btn btn-info" onclick="edit({id})">
        {lang.update}
      </button>
      <button class="btn btn-info" onclick="change_confirm({id})" {disable}>
        {lang.change_confirm}
      </button>
      <br>
      {confirm}
      <span style="color: {color}">
        {review}
      </span>
      <!-- END: manager -->
    </td>
  </tr>
  <tr>
    <td>
      Phòng ban
    </td>
    <td>
      {work_depart}
    </td>    
  </tr>
  <tr>
    <td class="cell-center">
      {username}
    </td>
    <td> Tiến độ </td>
    <td>
      {work_process}%
    </td>
  </tr>
</tbody>  
<!-- END: loop -->
<!-- END: main -->
