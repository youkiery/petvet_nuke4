<!-- BEGIN: main -->
<div class="form-group">
  <button class="btn btn-success" onclick="salaryUpModal()">
    <span class="glyphicon glyphicon-plus"></span> Nâng lương
  </button>
</div>

<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th class="cell-center"> STT </th>
      <th class="cell-center"> Họ và tên </th>
      <th class="cell-center"> Thời gian nâng lương lần cuối </th>
      <th class="cell-center"> Thời gian nâng lương kế tiếp </th>
      <th class="cell-center"> Hình thức khen thưởng </th>
      <th class="cell-center"> Ghi chú </th>
      <th class="cell-center"> File đính kèm </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr rel="{id}" class="{color}">
      <td> {index} </td>
      <td> {employ} </td>
      <td> {last_salary} </td>
      <td> {next_salary} </td>
      <td> {formal} </td>
      <td> {note} </td>
      <td> 
        <!-- BEGIN: file -->
        <a href="{file}" target="_blank"> 
          <span class="glyphicon glyphicon-download-alt"></span>  
        </a>
        <!-- END: file -->
      </td>
      <td> 
        <!-- <button class="btn btn-info btn-xs" onclick="historyModal({employid})">
          xem
        </button>  
        <button class="btn btn-info btn-xs" onclick="salaryUpModal({employid})">
          nâng lương
        </button>  
        <button class="btn btn-danger btn-xs" onclick="employRemoveModal({employid})">
          xóa
        </button>  
      </td> -->
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->