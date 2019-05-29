<!-- BEGIN: main -->
  Tổng cộng {count} bản ghi
  <table class="table table-bordered">
    <!-- BEGIN: row -->
    <tbody class="item-border">
      <tr>
        <td id="rider-detail-date-{id}" rowspan="3" class="cell-center"> {date} </td>
        <td id="rider-detail-driver-{id}"> {driver} </td>
        <td class="cell-center" rowspan="3"> <button class="btn btn-danger" onclick="removeRecord({id}, 1)"> <span class="glyphicon glyphicon-remove"></span> </button> </td>
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