<!-- BEGIN: main -->
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
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
<!-- END: main -->