<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<style>
  .cell-center {
    vertical-align: inherit !important;
  }
  .select {
    background: rgb(223, 223, 223);
    border: 2px solid deepskyblue;
  }
</style>

<div class="container">
  <div id="msgshow"></div>
  <a href="/">
    <img src="/themes/default/images/banner.png" style="width: 200px;">
  </a>

  <a style="margin: 8px 0px; display: block;" href="javascript:history.go(-1)">
    <span class="glyphicon glyphicon-chevron-left">  </span> Trở về </a>
  </a>
  <div style="clear: both;"></div>

  <div class="modal" id="modal-contact" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p class="text-center">
            Danh sách thú cưng
          </p>

          <div id="contact-content" style="max-height: 400px; overflow-y: scroll;">
            
          </div>
        </div>
      </div>
    </div>
  </div>


  <div id="content">
    {content}
  </div>
</div>

<script>
  var content = $("#content")
  var global = {
    page: 1,
    page2: 1,
    user: 0
  }

  function checkFilter() {
    return {
      page: global['page'],
      limit: 10,
    }
  }

  function checkOpfilter() {
    return {
      page: global['page2'],
      limit: 10,
    }
  }

  function filter(e) {
    e.preventDefault()
    goPage(1)
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      "",
      { action: 'gopage', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { })
      }
    )
  }

  function goPage2(page) {
    global['page2'] = page
    $.post(
      "",
      { action: 'filter2', id: global['user'], filter: checkOpfilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#contact-content").html(data['html'])
        }, () => { })
      }
    )
  }

  function view(id) {
    global['page2'] = 1
    $.post(
      "",
      { action: 'view', id: id, filter: checkOpfilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#contact-content").html(data['html'])
          $("#modal-contact").modal('show')
          global['user'] = id
        }, () => { })
      }
    )
  }

  function takeback(id) {
    $.post(
      "",
      { action: 'takeback', id: id, user: global['user'], filter: checkOpfilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#contact-content").html(data['html'])
        }, () => { })
      }
    )
  }
</script>
<!-- END: main -->
