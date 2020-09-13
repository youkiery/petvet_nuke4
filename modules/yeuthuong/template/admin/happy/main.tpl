<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">

<div id="msgshow"></div>

{modal}

<div class="form-group row-x">
  <form>
    <input type="hidden" name="nv" value="register">
    <input type="hidden" name="op" value="happy">
    <input type="hidden" name="status" value="{status}">
    <div class="col-4">
      <input type="text" class="form-control" name="keyword" value="{keyword}" placeholder="Nhập tên người, SĐT">
    </div>
    <div class="col-3">
      <button class="btn btn-info">
        Lọc
      </button>
    </div>
  </form>
  <div class="col-1"></div>
  <div class="col-4" style="text-align: right;">
    <button class="btn btn-info" onclick="managerModal()">
      Danh sách quản lý
    </button>
  </div>
</div>

<ul class="nav nav-tabs">
  <li class="{status0}"> <a href="/admin/index.php?nv={module_name}&op=happy&status=0"> Chưa duyệt </a></li>
  <li class="{status1}"> <a href="/admin/index.php?nv={module_name}&op=happy&status=1"> Đã duyệt </a></li>
</ul>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    id: 0,
    image: []
  }

  function done(id, type) {
    vhttp.checkelse('', { action: 'done', id: id, type: type }).then(data => {
      $("#content").html(data['html'])
    })
  }

  function preview(id) {
    vhttp.checkelse('', { action: 'preview', id: id }).then(data => {
      $("#preview-content").html(data['html'])
      $("#preview-modal").modal('show')
    })
  }

  function edit(id) {
    vhttp.checkelse('', { action: 'get-info', id: id }).then(data => {
      global['id'] = id
      refreshImage(data['data']['image'])
      $("#edit-fullname").val(data['data']['fullname'])
      $("#edit-mobile").val(data['data']['mobile'])
      $("#edit-address").val(data['data']['address'])
      $("#edit-name").val(data['data']['name'])
      $("#edit-species").val(data['data']['species'])
      $("#edit-note").val(data['data']['note'])
      $("#edit-modal").modal('show')
    })
  }

  function remove(id) {
    global['id'] = id
    $("#remove-modal").modal('show')
  }

  function removeSubmit(id) {
    vhttp.checkelse('', { action: 'remove', id: global['id'] }).then(data => {
      $("#content").html(data['html'])
      $("#remove-modal").modal('hide')
    })
  }

  function checkData() {
    var data = {
      fullname: $("#edit-fullname").val(),
      name: $("#edit-name").val(),
      species: $("#edit-species").val(),
      address: $("#edit-address").val(),
      mobile: $("#edit-mobile").val(),
      note: $("#edit-note").val()
    }
    if (!data.mobile.length) return 'Số điện thoại không được để trống'
    return data
  }

  function editSubmit(id) {
    sdata = checkData()
    if (!sdata['name']) notify(sdata)
    else {
      vhttp.checkelse('', { action: 'edit', data: sdata, id: global['id'] }).then(data => {
        $("#content").html(data['html'])
        $("#edit-modal").modal('hide')
      })
    }
  }

  function refreshImage(list) {
    html = ''
    list.forEach((item, index) => {
      html += `
      <div class="thumb">
        <img class="img-responsive" src="`+ item + `">
      </div>`
    })
    $("#image-list").html(html)
  }

  function notify(text) {
    $("#notify").show()
    $("#notify").text(text)
    $("#notify").delay(1000).fadeOut(1000)
  }

  function managerModal() {
    $("#manager-name").val('')
    $("#manager-modal").modal('show')
  }

  function employModal() {
    $("#employ-name").val('')
    $("#employ-content").html('')
    $("#employ-modal").modal('show')
  }

  function employFilter() {
    vhttp.checkelse('', { action: 'employ-filter', name: $("#employ-name").val() }).then((data) => {
      $("#employ-content").html(data['html'])
    })
  }

  function insertEmploy(id) {
    vhttp.checkelse('', { action: 'insert-employ', id: id, name: $("#employ-name").val() }).then((data) => {
      $("#manager-content").html(data['html'])
      $("#employ-content").html(data['html2'])
    })
  }

  function removeManager(id) {
    vhttp.checkelse('', { action: 'remove-manager', id: id }).then((data) => {
      $("#manager-content").html(data['html'])
    })
  }
</script>
<!-- END: main -->