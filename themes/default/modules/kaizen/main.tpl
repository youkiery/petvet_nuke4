<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script> -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="insert_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Nhập thông tin vào phiếu để hoàn tất </h2>
        <br>
        <div class="form-group">
          <label> Vấn đề </label>
          <input class="form-control" id="problem" type="text" >
        </div>
        <div class="form-group">
          <label> Giải quyết </label>
          <textarea class="form-control" id="solution"></textarea>
        </div>
        <div class="form-group">
          <label> Hiệu quả </label>
          <textarea class="form-control" id="result"></textarea>
        </div>
        <div class="text-center">
          <button class="btn btn-success" id="insert" onclick="insertSubmit()">
            Gửi giải pháp
          </button>
          <button class="btn btn-info" id="edit" onclick="editSubmit()">
            Sửa giải pháp
          </button>
          <button class="btn btn-danger" data-dismiss="modal">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="remove_modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Xác nhận trước khi xóa </h2>
        <br>
        <div class="text-center">
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xóa
          </button>
          <button class="btn" data-dismiss="modal">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<button class="btn btn-success right" onclick="insertAlert()">
  <span class="glyphicon glyphicon-plus"> </span>
</button>
<div id="content">
  {content}
</div>
<script>
  var content = $("#content")
  var insertModal = $("#insert_modal")
  var removeModal = $("#remove_modal")
  var insert = $("#insert")
  var edit = $("#edit")
  var problem = $("#problem")
  var solution = $("#solution")
  var result = $("#result")

  var g_id = 0

  initiaze()

  function insertAlert() {
    edit.hide()
    insert.show()
    insertModal.modal("show")
  }

  function initiaze() {
    $(".edit").click((e) => {
      var id = e.currentTarget.getAttribute("rel");
      var child = e.currentTarget.parentElement.parentElement.children
      g_id = id
      problem.val(trim(child[1].innerText))
      solution.val(trim(child[2].innerText))
      result.val(trim(child[3].innerText))
      
      insert.hide()
      edit.show()
      insertModal.modal("show")
    })
  }

  function editAlert(e, id) { 
    // var currentRow = e.target.parentElement
    // g_id = id
    // console.log(currentRow);
    // console.log(e.target.parentElement.parentElement.parentElement);
    
    // console.log(currentRow[1]);
    
    // problem.val(trim(currentRow[1].innerText))
    // solution.val(trim(currentRow[2].innerText))
    // result.val(trim(currentRow[3].innerText))
    
    // insert.hide()
    // edit.show()
    // insertModal.modal("show")

    // if (g_id) {
    //   freeze()
    //   $.post(
    //     strHref,
    //     {action: "getEdit", id: g_id},
    //     (response, status) => {
    //       checkResult(response, status).then((data) => {
    //         insert.hide()
    //         edit.show()
    //         problem.val(data["data"]["problem"])
    //         solution.val(data["data"]["solution"])
    //         result.val(data["data"]["result"])
    //         insertModal.modal("show")
    //         defreeze()
    //       }, () => {})
    //     }
    //   )
    // }
  }

  function removeAlert(id) {
    g_id = id
    removeModal.modal("show")
  }

  function insertSubmit() {
    freeze()
    $.post(
      strHref,
      {action: "insert", problem: problem.val(), solution: solution.val(), result: result.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
          g_id = 0
          initiaze()
          defreeze()
          insertModal.modal("hide")
        }, () => {})
      }
    )
  }

  function editSubmit() {
    if (g_id) {
      freeze()
      $.post(
        strHref,
        {action: "edit", id: g_id, problem: problem.val(), solution: solution.val(), result: result.val()},
        (response, status) => {
          checkResult(response, status).then((data) => {
            content.html(data["html"])
            g_id = 0
            initiaze()
            defreeze()
            insertModal.modal("hide")
          }, () => {})
        }
      )
    }
  }

  function removeSubmit() {
    if (g_id) {
      freeze()
      $.post(
        strHref,
        {action: "remove", id: g_id},
        (response, status) => {
          checkResult(response, status).then((data) => {
            content.html(data["html"])
            g_id = 0
            initiaze()
            defreeze()
            removeModal.modal("hide")
          }, () => {})
        }
      )
    }
  }

  
</script>
<!-- END: main -->