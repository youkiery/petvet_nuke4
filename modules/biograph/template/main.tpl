<!-- BEGIN: main -->
  <div class="text-center start-content">
    <img src="/assets/images/banner88x31.png">
    <p> Nhập tên hoặc mã microchip để tìm kiếm thông tin</p>
    <form>
      <div>
        <label class="input-group">
          <input type="text" class="form-control" id="keyword" placeholder="Nhập tên hoặc mã số">
          <div class="input-group-btn">
            <button class="btn btn-info" onclick="search()"> Tìm kiếm </button>
          </div>
        </label>
      </div>
    </form>
  </div>
  <div id="content"> {content} </div>
  <script>
    var content = $("#content")
    var keyword = $("#keyword")
    var thisUrl = '/biograph/main'

    function search() {
      request(thisUrl,
        {action: 'search', keyword: keyword.val()}).then(data => {
          content.data['html']
        })
    }
  </script>
<!-- END: main -->
