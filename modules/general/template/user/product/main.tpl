<!-- BEGIN: main -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css">

<script src="/modules/core/js/vhttp.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/shim.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.full.min.js"></script>

<style>
  .error {
    color: red;
    font-size: 1.2em;
    font-weight: bold;
  }

  a.btn-default {
    color: #444
  }

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-1,
  .col-2,
  .col-3,
  .col-4,
  .col-5,
  .col-6,
  .col-7,
  .col-8,
  .col-9,
  .col-10,
  .col-11,
  .col-12 {
    float: left;
  }

  .col-1 {
    width: 8.33%;
  }

  .col-2 {
    width: 16.66%;
  }

  .col-3 {
    width: 25%;
  }

  .col-4 {
    width: 33.33%;
  }

  .col-5 {
    width: 41.66%;
  }

  .col-6 {
    width: 50%;
  }

  .col-7 {
    width: 58.33%;
  }

  .col-8 {
    width: 66.66%;
  }

  .col-9 {
    width: 75%;
  }

  .col-10 {
    width: 83.33%;
  }

  .col-11 {
    width: 91.66%;
  }

  .col-12 {
    width: 100%;
  }
</style>

<div id="msgshow"></div>

{modal}

<form class="form-group rows">
  <input type="hidden" name="nv" value="{nv}">
  <input type="hidden" name="op" value="{op}">
  <div class="col-3">
    <input type="text" class="form-control" name="keyword" value="{keyword}"
      placeholder="Tìm kiếm theo tên hàng, mã hàng,...">
  </div>
  <div class="col-3">
    <select class="form-control" name="limit">
      <option value="10" {check10}> 10 </option>
      <option value="20" {check20}> 20 </option>
      <option value="50" {check50}> 50 </option>
      <option value="100" {check100}> 100 </option>
      <option value="200" {check200}> 200 </option>
    </select>
  </div>
  <div class="col-3">
    <button class="btn btn-info">
      Tìm kiếm
    </button>
  </div>
  <div class="col-3" style="text-align: right;">
    <button class="btn btn-info" onclick="$('#statistic-modal').modal('show')">
      Thống kê
    </button>
  </div>
</form>

<div class="form-group rows">
  <div class="relative col-6">
    <input type="text" class="form-control" id="product-insert-input" placeholder="Thêm mặt hàng">
    <div class="suggest" id="product-insert-input-suggest"></div>
  </div>
  <div class="col-3">
    <input type="text" class="form-control" id="product-insert-input-low" placeholder="Giới hạn">
  </div>
  <div class="col-3" style="text-align: right;">
    <button class="btn btn-info" onclick="$('#insert-modal').modal('show')">
      Cập nhật Excel
    </button>
  </div>
</div>

<!-- <div class="form-group row">
    <div class="col-sm-12">
        <button class="btn btn-info" onclick="$('#insert-modal').modal('show')">
            Thêm mã
        </button>
        <button class="btn btn-info" onclick="$('#category-modal').modal('show')">
            Sửa loại hàng
        </button>
    </div>
    <div class="col-sm-12">
        <div style="float: right;">
            <button class="btn btn-danger" onclick="removeItem()">
                Xóa mã
            </button>
        </div>
    </div>
