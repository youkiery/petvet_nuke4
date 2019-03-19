<!-- BEGIN: main -->
<table class="table">
  <thead>
    <tr>
      <th colspan="9" class="text-center"> {lang.vaccine_remind} </th>
    </tr>
    <tr>
      <th> {lang.index} </th>  
      <th> {lang.petname} </th>  
      <th> {lang.customer} </th>  
      <th> {lang.phone} </th>  
      <th> {lang.calltime} </th>  
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->  
    <tr>
      <td> {index} </td>    
      <td> {petname} </td>    
      <td> {customer} </td>    
      <td> {phone} </td>    
      <td> {calltime} </td>    
      <td class="confirm">
        <span id="vac_confirm_{diseaseid}_{index}" style="color: {color};">
          {confirm}
        </span>
        <!-- BEGIN: recall -->
          <button class="btn btn-info" id="recall_{index}" data-toggle="modal" data-target="#vaccinedetail" onclick="recall({index}, {vacid}, {petid}, {diseaseid})">
            {lang.recall}
          </button>
        <!-- END: recall -->
        </td>
      </tr>
    	<!-- END: row -->
  </tbody>
</table>
<!-- END: main -->
