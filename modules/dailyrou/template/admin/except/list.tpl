<!-- BEGIN: main -->
  <div class="item">
    {username}
    <!-- BEGIN: user -->
    <button class="btn btn-success right" onclick="change(0, {id})">
      <span class="glyphicon glyphicon-ok"> </span>
    </button>
    <!-- END: user -->
    <!-- BEGIN: manager -->
    <button class="btn btn-danger right" onclick="change(1, {id})">
      <span class="glyphicon glyphicon-remove"> </span>
    </button>
    <button class="btn right" disabled>
      <span class="glyphicon glyphicon-user"> </span>
    </button>
      <!-- END: manager -->
  </div>
<!-- END: main -->