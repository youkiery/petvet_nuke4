<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{item_modal}
<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="$('#item-modal').modal('show')">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<div class="form-group form-inline">
  Số dòng mỗi trang
  <div class="input-group">
    <input type="text" class="form-control" id="filter-limit" value="10">
    <div class="input-group-btn">
      <button class="btn btn-info" onclick="goPage(1)"> Hiển thị </button>
    </div>
  </div>
</div>
<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<button class="btn btn-info">
  edit all
</button>  
<button class="btn btn-danger">
  remove all
</button>  
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {}

  function checkItemData() {
    name = $("#item-name").val()
    unit = $("#item-unit").val()
    number = $("#item-number").val()
    status = $("#item-status").val()
    company = $("#item-company").val()
    description = $("#item-description").val()
    if (!name.length) {
      alert_msg('Tên thiết bị trống')
      return false
    }
    else {
      return {
        name: name,
        unit: unit,
        number: number > 0 ? number : 0,
        status: status,
        company: company,
        description: description
      }
    }
  }

  function itemInsertsubmit() {
    if (data = checkItemData()) {
      $.post(
        "",
        {action: 'insert-item', data: data},
        (response, status) => {
          checkResult(response, status).then(data => {
            // do nothing
            // return inserted item_id
          }, () => {})
        }
      )
    }
  }

  function checkFilter() {
    limit = $("#filter-limit").val()
    return {
      page: global['page'],
      limit: limit > 10 ? limit : 10
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      "",
      {action: 'filter', filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->