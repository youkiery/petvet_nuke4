<!-- BEGIN: main -->
  <!-- <a href="/biograph/user"> Đăng nhập </a> -->
  <div class="text-center start-content">
    <img src="/assets/images/banner88x31.png">
    <p> Nhập tên hoặc mã microchip để tìm kiếm thông tin</p>
    <form action="/biograph/list">
      <div style="width: 60%; margin: auto;">
        <label class="input-group">
          <input type="text" class="form-control" name="keyword" id="keyword" placeholder="Nhập tên hoặc mã số">
          <div class="input-group-btn">
            <button class="btn btn-info" onclick="search()"> Tìm kiếm </button>
          </div>
        </label>
        <a href="/user/kernel"> Đăng ký giống </a> |
        <a href="/user/center"> Đăng ký trại </a>
      </div>
    </form>
  </div>
  <script>
    var content = $("#content")
    var keyword = $("#keyword")
    var thisUrl = '/biograph/main'

    $(document).ready(() => {
      $(".clickable-row").click(function() {
        window.location.replace($(this).data("href"));
      });
    });

    // function search() {
    //   request(thisUrl,
    //     {action: 'search', keyword: keyword.val()}).then(data => {
    //       content.data['html']
    //     })
    // }
  </script>
<!-- END: main -->
