<!-- BEGIN: main -->
<div class="container">
  <a href="/">
    <img src="/modules/{module_file}/src/banner.png" style="width: 200px;">
  </a>
  <form style="width: 60%; float: right;">
    <label class="input-group">
      <input type="hidden" name="nv" value="biograph">
      <input type="hidden" name="op" value="list">
      <input type="text" class="form-control" name="keyword" value="{keyword}" id="keyword" placeholder="Nhập tên hoặc mã số">
      <div class="input-group-btn">
        <button class="btn btn-info"> Tìm kiếm </button>
      </div>
    </label>
  </form>
  <div style="clear: both;"></div>

  <div id="content" style="font-size: 0px;">
    {content}
  </div>
</div>
<script>
  var global = {
    page: 1
  }
  var keyword = $("#keyword")
  var content = $("#content")

  function checkFilter() {
    return {
      page: global['page'],
      keyword: keyword.val()
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      global['url'],
      { action: 'filter', data: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { })
      }
    )
  }
</script>
<!-- END: main -->
