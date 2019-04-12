<!-- BEGIN: main -->
Tổng cộng {count} bản ghi
<table class="table">
  <thead>
    <tr>
      <th> STT </th>
      <th> Ngày </th>
      <th> Lái xe </th>
      <th> Số km </th>
      <th> Địa điểm </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {date} </td>
      <td> {driver} </td>
      <td> 
        <div class="tooltip"> {km} km
          <span class="tooltiptext"> {start} km - {end} km </span>
        </div>  
      </td>
      <td> {destination} </td>
      <td> 
        <!-- <button class="btn btn-info" onclick="edit(0, {id})">
          Sửa
        </button>   -->
        <button class="btn btn-danger" onclick="remove(0, {id})">
          Xóa
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<div>
  Trang
  {nav}
</div>
<!-- END: main -->