<!-- BEGIN: main -->
<style>
  #msgshow {
    position: fixed;
    top: 0px;
    right: 0px;
    background: white;
    padding: 10px;
    z-index: 100;
    border: 1px solid gray;
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
    display: none;
    z-index: 10000;
  }
</style>
<div id="msgshow"></div>

{modal}

<!-- BEGIN: user -->
<div class="form-group">
  <div style="float: right;">
    <button class="btn btn-success" onclick="insertUser()">
      Thêm nhân viên
    </button>
  </div>
  <div style="clear: both;"></div>
</div>

<div id="user-content">
  {user_content}
</div>
<!-- END: user -->

<!-- BEGIN: branch -->
<div class="form-group">
  <div style="float: right;">
    <button class="btn btn-success" onclick="insertBranch()">
      Thêm chi nhánh
    </button>
  </div>
  <div style="clear: both;"></div>
</div>


<div id="branch-content">
  {branch_content}
</div>
<!-- END: branch -->

<script src="/modules/core/js/vhttp.js"></script>
<script>
  function insertBranch() {
    $('#branch-modal').modal('show')
  }

  function insertUser() {
    $('#user-modal').modal('show')
  }

  function insertBranchSubmit() {
    name = $('#branch-name').val()
    if (!name.length) alert_msg('Chưa nhập tên chi nhánh')
    else vhttp.checkelse('', {
      action: 'insert-branch',
      name: name
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['html']) $('#branch-content').html(data['html'])
      $('#branch-modal').modal('hide')
    })
  }

  function removeBranchSubmit($id) {
    vhttp.checkelse('', {
      action: 'remove-branch',
      id: id
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['html']) $('#branch-content').html(data['html'])
    })
  }

  function insertUserSubmit($userid) {
    vhttp.checkelse('', {
      action: 'insert-user',
      userid: userid
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['content']) $('#user-content').html(data['content'])
      if (data['list']) $('#user-modal-list').html(data['list'])
      $('#user-modal').modal('hide')
    })
  }

  function filterUser() {
    
  }

  function removeUserSubmit($userid) {
    vhttp.checkelse('', {
      action: 'remove-user',
      userid: userid
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['content']) $('#user-content').html(data['content'])
    })
  }

  function alert_msg(msg) {
    $('#msgshow').html(msg); 
    $('#msgshow').show('slide').delay(2000).hide('slow'); 
  }
</script>
<!-- END: main -->
