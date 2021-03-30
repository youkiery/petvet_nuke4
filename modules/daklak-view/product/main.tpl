<!-- BEGIN: main  -->
<div id="update-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Cập nhật mặt hàng </h4>
      </div>

      <div class="modal-body">
        <form onsubmit="updateSubmit()">
          <div class="form-group">
            <label> Mã hàng </label>
            <input type="text" class="form-control" id="update-code">
          </div>
          <div class="form-group">
            <label> Tên mặt hàng </label>
            <input type="text" class="form-control" id="update-name">
          </div>
          <div class="form-group">
            <label> Giới hạn nhập kho </label>
            <input type="text" class="form-control" id="update-limitup">
          </div>
          <div class="form-group">
            <label> Giới hạn chuyển kho </label>
            <input type="text" class="form-control" id="update-limit">
          </div>

          <div id="update-image"></div>

          <button class="btn btn-info btn-block">
            Cập nhật
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vimage.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    id: 0
  }
  
  $('form').submit(function (evt) {
    evt.preventDefault();
  });
  vimage.install('update-image', 300, 300, (list) => {  })

  function update(id) {
    global.id = id
    vhttp.checkelse('', {
      action: 'get-update',
      id: id
    }).then(response => {
      $('#update-modal').modal('show')
    })
  }

  function updateSubmit() {
    data = {
      code: $('#update-code').val(),
      name: $('#update-name').val(),
      limitup: $('#update-limitup').val(),
      limitdown: $('#update-limitdown').val(),
    }
    vhttp.checkelse('', {
      action: 'update',
      data: data
    }).then(response => {
      $('content').html(response.content)
      $('#update-modal').modal('hide')
    })
  }
</script>
<!-- END: main  -->
