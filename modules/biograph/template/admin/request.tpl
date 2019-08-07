<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="/modules/biograph/src/glyphicons.css">

<div id="content">
  {content}
</div>

<script>
  var content = $("#content")
  var global = {
    page: 1
  }

  function goPage(page) {
    $.post(
      strHref,
      {action: 'gopage', page: page},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['page'] = page
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function check(id) {
    $.post(
      strHref,
      {action: 'check', id: id, page: global['page']},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
  } 

  function remove(id) {
    $.post(
      strHref,
      {action: 'remove', id: id, page: global['page']},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
  } 
</script>
<!-- END: main -->
