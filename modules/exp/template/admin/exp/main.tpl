<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">

<div class="row">
  <div class="col-sm-8">
    <div class="relative">
      <input type="text" class="form-control" id="insert-name" placeholder="Tìm kiếm hàng hóa">
      <div class="suggest" id="insert-name-suggest"></div>
    </div>
    <p> Đang chọn: <span id="selected-item-name"> Chưa chọn </span> </p>
    <input type="hidden" id="selected-item-id" value="">
  </div>
  <div class="col-sm-8">
    <input type="text" class="form-control" id="insert-number" value="0">
  </div>
  <div class="col-sm-8">
    <input type="text" class="form-control" id="insert-date" value="{today}">
  </div>
</div>
<div class="text-center">
  <button class="btn btn-info" onclick="insert()"> Thêm hạn sử dụng </button>
</div>

<div id="msgshow"></div>

<div id="content">
  {content}
</div>

<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var global = {
    page: 1,
    item: JSON.parse('{item}'),
    items: JSON.parse('{items}'),
    selected: {
      id: 0, name: ''
    }
  }

  $(document).ready(() => {
    installSuggest('insert-name', 'insert-name-suggest', 'selected-item-id')
    global['items'].forEach(item => {
      installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
    })
    $("#insert-date, .date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function insert() {
    id = $("#selected-item-id").val()
    if (!id) {
      alert_msg('Chưa chọn sản phẩm')
    }
    else {
      $.post(
        '',
        {action: 'insert', id: id, number: $("#insert-number").val(), date: $("#insert-date").val(), page: global['page']},
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#content").html(data['html'])
            data['list'].forEach(item => {
              installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
            })
            $(".date").datepicker({
              format: 'dd/mm/yyyy',
              changeMonth: true,
              changeYear: true
            })
          }, () => {}) 
        }
      )
    }
  }

  function update(id) {
    $.post(
      '',
      {action: 'update', name: $("#item-" + id).val(), number: $("#item-number-" + id).val(), date: $("#item-date-" + id).val(), id: id, rid: $("#item-id-" + id).val()},
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => {}) 
      }
    )
  }
  function remove(id) {
    $.post(
      '',
      {action: 'remove', id: id, page: global['page']},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
            data['list'].forEach(item => {
              installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
            })
            $(".date").datepicker({
              format: 'dd/mm/yyyy',
              changeMonth: true,
              changeYear: true
          })
        }, () => {}) 
      }
    )
  }
  function goPage(page) {
    $.post(
      '',
      {action: 'filter', page: page},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['page'] = page
          $('#content').html(data['html'])
        }, () => {}) 
      }
    )
  }
  function selectItem(id, name, input, hidden) {
    global['selected'] = {
      id: id,
      name: name
    }
    $("#" + input).val(name)
    $("#" + hidden).val(id)
    if (input == 'insert-name') $("#selected-item-name").text(name)
  }
  function installSuggest(input, suggest, hidden) {
    var inputObj = $("#" + input)
    var suggestObj = $("#" + suggest)
    inputObj.keyup(e => {
      key = convert(e.currentTarget.value)
      
      list = global['item'].filter(item => {
        return item['key'].search(key) >= 0
      })
      html = ''
      if (list.length) {
        list.forEach(item => {
          html += `
            <div class="suggest-item" onclick="selectItem(`+ item['id'] +`, '`+ item['name'] +`', '`+ input +`', '`+ hidden +`')">
              `+ item['name'] +`
            </div>
          `
        })
      }
      else {
        html = 'Không có kết quả'
      }
      suggestObj.html(html)
    })
    inputObj.focus(() => {
      suggestObj.show()
    })
    inputObj.blur(() => {
      setTimeout(() => {
        suggestObj.hide()
      }, 200);
    })
  }
</script>
<!-- END: main -->