<!-- BEGIN: main -->
  <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
  <div class="msgshow" id="msgshow"></div>

  <div class="modal fade" id="insert-position" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <form onsubmit="insertPositionSubmit(event)">
            <label class="row">
              <span class="col-sm-6"> Tên tầng </span>
              <div class="col-sm-18">
                <div class="input-group">
                  <input type="text" class="form-control" id="insert-position-name">
                  <div class="input-group-btn">
                    <button class="btn btn-success">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
              </div>
            </label>
          </form>
          <div id="insert-position-content">
            {position_user}
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="remove-position" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-body text-center">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p> <b> Xác nhận xóa tầng đã chọn </b> </p>
          <button class="btn btn-danger" onclick="removePositionSubmit()">
            <span class="glyphicon glyphicon-remove"></span>
          </button>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <button class="btn btn-info" data-toggle="modal" data-target="#insert-position">
      <span class="glyphicon glyphicon-eye-open"></span>
    </button>
  </div>

  <div id="content">
    {content}
  </div>
  <script>
    var insertPosition = $("#insert-position")
    var insertPositionName = $("#insert-position-name")
    var insertPositionContent = $("#insert-position-content")
    var removePosition = $("#remove-position")
    var content = $("#content")

    var global_id = 0

    function insertPositionSubmit(e) {
      e.preventDefault()
      $.post(
        strHref,
        {action: 'insert-position', name: insertPositionName.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            console.log(data);
            
            insertPositionContent.html(data['position'])
            content.html(data['position_user'])
          }, () => {})
        }
      )
    }

    function removePositionModal(id) {
      global_id = id
      removePosition.modal('show')
    }

    function removePositionSubmit() {
      $.post(
        strHref,
        {action: 'remove-position', id: global_id},
        (response, status) => {
          checkResult(response, status).then(data => {
            insertPositionContent.html(data['position'])
            content.html(data['position_user'])
            removePosition.modal('hide')
          }, () => {})
        }
      )
    }

    function setPosition(type, userid, id) {
      $.post(
        strHref,
        {action: 'set-position', type: type, userid: userid, id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            content.html(data['position_user'])
          }, () => {})
        }
      )
    }

    function change(type, id) {
      $(".btn").attr("disabled", true)
        $.post(
        strHref,
        {action: "change", except: type, id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            $(".btn").attr("disabled", false)
            content.html(data["html"])
          }, () => {
            $(".btn").attr("disabled", false)
          })
        }
      )
    }

  </script>
<!-- END: main -->