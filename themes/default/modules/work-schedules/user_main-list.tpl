<!-- BEGIN: main -->
<button class="btn btn-info depart active" id="depart_0" onclick="change_data(0)">
  {lang.work_owner}
</button>
<!-- BEGIN: row -->
<button class="btn depart" id="depart_{id}" onclick="change_data({id})">
  {name}
</button>
<!-- END: row -->
<!-- BEGIN: manager -->
<button class="btn depart" id="depart_end" onclick="change_data('end')">
  {lang.work_manager}
</button>
<!-- END: manager -->  
<!-- END: main -->
