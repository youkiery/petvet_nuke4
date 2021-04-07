<!-- BEGIN: main -->
<div class="form-group">
    <ul class="nav nav-tabs">
        <li><a href="/{nv}/product"> Quản lý sản phẩm </a></li>
        <li><a href="/{nv}/product?sub=tag"> Quản lý tag </a></li>
        <li><a href="/{nv}/product?sub=expire"> Quản lý hạn sử dụng </a></li>
        <li class="active"><a href="/{nv}/product?sub=location"> Tìm kiếm vị trí </a></li>
    </ul>
</div>

<div class="form-group">
  <input type="text" class="form-control" id="search" placeholder="Tìm kiếm sản phẩm">
</div>

<div id="content"></div>

<script>
  var global = {}
  $(document).ready(() => {
    try {
      global['item'] = JSON('{item}')
    }
    catch (e) {
      global['item'] = []
    }

    global['prev'] = null
    $('#search').keyup((e) => {
      timeout = setTimeout(() => {
        value = e.currentTarget.value
        if (global[''])
        
      }, 500);
    })
  })
</script>
<!-- END: main -->