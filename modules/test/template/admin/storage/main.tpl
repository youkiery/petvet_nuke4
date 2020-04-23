<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">

<div class="form-group">
  <div class="rows">
    <div class="col-5">
      <div class="input-group">
        <input type="text" class="form-control" id="name">
        <div class="input-group-btn">
          <button class="btn btn-success" onclick="insert()">
            Thêm mới
          </button>
        </div>
      </div>
    </div>
    <div class="col-2"></div>
    <div class="col-5">
      <form class="input-group">
        <input type="text" class="form-control" id="keyword">
        <div class="input-group-btn">
          <button class="btn btn-info">
            Tìm kiếm
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"> </script>
<script>
  var global = {
    type: Number('{type}')
  }

  function insert() {
    // type, 0: vị trí, 1: hàng hóa
    action = 'insert-position'
    if (global['type']) {
      action = 'insert-item'
    }
    vhttp.checkelse('', { action: action, name: $("#name").val() }).then(data => {
      $("#content").html(data['html'])
    })
  }

  function removeItem(id) {
    vhttp.checkelse('', { action: 'remove-item', id: id }).then(data => {
      $("#content").html(data['html'])
    })   
  }

  function remove(id) {
    vhttp.checkelse('', { action: 'remove-position', id: id }).then(data => {
      $("#content").html(data['html'])
    })   
  }
</script>
<!-- END: main -->