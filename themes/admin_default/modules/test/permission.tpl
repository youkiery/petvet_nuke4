<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>

<div class="content">
  {content}
</div>

<div class="text-center">
  <button class="btn btn-success" onclick="update()">
    Cập nhật
  </button>
</div>
<script>
  var boxed = $('.boxed')

  function update() {
    freeze()
    list = []
    boxed.each((index, item) => {
      if (item.checked) {
        var id = item.getAttribute('id')
        list.push(id)
      }
    })
    $.post(
      strHref,
      {action: 'update', list: list},
      (response, status) => {
        checkResult(response, status).then(data => {

        })
      }
    )
  }
</script>
<!-- END: main -->
