<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

{notify_model}

<div class="form-group" style="float: right;">
  <button class="btn btn-danger" id="cancel-button" style="display: none;" onclick="cancelColor()">
    Hủy đăng ký
  </button>
  <button class="btn btn-success" id="submit-button" style="display: none;" onclick="registSubmit()">
    Đăng ký
  </button>
  <button class="btn btn-info" id="parse-button" onclick="parseTable()">
    Đăng ký
  </button>
</div>

<div style="clear: both;"></div>

<div id="content">
  {table}
</div>

<script>
  var global = {
    data: JSON.parse('{data}'),
    user: JSON.parse('{user}'),
    except: JSON.parse('{except}'),
    userid: '{userid}',
    time: '{today}',
    regist: false
  }

  $(document).ready(() => {
    installColor()
  })

  function cancelColor() {
    global['regist'] = false
    parseButton()
    $(".dailyrou").attr('class', 'dailyrou')
  }

  function parseButton() {
    if (global['regist']) {
      $("#parse-button").hide()
      $("#cancel-button").show()
      $("#submit-button").show()
    }
    else {
      $("#parse-button").show()
      $("#cancel-button").hide()
      $("#submit-button").hide()
    }
  }

  function installColor() {
    $(".dailyrou").click((e) => {
      current = e.currentTarget
      if (global['regist']) {
        color = current.getAttribute('class').replace('dailyrou ', '')
        switch (color) {
          case 'green':
            current.setAttribute('class', 'dailyrou blue')
          break;
          case 'blue':
            current.setAttribute('class', 'dailyrou green')
          break;
          case 'orange':
            current.setAttribute('class', 'dailyrou yellow')
          break;
          case 'yellow':
            current.setAttribute('class', 'dailyrou orange')
          break;
        }
      }
    })
  }

  function parseTable() {
    global['regist'] = !global['regist']
    parseButton()
    
    if (global['regist']) {
      $("#parse-button").hide()
      $("#cancel-button").show()
      $(".dailyrou").attr('class', 'dailyrou green')

      global['data'].forEach(item => {
        current = $("[datetime="+ item['time'] +"][court="+ item['type'] +"]")
        value = current.text()
        if (value.search(global['user'][global['userid']]) >= 0) {
          // user regiested
          current.attr('class', 'dailyrou orange')
        }
        else {
          // overflow
          registed = value.split(', ')
          global['except'].forEach(user => {
            registed = registed.filter((username) => {
              return username !== user
            })
          })
          regiestedNumber = registed.length

          if (((item['time'] < 5) && (regiestedNumber >= 2)) || ((item['time'] >= 5) && (regiestedNumber >= 1))) {
            // weektime
            current.attr('class', 'dailyrou red')
          }
        }
      });
    } 
    else {
      $(".dailyrou").attr('class', 'dailyrou')
    }
  }

  function registSubmit() {
    list = []
    a = ['blue', 'orange']
    $('.dailyrou').each((index, item) => {
      value = item.getAttribute('class').replace('dailyrou ', '')
      type = item.getAttribute('court')
      datetime = item.getAttribute('datetime')
      if (a.indexOf(value) >= 0) {
        list.push({
          time: trim($("[day="+ datetime +"]").text()),
          type: type
        })
      }
    })

    $.post(
      "",
      {action: 'insert-regist', list: list},
      (response, status) => {
        checkResult(response, status).then(data => {
          // global[]
        })
      }
    )
  }
</script>
<!-- END: main -->
