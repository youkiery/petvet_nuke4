<!-- BEGIN: main -->
<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.customer_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit()">
          <div class="form-group">
            <label> {lang.customer_name} </label>
            <input class="form-control" type="text" id="name2">
          </div>
          <button class="btn btn-info" data-dismiss="modal">
            {lang.customer_submit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="remove" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.customer_remove}</h4>
      </div>
      <div class="modal-body">
        <button class="btn btn-info" onclick="remove()" data-dismiss="modal">
          {lang.g_remove}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>


<table class="table">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.customer_name}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<form onsubmit="return save()">
  <div class="form-group">
    <label> {lang.customer_name} </label>
    <input class="form-control" type="text" id="name">
  </div>
  <button class="btn btn-info">
    {lang.customer_submit}
  </button>
</form>
<!-- END: main -->
