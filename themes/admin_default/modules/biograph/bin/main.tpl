<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<h1> Quản lý chip </h1>

<form method="GET">
  <label>
    Tên khách hàng
    <div class="input-group">
      <input type="text" name="customer" id="bio-custom" class="form-control" autocomplete="off">
      <div class="suggest" id="bio-custom-suggest"></div>
    </div>
  </label>
</form>

<script>
  var data = {
    prefix: "bio",
    inputList: {
      custom: {
        name: "custom",
        remind: "custom",
        input: $("#bio-custom"),
        suggest: $("#bio-custom-suggest")
      }
    }
  }
  var insert = {}
  var remind = JSON.parse('{remind}')

  $(this).ready(() => {
    installRemindv2(data['prefix'], data['inputList']['name'], data['inputList']['remind'])
    installFilter('main-onwer', 'custom', filterCustom, {})
  })

  function installFilter(name, type, proc, timebysec = 100, param = {}) {
    var timeout
    var input = $("#"+ type + "-" + name)
    var suggest = $("#"+ type + "-suggest-" + name)

    input.keyup(() => {
      clearTimeout(timeout)
      setTimeout(() => {
        proc(param)
      }, timebysec)
    })
  }

  function installRemindv2(prefix, name, type) {
    var timeout
    var input = $("#"+ type + "-" + name)
    var suggest = $("#"+ type + name)
    
    input.keyup(() => {
      clearTimeout(timeout)
      setTimeout(() => {
        var key = paintext(input.val())
        var html = ''
        for (const index in remindv2[type]) {
          if (remindv2[type].hasOwnProperty(index)) {
            const element = paintext(remindv2[type][index]['name']);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest_item" onclick="selectRemindv2(\'' + name + '\', \'' + type + '\', \'' + remindv2[type][index]['name'] + '\')"><p class="right-click">' + remindv2[type][index]['name'] + '</p><button class="close right" data-dismiss="modal" onclick="removeRemindv2(\'' + name + '\', \'' + type + '\', ' + remindv2[type][index]['id']+')">&times;</button></div>'
            }
          }
        }
        suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 200);
    })
  }

  function removeRemindv2(name, type) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeRemindv2', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            remindv2 = JSON.parse(data['remind'])
            $("#"+ type +"-" + name).val('')
          }, () => {})
        }
      )
    }
  }

  function selectRemindv2(name, type, value) {
    $("#"+ type +"-" + name).val(value)
  }
</script>

<!-- END: main -->