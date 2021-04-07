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

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-1,
  .col-2,
  .col-3,
  .col-4,
  .col-5,
  .col-6,
  .col-7,
  .col-8,
  .col-9,
  .col-10,
  .col-11,
  .col-12 {
    float: left;
  }

  .col-1 {
    width: 8.33%;
  }

  .col-2 {
    width: 16.66%;
  }

  .col-3 {
    width: 25%;
  }

  .col-4 {
    width: 33.33%;
  }

  .col-5 {
    width: 41.66%;
  }

  .col-6 {
    width: 50%;
  }

  .col-7 {
    width: 58.33%;
  }

  .col-8 {
    width: 66.66%;
  }

  .col-9 {
    width: 75%;
  }

  .col-10 {
    width: 83.33%;
  }

  .col-11 {
    width: 91.66%;
  }

  .col-12 {
    width: 100%;
  }

  .relative {
    position: relative;
  }

  .suggest_item {
    height: 30px;
    line-height: 30px;
    padding: 5px;
    border-bottom: 1px solid #ddd;
  }

  .suggest div:hover {
    background: #afa;
    cursor: pointer;
  }

  .suggest {
    z-index: 100;
    background: white;
    display: none;
    position: absolute;
    overflow-y: scroll;
    max-height: 300px;
    width: 100%;
  }
</style>
<div id="msgshow"></div>

{modal}

<!-- BEGIN: user -->
<div class="form-group">
  <a href="/admin/index.php?nv={module_name}"> Cấu hình </a> &gt; {branch}
</div>

<div class="form-group">
  <div class="rows">
    <div class="col-6 relative">
      <input type="text" class="form-control" id="user-name" placeholder="Nhập họ và tên hoặc tên tài khoản">
      <div class="suggest" id="user-name-suggest"></div>
    </div>
    <div class="col-6">
      <div style="float: right;">
        <button class="btn btn-info" onclick="moduleConfig()">
          Cấu hình chi nhánh
        </button>
      </div>
      <div style="clear: both;"></div>
    </div>
  </div>
</div>

<div id="user-content">
  {user_content}
</div>
<!-- END: user -->

<!-- BEGIN: branch -->
<div class="form-group">
  <div class="rows">
    <div class="col-3"> <input type="text" class="form-control" id="branch-name" placeholder="Tên chi nhánh"> </div>
    <div class="col-3"> <input type="text" class="form-control" id="branch-prefix" placeholder="Tiền tố"> </div>
    <button class="btn btn-success" onclick="insertBranch()">
      Thêm chi nhánh
    </button>
  </div>
</div>

<div id="branch-content">
  {branch_content}
</div>

<button class="btn btn-info btn-lg btn-block" onclick="updateBranch()">
  Cập nhật thông tin
