<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th class="cell-center"> STT </th>
      <th class="cell-center"> Họ và tên </th>
      <th class="cell-center"> Thời gian nâng lương lần cuối </th>
      <th class="cell-center"> Thời gian nâng lương kế tiếp </th>
      <th class="cell-center"> Hình thức khen thưởng </th>
      <th class="cell-center"> Ghi chú </th>
      <!-- <th class="cell-center"> File đính kèm </th> -->
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr rel="{id}">
      <td> {index} </td>
      <td> {name} </td>
      <td> {last_salary} </td>
      <td> {next_salary} </td>
      <td> {formal} </td>
      <td> {ghichu} </td>
      <!-- <td> {file} </td> -->
      <td> 
        <button class="btn btn-info btn-xs" onclick="salaryUpModal({employid})">
          nâng lương
        </button>  
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->