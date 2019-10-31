<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<!-- <div class="modal" id="item" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>

        <div class="input-group">
          <input type="text" class="form-control" id="item-keyword">
          <div class="input-group-btn">
            <button class="btn btn-info" onclick="search()"> <span class="glyphicon glyphicon-search"></span> </button>
          </div>
        </div>
        <div id="item-content">
          {item-content}
        </div>
      </div>
    </div>
  </div>
</div> -->


<div class="row">
  <div class="col-sm-12 col-md-9">
    <div class="input-group">
      <input type="text" class="form-control" id="insert-name" placeholder="Nhập thêm tên hàng ">
      <div class="input-group-btn">
        <button class="btn btn-info" onclick="insert()"> <span class="glyphicon glyphicon-floppy-disk"></span> </button>
      </div>
    </div>
  </div>
</div>

<div id="msgshow"></div>

<div id="content">
  {content}
</div>

<script src="/modules/exp/src/script.js"></script>
<script>
  var global = {
    page: 1
  }

  function insert() {
    $.post(
      '',
      {action: 'insert', name: $("#insert-name").val(), page: global['page']},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#insert-name").val('')
          $("#content").html(data['html'])
        }, () => {}) 
      }
    )
  }
  function update(id) {
    $.post(
      '',
      {action: 'update', name: $("#item-" + id).val(), id: id},
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => {}) 
      }
    )
  }
  function remove(id) {
    $.post(
      '',
      {action: 'update', id: id, page: global['page']},
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => {}) 
      }
    )
  }
  function goPage(page) {
    $.post(
      '',
      {action: 'filter', page: page},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['page'] = page
          $('#content').html(data['html'])
        }, () => {}) 
      }
    )
  }
</script>
<!-- END: main -->