<!-- BEGIN: main -->
  Tổng cộng {count} bản ghi
  <table class="table bordered-table">
    <!-- BEGIN: row -->
    <tbody class="item-border">
      <tr>
        <td id="rider-detail-date-{id}" rowspan="3" class="cell-center"> {date} </td>
        <td id="rider-detail-driver-{id}"> {driver} </td>
      </tr>
      <tr>
        <td> 
          {start} - {end} ({km}) km
        </td>
      </tr>
      <tr>
        <td id="rider-detail-destination-{id}"> {destination} </td>
      </tr>
    </tbody>
    <!-- END: row -->
  </table>
  <div>
    Trang
    {nav}
  </div>
<!-- END: main -->