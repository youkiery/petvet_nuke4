<!-- BEGIN: main  -->
<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm nhân viên </h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return filter()">
          <div class="input-group">
            <input type="text" class="form-control" id="insert-keyword">
            <div class="input-group-btn">
              <button class="btn btn-info">
                tìm kiếm
              </button>
            </div>
          </div>
        </form>

        <div id="insert-content"></div>
      </div>
    </div>
  </div>
</div>

<div class="form-group">
  <button class="btn btn-success" onclick="insertModal()">
    + thêm nhân viên
  </button>
</div>

<div id="content">
  {content}
</div>

<span style="border: 1px solid black; width: 15px; height: 15px; background: #f0ad4e; display: inline-block;"></span> bật 
<span style="border: 1px solid black; width: 15px; height: 15px; background: #5bc0de; display: inline-block;"></span> tắt

<script src="/modules/core/js/vhttp.js"></script>
<script>
  $(document).ready(() => {
    $('#form').submit(function (evt) {
      evt.preventDefault();
    });
  })

  function insertModal() {
    $('#insert-modal').modal('show')
  }

  function filter() {
    vhttp.checkelse('/tester/staff/', {
      action: 'filter',
      keyword: $('#insert-keyword').val()
    }).then(response => {
      $('#insert-content').html(response.html)
    })
    return false
  }

  function insert(userid) {
    vhttp.checkelse('/tester/staff/', {
      action: 'insert',
      userid: userid,
      keyword: $('#insert-keyword').val()
    }).then(response => {
      $('#content').html(response.html)
      $('#insert-content').html(response.html2)
    })
  }

  function update(userid, type, value) {
    vhttp.checkelse('/tester/staff/', {
      action: 'update',
      data: {
        userid: userid,
        type: type,
        value: value,
      }
    }).then(response => {
      $('#content').html(response.html)
    })
  }

  function remove(userid) {
    vhttp.checkelse('/tester/staff/', {
      action: 'remove',
      userid: userid
    }).then(response => {
      $('#content').html(response.html)
    })
  }
</script>
<!-- END: main  -->
