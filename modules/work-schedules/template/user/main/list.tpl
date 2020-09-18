<!-- BEGIN: main -->
<table class="table table-bordered">
  <!-- BEGIN: row -->
  <tbody class="black-bottom {color}">
    <tr>
      <td colspan="4"> {content} </td>
    </tr>
    <!-- BEGIN: note -->
    <tr>
      <td colspan="4"> {note} </td>
    </tr>
    <!-- END: note -->
    <tr>
      <td> {end} </td>
      <td> {user} </td>
      <td> {process}% </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="updateProcess({id}, {process}, '{note}', '{calltime}')">
          <!-- <span class="glyphicon glyphicon-percent"> </span> -->
          %
        </button> 
        <button class="btn btn-info btn-xs" onclick="finishWork({id})">
          <span class="glyphicon glyphicon-ok"> </span>
        </button>  
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->