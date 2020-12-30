<!-- BEGIN: main -->
<div class="form-group">
  <button class="btn btn-success" onclick="promoUpModal()">
    <span class="glyphicon glyphicon-plus"></span> Bổ nhiệm
  </button>
</div>

<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th class="cell-center"> STT </th>
      <th class="cell-center"> Họ và tên </th>
      <th class="cell-center"> Ngày bổ nhiệm </th>
      <th class="cell-center"> Ngày bổ nhiệm lại </th>
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
      <td> {last_promo} </td>
      <td> {next_promo} </td>
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
        <button class="btn btn-info btn-xs" onclick="promoUpModal({employid})">
          bổ nhiệm
        </button>  
        <button class="btn btn-danger btn-xs" onclick="employRemoveModal({employid})">
          xóa
        </button>   -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->