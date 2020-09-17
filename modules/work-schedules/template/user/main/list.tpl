<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Thời gian </th>
      <th style="width: 50%"> Nội dung công việc </th>
      <th style="width: 25%"> Nhân viên </th>
      <th style="width: 10%"> Tiến độ </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody style="font-size: 0.9em;">
    <!-- BEGIN: row -->
    <tr class="{color}">
      <td>
        <div> {start} </div>
        <div> đến </div>
        <div> {end} </div>
      </td>
      <td>
        <div> {content} </div>
        <div> {note} </div>
      </td>
      <td> {user} </td>
      <td> {process}% </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="updateProcess({id}, {process}, '{note}', '{calltime}')">
          tiến độ
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->