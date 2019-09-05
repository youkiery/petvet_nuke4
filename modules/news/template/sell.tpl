<!-- BEGIN: main -->
<div class="container">
  <div id="msgshow"></div>
  <a href="/">
    <img src="/themes/default/images/banner.png" style="width: 200px;">
  </a>
  <div style="float: right;">
    {FILE "heading.tpl"}
  </div>
  <!-- <form style="width: 60%; float: right;">
    <label class="input-group">
      <input type="hidden" name="nv" value="biograph">
      <input type="hidden" name="op" value="list">
      <input type="text" class="form-control" name="keyword" value="{keyword}" id="keyword" placeholder="Nhập tên hoặc mã số">
      <div class="input-group-btn">
        <button class="btn btn-info"> Tìm kiếm </button>
      </div>
    </label>
  </form> -->
  <div style="clear: both;"></div>

  <div id="content">
    {content}
  </div>
</div>
<script>
  var global = {
    'url': '{url}',
    'page': 1
  }
  var content = $("#content")

  function checkFilter() {
    return {
      page: global['page'],
      limit: 12,
      keyword: ''
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
        })
      }
    )
  }
</script>
<!-- END: main -->
