<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.customer_number}
      </th>
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.spa_end}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody style="border-bottom: 2px solid darkgray !important" class="{color}">
    <tr>
      <td rowspan="2" class="cell-center">
        {index}
      </td>
      <td style="color: blue;">
        {customer_number}
      </td>
      <td>
        {customer_name}
      </td>
      <td>
        {spa_end}
      </td>
      <td>
        <button class="btn btn-info btn-xs" onclick="view_detail({id})">
          {lang.spa_edit}
        </button>
        <button class="btn btn-warning btn-xs" {check_avai} onclick="detail({id})" id="btn-detail2">
          <span class="glyphicon glyphicon-check"></span>
        </button>
        <button class="btn btn-warning btn-xs" {pay_avai} onclick="payment({id})" id="btn-detail3">
          <span class="glyphicon glyphicon-usd"></span>
        </button>
        <img src="{image}" width="32px;" onclick="preview('{image}')">
      </td>
    </tr>
    <tr>
      <td colspan="4" style="font-size: 0.9em; color: red;"> <b> {note} </b> </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->