<!-- BEGIN: main -->
<div class="container">
    <div class="text-center start-content">
      <img src="/modules/biograph/src/banner.png">
      <p> Nâng niu tình yêu động vật </p>
      <form action="/biograph/list">
        <div style="width: 60%; margin: auto;">
          <label class="input-group">
            <input type="text" class="form-control" name="keyword" id="keyword" placeholder="Nhập tên hoặc mã số" autocomplete="off">
            <div class="input-group-btn">
              <button class="btn btn-info" onclick="search()"> Tìm kiếm </button>
            </div>
          </label>
          <!-- BEGIN: nolog -->
          <a href="/biograph/login"> Đăng nhập </a> |
          <a href="/biograph/signup"> Đăng ký </a>
          <!-- END: nolog -->

          <!-- BEGIN: log -->
          <a href="/biograph/private"> Cá nhân </a> |
          <a href="/biograph/center"> Trang trại </a>
          <!-- END: log -->
        </div>
      </form>
    </div>
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