</button>
<!-- END: branch -->

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-8.js"></script>
<script>
  global = {
    id: 0
  }
  var moduleStatus = 0
  var configid = 0

  $(document).ready(() => {
    vremind.install('#user-name', '#user-name-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', {
          action: 'user-suggest',
          keyword: input
        }).then((response) => {
          resolve(response.html)
        })
      })
    }, 300, 300)
  })

  function moduleConfig() {
    $('#config-module-modal').modal('show')
  }

  function change(id, type, value) {
    vhttp.checkelse('', {
      action: 'change',
      userid: id,
      type: type, 
      value: value
    }).then(data => {
      $('#user-content').html(data['html'])
    })
  }

  function insertUser() {
    $('#user-modal').modal('show')
  }

  function insertBranch() {
    name = $('#branch-name').val()
    prefix = $('#branch-prefix').val()
    if (!name.length) alert_msg('Chưa nhập tên chi nhánh')
    else if (!prefix.length) alert_msg('Chưa nhập tiền tố')
    else vhttp.checkelse('', {
      action: 'insert-branch',
      name: name,
      prefix: prefix,
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['html']) $('#branch-content').html(data['html'])
    })
  }

  function updateBranch() {
    data = []
    $('.branch').each((index, item) => {
      id = item.getAttribute('id')
      data.push({
        id: id,
        name: $('#name-' + id).val(),
        prefix: $('#prefix-' + id).val()
      })
    })

    vhttp.checkelse('', {
      action: 'update-branch',
      data: data
    }).then(response => {
      alert_msg('Cập nhật thông tin chi nhánh')
    })
  }

  function saveOvertime() {
    list = {}
    $('.overtime').each((index, item) => {
      id = item.getAttribute('id')
      temp = {
        starthour: Number($('#starthour-' + id).val()),
        startminute: Number($('#startminute-' + id).val()),
        endhour: Number($('#endhour-' + id).val()),
        endminute: Number($('#endminute-' + id).val()),
      }
      list[id] = checkOvertime(temp, id)
    })
    vhttp.checkelse('', {
      action: 'config-overtime',
      data: list
    }).then((response) => {
      alert_msg('Đã lưu cấu hình')
      $('#config-module-modal').modal('hide')
    })
  }

  function checkOvertime(data, id) {
    check = 0;
    if (data['starthour'] < 0) data['starthour'] = 0
    if (data['endhour'] < 0) data['endhour'] = 0
    if (data['startminute'] < 0) data['startminute'] = 0
    if (data['endminute'] < 0) data['endminute'] = 0
    if (data['starthour'] > 24) data['starthour'] = 24
    if (data['endhour'] > 24) data['endhour'] = 24
    if (data['startminute'] > 60) data['startminute'] = 60
    if (data['endminute'] > 60) data['endminute'] = 60
    if (data['starthour'] > data['endhour']) check = 1;
    else if ((data['starthour'] == data['endhour']) && (data['startminute'] > data['endminute'])) check = 1;
    if (check) {
      a = [ data['starthour'], data['startminute'] ];
      data['starthour'] = data['endhour']
      data['startminute'] = data['endminute']
      data['endhour'] = a[0]
      data['endminute'] = a[1]
    }

    $('#starthour-' + id).val(data['starthour'])
    $('#startminute-' + id).val(data['startminute'])
    $('#endhour-' + id).val(data['endhour'])
    $('#endminute-' + id).val(data['endminute'])
    return data
  }

  function alert_msg(msg) {
    $('#msgshow').html(msg);
    $('#msgshow').show('slide').delay(2000).hide('slow');
  }

  function removeBranchSubmit(id) {
    vhttp.checkelse('', {
      action: 'remove-branch',
      id: id
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['html']) $('#branch-content').html(data['html'])
    })
  }

  function insertUserSubmit(userid) {
    vhttp.checkelse('', {
      action: 'insert-user',
      userid: userid,
      keyword: $('#user-name').val()
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['content']) $('#user-content').html(data['content'])
      if (data['list']) $('#user-name-suggest').html(data['list'])
      $('#user-modal').modal('hide')
    })
  }

  function overtimeModal(setting = '', module = 1) {
    moduleStatus = module
    settingConfig = setting.split('-')
    $('starthour').val(settingConfig[0])
    $('startminute').val(settingConfig[1])
    $('endhour').val(settingConfig[2])
    $('endminute').val(settingConfig[3])
    $('#overtime-modal').modal('show')
  }

  function removeUser(userid) {
    global.id = userid
    $('#user-remove-modal').modal('show')
    $('#remove-btn').focus()
    
  }

  function removeUserSubmit() {
    vhttp.checkelse('', {
      action: 'remove-user',
      userid: global.id,
      keyword: $('#user-name').val()
    }).then(data => {
      if (data['msg']) alert_msg('msg')
      if (data['content']) $('#user-content').html(data['content'])
      $('#user-remove-modal').modal('hide')
    })
  }

  function alert_msg(msg) {
    $('#msgshow').html(msg);
    $('#msgshow').show('slide').delay(2000).hide('slow');
  }
</script>
<!-- END: main -->