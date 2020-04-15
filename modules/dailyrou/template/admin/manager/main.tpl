<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

{modal}

<div class="form-group">
  <button class="btn btn-info" onclick="insertMember()">
    Thêm nhân viên mới
  </button>
</div>
<h2> Thay đổi danh sách quản lý </h2>
<div id="content">
  {content}
</div>
<script>
  var global = {
    id: 0,
    memberpage: 1,
    page: 1,
  }
  var content = $("#content")

  function change(type, id) {
    $(".btn").attr("disabled", true)
    $.post(
      strHref,
      { action: "change", type: type, id: id },
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

  function removeMember(id) {
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function removeSubmit() {
        $.post(
            '',
            { action: 'remove-member', id: global['id'], filter: checkFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                    $("#remove-modal").modal('hide')
                })
            }
        )
    }

    function checkFilter() {
        return {
            page: global['page'],
            limit: 10
        }
    }

    function insertMemberSubmit(id) {
        $.post(
            '',
            { action: 'insert-member', id: id, filter: checkFilter(), memfilter: checkMemberFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#member-content").html(data['html'])
                    $("#content").html(data['html2'])
                })
            }
        )
    }

    function goMemPage(page) {
        global['memberpage'] = page
        $.post(
            '',
            { action: 'member-filter', memfilter: checkMemberFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#member-content").html(data['html'])
                })
            }
        )
    }

    function insertMember() {
        $("#member-modal").modal('show')
    }

    function checkMemberFilter() {
        return {
            page: global['memberpage'],
            limit: 10,
            keyword: $("#member-keyword").val()
        }
    }

</script>
<!-- END: main -->