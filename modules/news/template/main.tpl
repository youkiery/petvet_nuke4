<!-- BEGIN: main -->
<div class="container">
  <div id="msgshow"></div>
  <div class="text-center">
    <a href="/news/sell" style="text-decoration: none;">
      <button class="btn">
        Bán thú cưng
      </button>
    </a> | 
    <a href="/news/buy" style="text-decoration: none;"> 
      <button class="btn" disabled>
        Mua thú cưng
      </button>
    </a> |
    <a href="/news/breeding" style="text-decoration: none;"> 
      <button class="btn" disabled>
        Phối giống
      </button>
    </a> |
    <a href="/news/farm" style="text-decoration: none;"> 
      <button class="btn" disabled>
        Trang trại
      </button>
    </a> |
    <a href="/news/doctor" style="text-decoration: none;"> 
      <button class="btn" disabled>
        Bác sĩ
      </button>
    </a>
  </div>

    <div class="text-center start-content">
      <img src="/themes/default/images/banner.png">
      <!-- <p> Nâng niu tình yêu động vật </p> -->
      <form action="/{module_file}/list">
        <div class="main-search">
          <label class="input-group">
            <input type="text" class="form-control" name="keyword" id="keyword" placeholder="Nhập tên hoặc mã số" autocomplete="off">
            <div class="input-group-btn">
              <button class="btn btn-info"> Tìm kiếm </button>
            </div>
          </label>
          <!-- BEGIN: nolog -->
          <a href="/{module_file}/login"> Đăng nhập </a> |
          <!-- END: nolog -->
          <a href="/{module_file}/private"> Cá nhân </a> | 
          <a href="/{module_file}/center"> Trang trại </a>
          <!-- <a href="/{module_file}/signup"> Đăng ký </a> -->

          <!-- BEGIN: log -->
          <!-- <a href="/{module_file}/login"> Quản lý giống </a> -->
          <!-- END: log -->
          <!-- BEGIN: log_center -->
          <!-- <a href="/{module_file}/login"> Quản lý trại </a> -->
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
