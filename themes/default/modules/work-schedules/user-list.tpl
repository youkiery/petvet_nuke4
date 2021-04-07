<!-- BEGIN: main -->
<!-- BEGIN: loop -->
  <tbody class="item-border">
  <tr>
    <td>Tên công việc</td>
    <td> {work_name}</td>
  </tr>
  <tr>
    <td> Nhân viên</td>
    <td> {username}</td>
  </tr>
  <tr>
    <td> Tiến độ</td>
    <td>{work_process}%</td>
  </tr>
  <tr>
    <td> Hạn chót</td>
    <td> {work_endtime}</td>
  </tr>
  <tr>
    <td colspan="2" class="cell-center">
      <button class="btn btn-info" onclick="change_process({id})">
        {lang.change_process}
      </button>
      <!-- BEGIN: admin -->
      <button class="btn btn-info" onclick="edit({id})">
        {lang.update}
      </button>
      <!-- END: admin -->
      <!-- BEGIN: manager -->
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
</tbody>  
<!-- END: loop -->
<!-- END: main -->
