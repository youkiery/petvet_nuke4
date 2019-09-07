<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<style>
  .cell-center {
    vertical-align: inherit !important;
  }
</style>

<div class="modal" id="user-buy" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>

        <label class="row">
          <div class="col-sm-6">
            Loài
          </div>
          <div class="col-sm-18" style="text-align: right;">
            <input type="text" class="form-control" id="species-buy">
            <div class="suggest" id="species-suggest-buy" style="text-align: left;"></div>
          </div>
        </label>

        <label class="row">
          <div class="col-sm-6">
            Giống
          </div>
          <div class="col-sm-18" style="text-align: right;">
            <input type="text" class="form-control" id="breed-buy">
            <div class="suggest" id="breed-suggest-buy" style="text-align: left;"></div>
          </div>
        </label>

        <label class="row">
          <div class="col-sm-6">
            Giới tính
          </div>
          <div class="col-sm-18">
            <label>
              <input type="radio" name="sex4" id="buy-sex-0" checked> Đực
            </label>
            <label>
              <input type="radio" name="sex4" id="buy-sex-1"> Cái
            </label>
          </div>
        </label>

        <label class="row">
          <div class="col-sm-6">
            Tuổi
          </div>
          <div class="col-sm-18">
            <input type="number" class="form-control" id="buy-age">
          </div>
        </label>

        <div id="buy-error" style="color: red; font-weight: bold;"></div>

        <div class="text-center">
          <button class="btn btn-info" onclick="buySubmit()">
            Thêm cần mua
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="content">
  {content}
</div>

<script>
  var content = $("#content")
  var keyword = $("#keyword")
  var limit = $("#limit")
  var atime = $("#atime")
  var ztime = $("#ztime")
  var cstatus = $(".status")
  var global = {
    page: 1
  }

  function splipper(text, part) {
    var pos = text.search(part + '-')
    var overleft = text.slice(pos)
    if (number = overleft.search(' ') >= 0) {
      overleft = overleft.slice(0, number)
    }
    var tick = overleft.lastIndexOf('-')
    var result = overleft.slice(tick + 1, overleft.length)

    return result
  }

  function checkFilter() {
    var temp = cstatus.filter((index, item) => {
      return item.checked
    })
    var value = 0
    if (temp[0]) {
      value = splipper(temp[0].getAttribute('id'), 'user-status')
    }
    return {
      page: global['page'],
      limit: 10,
    }
  }

  function filter(e) {
    e.preventDefault()
    goPage(1)
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      strHref,
      { action: 'gopage', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { })
      }
    )
  }

  function check(id) {
    $.post(
      strHref,
      { action: 'check', id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { })
      }
    )
  }

  function uncheck(id) {
    $.post(
      strHref,
      { action: 'uncheck', id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { })
      }
    )
  }

  function remove(id) {
    $.post(
      strHref,
      { action: 'remove', id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { })
      }
    )
  } 

  function edit(id) {
    global['id'] = id
    $.post(
      global['url'],
      {action: 'get-buy', id: global['id']},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#species-buy").val(data['data']['species'])
          $("#breed-buy").val(data['data']['breed'])
          $("#buy-sex-" + data['data']['sex']).prop('checked', true)
          $("#buy-age").val(data['data']['age'])
          $("#user-buy").modal('show')
        }, () => {})
      }
    )    
  }

  function checkBuyData() {
    var sex0 = $("#buy-sex-0").prop('checked'), sex1 = $("#buy-sex-1").prop('checked')
    return {
      species: $("#species-buy").val(),
      breed: $("#breed-buy").val(),
      sex: (sex0 ? 1 : 2),
      age: $("#buy-age").val()
    }
  }

  function buySubmit() {
    data = checkBuyData()
    if (Number(data['age']) == NaN || data['age'] < 0) {
      data['age'] = 0
    }
    if (!data['species'].length || !data['breed'].length || !data['age'].length) {
      $("#buy-error").text('Các trường không được để trống')
    }
    else {
      freeze()
      $.post(
        global['url'],
        {action: 'buy', data: data, id: global['id'], filter: checkFilter()},
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#user-buy").modal('hide')
          }, () => {})
        }
      )    
    }
  }
</script>
<!-- END: main -->