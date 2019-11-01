<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="modal" role="dialog" id="modal-checked">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <!-- BEGIN: category -->
        <div style="overflow: auto;">
          <div style="width: 75%; float: left;">
            {category}
          </div>
          <button class="btn btn-info" style="float: right;" onclick="pickCategorySubmit({id})">
            Chọn
          </button>   
        </div>
        <hr>
        <!-- END: category -->
      </div>
    </div>
  </div>

</div>

<div class="row" style="margin-bottom: 10px;">
  <div class="form-inline">
    <input type="text" class="form-control" id="insert-name" placeholder="Nhập thêm loại hàng">
    <select class="form-control" id="insert-cate">
      <option value="0"> Chưa phân loại </option>
      <!-- BEGIN: category2 -->
      <option value="{id}"> {category} </option>
      <!-- END: category2 -->
    </select>
    <button class="btn btn-success" onclick="insert()"> Thêm hàng hóa </button>
  </div>
</div>
<label class="form-inline">
  Số dòng một trang: <input type="text" class="form-control" id="filter-limit" value="10">
  <button class="btn btn-info" onclick="goPage(1)">
    Hiển thị
  </button>
</label>

<div id="msgshow"></div>

<div id="content">
  {content}
</div>
<button class="btn btn-info" onclick="pickCategory()">
  Cật nhật loại hàng
</button>

<script src="/modules/exp/src/script.js"></script>
<script>
  var global = {
    page: 1,
    id: 0
  }

  $(document).ready(() => {
    installCheckAll()
  })
  function checkFilter() {
    page = global['page']
    limit = $("#filter-limit").val()
    if (Number(page) < 0) {
      page = 1
    }
    if (Number(limit) < 10) {
      limit = 10
    }
    return {
      page: page,
      limit: limit
    }
  }

  function insert() {
    $.post(
      '',
      {action: 'insert', name: $("#insert-name").val(), cate_id: $("#insert-cate").val(), filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#insert-name").val('')
          $("#content").html(data['html'])
          installCheckAll()
        }, () => {}) 
      }
    )
  }
  function update(id) {
    $.post(
      '',
      {action: 'update', name: $("#item-" + id).val(), id: id},
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => {}) 
      }
    )
  }
  function remove(id) {
    $.post(
      '',
      {action: 'update', id: id, filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => {}) 
      }
    )
  }
  function pickCategory(id = 0) {
    if (id) {
      global['id'] = id
    }
    $("#modal-checked").modal('show')
  }
  function pickCategorySubmit(id) {
    if (!global['id']) {
      list = []
      $(".event-checkbox:checked").each((index, item) => {
        list.push(item.getAttribute('id').replace('item-check-', ''))
      })
      global['id'] = list.join(', ');
    }
    $.post(
      '',
      {action: 'pick-category', id: id, list: global['id'], filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = 0
          $('#content').html(data['html'])
          installCheckAll()
          $("#modal-checked").modal('hide')
        }, () => {}) 
      }
    )
  }

  function installCheckAll() {
    $("#item-check-all").change((e) => {
      checked = e.currentTarget.checked 
      $(".event-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }
  function goPage(page) {
    $.post(
      '',
      {action: 'filter', filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['page'] = page
          $('#content').html(data['html'])
          installCheckAll()
        }, () => {}) 
      }
    )
  }
</script>
<!-- END: main -->