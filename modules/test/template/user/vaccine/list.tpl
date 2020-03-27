<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead class="sticky-header">
    <tr>
      <th colspan="9" class="vng_vacbox_title" style="text-align: center">
        {title}
      </th>
    </tr>
    <tr>
      <th>
        {lang.customer}
      </th>
      <th>
        {lang.phone}
      </th>
      <th>
        {lang.disease}
      </th>
      <th>
        {lang.vaccall}
      </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tr style="text-transform: capitalize; border-top: 2px solid black" class="{brickcolor}">
    <td>
      {customer}
    </td>
    <td>
      {phone}
    </td>
    <td>
      {disease}
    </td>
    <td class="calltime">
      {calltime}
    </td>
  </tr>
  <tr>
    <td colspan="4" style="position: relative;">
      <button class="btn left btn-sm" style="position: absolute; left: 0;"
        onclick="confirm_lower({index}, {vacid}, {petid}, {diseaseid})">
        &lt;
      </button>
      <button class="btn right" style="position: absolute; right: 0;"
        onclick="confirm_upper({index}, {vacid}, {petid}, {diseaseid})">
        &gt;
      </button>
      <div style="clear: both;"></div>
      <p class="text-center" id="vac_confirm_{diseaseid}_{index}">
        Tình trạng:
        <span style="color: {color};">
          {confirm}
        </span>
      </p>
      <!-- BEGIN: recall_link -->
      <button class="btn btn-info" id="recall_{index}" data-toggle="modal" data-target="#vaccinedetail"
        onclick="recall({index}, {vacid}, {petid}, {diseaseid})">
        {lang.recall}
      </button>
      <!-- END: recall_link -->
    </td>
  </tr>
  <tr class="note" style="display: {cnote}" id="note_{diseaseid}_{vacid}">
    <td colspan="9" id="note_v{diseaseid}_{vacid}">
      {note}
      <button class="btn btn-info right" onclick="deadend({vacid})">
        {lang.deadend}
      </button>
      <button class="btn btn-info right" onclick="miscustom({vacid})">
        {lang.miscustom}
      </button>
      <img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú"
        onclick="editNote({vacid}, {diseaseid})">
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->