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

<div class="row">
  <div class="col-sm-12 col-md-9">
    <div class="input-group">
      <input type="text" class="form-control" id="insert-name" placeholder="Nhập thêm loại hàng">
      <div class="input-group-btn">
        <button class="btn btn-info" onclick="insert()"> <span class="glyphicon glyphicon-floppy-disk"></span> </button>
      </div>
    </div>
  </div>
</div>

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

  function insert() {
    $.post(
      '',
      {action: 'insert', name: $("#insert-name").val(), page: global['page']},
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
      {action: 'update', id: id, page: global['page']},
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
      {action: 'pick-category', id: id, list: global['id']},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = 0
          $('#content').html(data['html'])
          installCheckAll()
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
      {action: 'filter', page: page},
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