<!-- BEGIN: main -->
<button class="btn btn-info depart active" id="depart_0" onclick="my_work()">
  {lang.work_owner}
</button>
<!-- BEGIN: row -->
<button class="btn depart" id="depart_{id}" onclick="change_data({id})">
  {name}
</button>
<!-- END: row -->
<!-- BEGIN: manager -->
<button class="btn depart" id="depart_end" onclick="manager_work()">
  {lang.work_manager}
</button>
<!-- END: manager -->  
<!-- END: main -->
