<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>

<div id="content">
  {content}
</div>

<div class="text-center">
  <button class="btn btn-success" onclick="update()">
    Cập nhật
  </button>
</div>
<script>
  var boxed = $('.boxed')
  var content = $('#content')

  function update() {
    freeze()
    list = {}
    boxed.each((index, item) => {
      if (item.checked) {
        var id = item.getAttribute('id')
        var param = id.split('_')
        
        if (param[0]) {
          if (!list[param[0]]) {
            list[param[0]] = {}
          }
          list[param[0]][param[1]] = param[2]
        }
      }
    })
    
    $.post(
      strHref,
      {action: 'update', list: list},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        })
      }
    )
  }
</script>
<!-- END: main -->