</div> -->

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vremind-5.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    page: 1,
    limit: 100,
    file: {},
    list: JSON.parse('{list}'),
    data: [],
    // allow: ['SHOP', 'SHOP>>Balo, giỏ xách', 'SHOP>>Bình xịt', 'SHOP>>Cát vệ sinh', 'SHOP>>Dầu tắm', 'SHOP>>Đồ chơi', 'SHOP>>Đồ chơi - vật dụng', 'SHOP>>Giỏ-nệm-ổ', 'SHOP>>Khay vệ sinh', 'SHOP>>Nhà, chuồng', 'SHOP>>Thuốc bán', 'SHOP>>Thuốc bán>>thuốc sát trung', 'SHOP>>Tô - chén', 'SHOP>>Vòng-cổ-khớp', 'SHOP>>Xích-dắt-yếm']
    allow: ["SHOP", "SHOP>>Balo, giỏ xách", "SHOP>>Bình xịt", "SHOP>>Cát vệ sinh", "SHOP>>Dầu tắm", "SHOP>>Đồ chơi", "SHOP>>Đồ chơi - vật dụng", "SHOP>>Giỏ-nệm-ổ", "SHOP>>Khay vệ sinh", "SHOP>>Nhà, chuồng", "SHOP>>Thức ăn", "SHOP>>Thuốc bán", "SHOP>>Thuốc bán>>thuốc sát trung", "SHOP>>Tô - chén", "SHOP>>Vòng-cổ-khớp", "SHOP>>Xích-dắt-yếm"]
  }

  $(document).ready(() => {
    $("#insert-box-content").hide()
    vremind.install('#product-insert-input', '#product-insert-input-suggest', (input) => {
      return new Promise((resolve) => {
        vhttp.checkelse('', { action: 'product-suggest', keyword: input }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 500)
    installFile('insert')
    installCheckbox('product')
  })

  function insertProduct(id) {
    vhttp.checkelse('', { action: 'insert-product', keyword: $("#product-insert-input").val(), id: id, low: $("#product-insert-low").val() }).then(data => {
      $('#content').html(data['html'])
      $('#product-insert-input-suggest').html(data['html2'])
    })
  }

  function installFile(name) {
    global['file'][name] = {
      input: $("#" + name + "-file"),
      selected: null
    }
    global['file'][name]['input'].change((e) => {
      global['file'][name]['selected'] = e
    })
  }

  function process(name) {
    $("#" + name + "-notify").text('Đang xử lý')

    if (!global['file'][name]['selected']) alert_msg('Chọn file excel trước')
    else processExcel(name)
  }

  function processExcel(name) {
    var reader = new FileReader();
    var rABS = !!reader.readAsBinaryString;
    var file = global['file'][name]['selected'].currentTarget.files[0]
    if (rABS) reader.readAsBinaryString(file);
    else reader.readAsArrayBuffer(file);

    reader.onload = (e) => {
      try {
        var data = e.target.result;
        if (!rABS) data = new Uint8Array(data);
        var wb = XLSX.read(data, { type: rABS ? 'binary' : 'array' });
        var object = XLSX.utils.sheet_to_row_object_array(wb.Sheets[wb.SheetNames[0]])
        console.log(object);
        $("#" + name + "-notify").hide()
        global['data'] = []
        global['file'][name]['selected'] = null

        object.forEach((item, index) => {
          // global['list']
          code = item['Mã hàng']
          category = item['Nhóm hàng(3 Cấp)']
          if (global['allow'].indexOf(category) >= 0 && !global['list'][code]) {
            global['data'].push({
              code: code,
              name: item['Tên hàng'],
              number: item['Tồn kho'],
              image: item['Hình ảnh (url1,url2...)'],
              price: item['Giá bán']
            })
          }
        })
        $("#" + name + "-content").html(goPage(name, 1))
        installCheckbox(name)
        $("#" + name + "-box-content").show()
        $("#" + name + "-box").hide()
      } catch (error) {
        $("#" + name + "-notify").text('Có lỗi xảy ra')
      }
    }
  }

  function insertSubmit() {
    data = []
    list = []
    $(".check-insert:checked").each((index, item) => {
      val = item.getAttribute('rel')
      data.push(global['data'][val])
      list.push(val)
    })

    vhttp.checkelse('', { action: 'insert', data: data }).then(data => {
      // xóa data list trong global[data]
      global['data'] = global['data'].filter((item, index) => {
        return list.indexOf(index.toString()) < 0 // giữ lại những index không có trong list
      })

      goPage2('insert', global['page'])
      installCheckbox('insert')
    })
  }

  function editProduct(id) {
    vhttp.checkelse('', { action: 'get-product', id: id }).then(data => {
      global['id'] = id
      $("#product-code").text(data['code'])
      $("#product-name").text(data['name'])
      $("#product-low").val(data['low'])
      if (!data['tag'].length) global['tag'] = []
      else global['tag'] = data['tag']
      parseTag()
      $("#product-modal").modal('show')
    })
  }

  function parseTag() {
    html = ''
    global['tag'].forEach((item, index) => {
      html += `
          <button class="btn btn-info btn-xs" onclick="removeTag(`+ index + `)">
            `+ item + `
          </button>`
    });
    $("#product-tag-list").html(html)
  }

  function insertTag() {
    tag = trim($("#product-tag").val())
    if (tag.length) {
      // kiểm tra có phải danh sách không
      list = tag.split(', ')
      if (list.length > 1) {
        list.forEach(item => {
          if (checkTag(item)) global['tag'].push(item)
        })
      }
      else if (checkTag(item)) global['tag'].push(item)
      $("#product-tag").val('')
      parseTag()
    }
  }

  function editProductSubmit() {
    vhttp.checkelse('', { action: 'edit-product', id: global['id'], low: $("#product-low").val(), tag: global['tag'] }).then(data => {
      $("#product-modal").modal('hide')
    })
  }

  function checkTag(name) {
    global['tag'].forEach((item) => {
      if (item == name) return false
    })
    return true
  }

  function removeTag(id) {
    global['tag'] = global['tag'].filter((item, index) => {
      return index !== id
    })
    parseTag()
  }

  function statisticContent() {
    vhttp.checkelse('', { action: 'statistic', tag: trim($("#statistic-tag").val()).split(', '), keyword: $("#statistic-keyword").val() }).then(data => {
      $("#statistic-content").html(data['html'])
    })
  }

  function checkSelectedItem() {
    list = []
    $(".check-product:checked").each((index, item) => {
      val = item.getAttribute('rel')
      list.push(val)
    })
    return list
  }

  function removeItem() {
    list = checkSelectedItem()

    vhttp.checkelse('', { action: 'remove', list: list }).then(data => {
      $("#content").html(data['html'])
      installCheckbox('product')
    })
  }

  function changeCategory() {
    list = checkSelectedItem()
    vhttp.checkelse('', { action: 'change-category', list: list, category: $("#category-type").val() }).then(data => {
      $("#category-modal").modal('hide')
      $("#content").html(data['html'])
      installCheckbox('product')
    })
  }

  function clear(name) {
    $("#" + name + "-content").hide()
    $("#" + name + "-box").show()
  }

  function goPage(name, page) {
    global['page'] = page
    from = (global['page'] - 1) * global['limit'] + 1
    end = from + global['limit']
    temp = ''
    for (i = from; i < end; i++) {
      item = global['data'][i];
      if (item) {
        temp += `
                <tr>
                    <td> `+ i + ` </td>
                    <td> <input type="checkbox" class="check-insert" rel="`+ i + `"> </td>
                    <td> `+ item['code'] + ` </td>
                    <td> `+ item['name'] + ` </td>
                </tr>`
      }
    }
    nav = ''
    page = global['data'].length / global['limit'] + (global['data'].length % global['limit'] ? 1 : 0)
    for (i = 1; i <= page; i++) {
      if (i == global['page']) {
        nav += `<button class="btn btn-info"> ` + i + ` </button>`
      }
      else {
        nav += `<button class="btn btn-default" onclick="goPage2('` + name + `', ` + i + `)"> ` + i + ` </button>`
      }
    }

    return `
        <table class="table table-bordered table-hover">
            <tr>
                <th> STT </th>
                <th> <input type="checkbox" class="check-insert-all"> </th>
                <th> Mã hàng </th>
                <th> Tên hàng </th>
            </tr>
            `+ temp + `
        </table>` + nav
  }

  function goPage2(name, page) {
    $("#" + name + "-content").html(goPage(name, page))
    installCheckbox(name)
  }

  function installCheckbox(name) {
    $(".check-" + name + "-all").change((e) => {
      $(".check-" + name).prop('checked', e.currentTarget.checked)
    })
  }

  function errorText(id, text) {
    $("#" + id).text(text)
    $("#" + id).show()
    $("#" + id).fadeOut(2000)
  }
</script>
<!-- END: main -->