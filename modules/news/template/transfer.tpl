<!-- BEGIN: main -->
<div class="container">
  <a href="/biograph/">
    <img src="/modules/news/src/banner.png" style="width: 200px;">
  </a>

  <div style="float: right;">
    <a href="/biograph/logout"> Đăng xuất </a>
  </div>
  <div class="separate"></div>
  <a href="/biograph/login" style="margin: 8px 0px; display: block;"> <span class="glyphicon glyphicon-chevron-left">  </span> Trở về </a>
  <div id="content">
    {content}
  </div>
</div>
<script>
  var global = {
    url: '{url}',
    page: 1
  }
  var content = $("#content")

  function checkFilter() {
    return {
      page: global['page'],
      limit: 10
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      global['url'],
      {action: 'filter', filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
