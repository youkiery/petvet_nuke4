<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">

<div id="msgshow"></div>

<div id="modal-remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p>
          Xác nhận xóa?
        </p>
        <button class="btn btn-danger" onclick="removeSubmit()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-insert" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p class="text-center">
          Chọn vài trò nhân viên?
        </p>
        <div class="relative">
          <input type="text" class="form-control" id="insert-user">
          <div class="suggest" id="insert-user-suggest"></div>
        </div>
        <label>
          Nhân viên
          <input type="checkbox" class="form-control" id="insert-type-1">
        </label>
        <label>
          Quản lý
          <input type="checkbox" class="form-control" id="insert-type-2">
        </label>
        <div class="text-center">
          <button class="btn btn-info" onclick="insertSubmit()">
            Lưu
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<button class="btn btn-success" style="float: right;" onclick="insert()">
  <span class="glyphicon glyphicon-plus"></span>
</button>

<div style="clear: both;"></div>

<div id="content">
  {content}
</div>

<script>
  var content = $("#content")
  var global = {
    page: 1,
    id: 0
  }

  $(this).ready(() => {
    installRemind('insert-user')
  })

  function checkFilter() {
    return {
      page: global['page'],
      limit: 10
    }
  }

  function checkData() {
    return {
      p1: $("#insert-type-1").prop('checked') ? 1 : 0,
      p2: $("#insert-type-2").prop('checked') ? 1 : 0,
      id: global['id']
    }
  }

  function remove(id) {
    global['id'] = id
    $("#modal-remove").modal('show')
  }

  function removeSubmit() {
    $.post(
      global['url'],
      {action: 'remove', id: global['id'], filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-remove").modal('hide')
        }, () => {})
      }
    )
  }

  function insert() {
    $("#modal-insert").modal('show')
  }

  function pickOwner(name, id) {
    $("#insert-user").val(name)
    global['id'] = id
  }

  function insertSubmit() {
    $.post(
      global['url'],
      {action: 'insert', data: checkData(), filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-insert").modal('hide')
        }, () => {})
      }
    )
  }

  function installRemind(section) {
    var timeout
    var input = $("#" + section)
    var suggest = $("#" + section + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
          global['url'],
          { action: 'owner', keyword: key },
          (response, status) => {
            checkResult(response, status).then(data => {
              suggest.html(data['html'])
            }, () => { })
          }
        )

        suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 200);
    })
  }

</script>
<!-- END: main -->
