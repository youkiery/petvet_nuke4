<!-- BEGIN: main -->
<div class="container">
    <div class="text-center start-content">
      <img src="/modules/news/src/banner.png">
      <!-- <p> Nâng niu tình yêu động vật </p> -->
      <form action="/list">
        <div style="width: 60%; margin: auto;">
          <label class="input-group">
            <input type="text" class="form-control" name="keyword" id="keyword" placeholder="Nhập tên hoặc mã số" autocomplete="off">
            <div class="input-group-btn">
              <button class="btn btn-info" onclick="search()"> Tìm kiếm </button>
            </div>
          </label>
          <!-- BEGIN: nolog -->
          <a href="/biograph/login"> Đăng nhập </a> |
          <!-- END: nolog -->
          <a href="/biograph/private"> Cá nhân </a> | 
          <a href="/biograph/center"> Trang trại </a>
          <!-- <a href="/biograph/signup"> Đăng ký </a> -->

          <!-- BEGIN: log -->
          <!-- <a href="/biograph/login"> Quản lý giống </a> -->
          <!-- END: log -->
          <!-- BEGIN: log_center -->
          <!-- <a href="/biograph/login"> Quản lý trại </a> -->
          <!-- END: log_center -->
        </div>
      </form>
    </div>
</div>
<script>
  var content = $("#content")
  var keyword = $("#keyword")
  var thisUrl = '/main'

  // function search() {
  //   request(thisUrl,
  //     {action: 'search', keyword: keyword.val()}).then(data => {
  //       content.data['html']
  //     })
  // }
</script>
<!-- END: main -->
