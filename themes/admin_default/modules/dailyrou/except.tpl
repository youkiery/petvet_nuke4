<!-- BEGIN: main -->
  <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
  <div class="msgshow" id="msgshow"></div>

  <h2> Thay đổi danh sách nhân viên ngoại lệ </h2>
  <div id="content">
    {content}
  </div>
  <script>
    var content = $("#content")

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