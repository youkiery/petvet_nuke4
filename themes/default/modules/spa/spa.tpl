<!-- BEGIN: main -->
<div id="detail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_detail}</h4>
      </div>
      <div class="modal-body" id="detail_content">

      </div>
      <div class="modal-footer">
        <button class="btn btn-info">
          {lang.save}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<table>
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.doctor}
      </th>
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.customer_number}
      </th>
      <th>
        {lang.status}
      </th>
      <th>
        {lang.action}
      </th>
    </tr>
  </thead>
  <tbody>
    {content}
  </tbody>
</table>
<!-- END: main -->
