<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<script src="/modules/core/js/vhttp.js"></script>
<div class="msgshow" id="msgshow"></div>

{modal}

<div class="form-group">
  <button class="btn btn-success right" onclick="insertAlert()">
    Gửi giải pháp
  </button>
</div>

<div style="clear: both;"></div>

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
  var g_page = {page}
  var page = 0
  var limit = {limit}

  $(document).ready(() => {
    initiaze()
  })

  function insertAlert() {
    edit.hide()
    insert.show()
    $('#problem').val('')
    $('#solution').val('')
    $('#result').val('')
    insertModal.modal("show")
  }

  function initiaze() {
    $(".edit").click((e) => {
      var id = e.currentTarget.getAttribute("rel");
      g_id = id
      problem.val(trim($("#p" + id).text()))
      solution.val(trim($("#s" + id).text()))
      result.val(trim($("#r" + id).text()))
      
      insert.hide()
      edit.show()
      insertModal.modal("show")
    })
  }

  function removeAlert(id) {
    g_id = id
    removeModal.modal("show")
  }

  function checkFormData() {
    var data = {
      problem: problem.val(),
      solution: solution.val(),
      result: result.val()
    }
    if (!data['problem'].length) return 'Nhập vấn đề trước khi gửi'
    else if (!data['solution'].length) return 'Nhập giải pháp trước khi gửi'
    else if (!data['result'].length) return 'Nhập hiệu quả trước khi gửi'
    return data
  }

  function insertSubmit() {
    idata = checkFormData()
    if (!idata['problem']) alert_msg(idata)
    else {
      freeze()
      vhttp.check('', {action: "insert", data: idata }).then(data => {
        content.html(data["html"])
            $("#problem").val('')
            $("#solution").val('')
            $("#result").val('')
            g_id = 0
            initiaze()
            defreeze()
            insertModal.modal("hide")
      }, () => {
        defreeze()
      })
    }
  }

  function editSubmit() {
    if (g_id) {
      freeze()
      $.post(
        strHref,
        {action: "edit", page: page, limit: limit, id: g_id, problem: problem.val(), solution: solution.val(), result: result.val()},
        (response, status) => {
          checkResult(response, status).then((data) => {
            content.html(data["html"])
            g_id = 0
            initiaze()
            defreeze()
            insertModal.modal("hide")
          }, () => {
            defreeze()
          })
        }
      )
    }
  }

  function removeSubmit() {
    if (g_id) {
      freeze()
      $.post(
        strHref,
        {action: "remove", page: page, limit: limit, id: g_id},
        (response, status) => {
          checkResult(response, status).then((data) => {
            content.html(data["html"])
            g_id = 0
            initiaze()
            defreeze()
            removeModal.modal("hide")
          }, () => {
            defreeze()
          })
        }
      )
    }
  }

  function goPage(pPage) {
    freeze()
    $.post(
      strHref,
      {action: "filter", page: page, limit: limit},
      (response, status) => {
        checkResult(response, status).then((data) => {
          page = pPage
          g_id = 0
          content.html(data["html"])
          initiaze()
          defreeze()
          removeModal.modal("hide")
        }, () => {
          defreeze()
        })
      }
    )
  }
  
</script>
<!-- END: main -->