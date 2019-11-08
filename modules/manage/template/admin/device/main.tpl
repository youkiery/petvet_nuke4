<!-- BEGIN: main -->
<link href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{item_modal}
<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="$('#item-modal').modal('show')">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {}

  function checkItemData() {
    name = $("#item-name").val()
    unit = $("#item-unit").val()
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
</script>
<!-- END: main -->