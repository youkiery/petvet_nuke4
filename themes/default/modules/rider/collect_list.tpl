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
      </tr>
    </thead>
    <tbody>
      <!-- BEGIN: row -->
      <tr onclick="goDetail({id})">
        <td> {index} </td>
        <td id="rider-detail-date-{id}"> {date} </td>
        <td id="rider-detail-driver-{id}"> {driver} </td>
        <td> 
          <div class="tooltip"> {km} km
            <span class="tooltiptext"> <span id="rider-detail-from-{id}">{start}</span> km - <span id="rider-detail-end-{id}">{end}</span> km </span>
          </div>  
        </td>
        <td id="rider-detail-destination-{id}"> {destination} </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
  <div>
    Trang
    {nav}
  </div>
<!-- END: main -->