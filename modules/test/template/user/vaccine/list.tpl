<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead class="sticky-header">
    <tr>
      <th>
        Thú cưng
      </th>
      <th>
        SĐT
      </th>
      <th>
        Tiêm phòng
      </th>
      <th>
        Ngày tiêm
      </th>
      <th>
        Ngày tái chủng
      </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tr style="text-transform: capitalize; border-top: 2px solid black" class="{brickcolor}">
    <td>
      {petname} ({customer})
    </td>
    <td>
      {phone}
    </td>
    <td>
      {disease}
    </td>
    <td> {cometime} </td>
    <td> {calltime} </td>
  </tr>
  <tr class="{brickcolor}">
    <td colspan="3">
      <!-- BEGIN: note -->
      {note}
      <!-- END: note -->
      <!-- BEGIN: note2 -->
      <span id="note_{vacid}">
        {note}
      </span>
      <img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú"
        onclick="editNote({vacid})">
      <!-- END: note2 -->
    </td>
    <td colspan="2" style="position: relative;">
      <!-- BEGIN: left -->
      <button class="btn btn-default btn-xs vaccine-left"
        onclick="changeStatus({vacid}, 0)">
        &lt;
      </button>
      <!-- END: left -->
      <!-- BEGIN: right -->
      <button class="btn btn-default btn-xs vaccine-right"
        onclick="changeStatus({vacid}, 1)">
        &gt;
      </button>
      <!-- END: right -->
      <div style="clear: both;"></div>
      <p class="text-center">
        <span class="text-{color}">
          {confirm}
        </span>
      </p>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->