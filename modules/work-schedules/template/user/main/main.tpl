<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<div id="alert_msg"></div>
<div id="loading">
  <div class="black-wag"> </div>
  <img class="loading" src="/themes/default/images/loading.gif">
</div>

<style>
  .green {
    background: lightgreen;
  }

  .red {
    background: lightpink;
  }

  .input-group-btn>button {
    height: 32px !important;
  }

  .suggest {
    z-index: 10;
  }

  .suggest-box {
    width: 100%;
    margin-bottom: 0px;
  }

  .suggest-box:hover {
    background: lightgreen;
  }
</style>

{modal}

<!-- BEGIN: manager -->
<div class="form-group">
  <div style="float: left; width: 50%;">
    <div class="form-group">
      <label> Chọn thời gian </label>
      <div class="input-group">
        <select class="form-control" id="filter-time">
          <option value="0" disabled selected> Chọn khoảng thời gian </option>
          <option value="1">Tuần này</option>
          <option value="2">Tuần sau</option>
          <option value="3">Tuần trước</option>
          <option value="4">Tháng này</option>
          <option value="5">Tháng sau</option>
          <option value="6">Tháng trước</option>
          <option value="7">Năm nay</option>
          <option value="8">Năm sau</option>
          <option value="9">Năm ngoái</option>
        </select>
        <div class="input-group-btn">
          <button class="btn btn-danger" onclick="clearDate()">
            <span class="glyphicon glyphicon-remove"></span>
          </button>
        </div>
      </div>
    </div>
    <div class="form-group rows">
      <div class="col-6">
        <label> Từ </label>
        <div class="input-group">
          <input type="text" class="form-control date" id="filter-starttime" value="{starttime}" autocomplete="off">
          <div class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
          </div>
        </div>
      </div>
      <div class="col-6">
        <label> Đến </label>
        <div class="input-group">
          <input type="text" class="form-control date" id="filter-endtime" value="{endtime}" autocomplete="off">
          <div class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
          </div>
        </div>
      </div>
    </div>

    <div class="form-group">
      <div class="relative">
        <div class="input-group">
          <input type="text" class="form-control" id="filter-user" placeholder="Chọn danh sách nhân viên" autocomplete="off">
          <div class="input-group-btn">
            <button class="btn btn-danger" onclick="clearFilterUser()">
              <span class="glyphicon glyphicon-remove"></span>
            </button>
          </div>
        </div>
        <input type="hidden" id="filter-user-val">
        <div class="suggest" id="filter-user-suggest"> </div>
      </div>

      <div id="filter-user-text"> {selected} </div>
    </div>

    <button class="btn btn-info btn-block" onclick="filterSubmit()">
      Lọc danh sách
    </button>
  </div>

  <div style="float: right;">
    <div class="form-group">
      <button class="btn btn-success" style="width: 150px;" onclick="insertModal()">
        <span class="glyphicon glyphicon-plus"></span> Thêm công việc
      </button>
    </div>
    <div class="form-group">
      <button class="btn btn-info" style="width: 150px;" onclick="managerModal()">
        Quản lý nhân viên
      </button>
    </div>
  </div>
  <div style="clear: both;"></div>
</div>
<!-- END: manager -->

<div id="content">
  {content}
</div>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vnumber-2.js"></script>
<script src="/modules/core/js/vremind-8.js"></script>
<script>
  var day = 1000 * 60 * 60 * 24
  var week = day * 7
  var month = day * 30
  var year = day * 365
  var global = {
    id: 0,
    role: JSON.parse('{role}'),
    employ: JSON.parse('{employ}'),
    user: JSON.parse('{user}'),
    depart: JSON.parse('{depart}'),
    filter: JSON.parse('{filter}'),
    today: new Date(),
  }
  var timechange = {
    1: () => {
      // tuần này
      time = global['today'].getTime()
      time = time - (global['today'].getDay() === 0 ? 6 : global['today'].getDay() - 1) * day
      return {
        start: time,
        end: time + 6 * day
      }
    },
    2: () => {
      // tuần sau
      time = global['today'].getTime() + 7 * day
      time = time - (global['today'].getDay() === 0 ? 6 : global['today'].getDay() - 1) * day
      return {
        start: time,
        end: time + 6 * day
      }
    },
    3: () => {
      // tuần trước
      time = global['today'].getTime() - 7 * day
      time = time - (global['today'].getDay() === 0 ? 6 : global['today'].getDay() - 1) * day
      return {
        start: time,
        end: time + 6 * day
      }
    },
    4: () => {
      datetime = new Date(global['today'].getTime())
      datetime.setDate(1)
      time = datetime.getTime()
      return {
        start: time,
        end: datetime.setMonth(datetime.getMonth() + 1) - day
      }
      // tháng này
    },
    5: () => {
      datetime = new Date(global['today'].getTime())
      datetime.setDate(1)
      datetime.setMonth(datetime.getMonth() + 2)
      time = datetime.getTime()
      return {
        start: time,
        end: datetime.setMonth(datetime.getMonth() + 1) - day
      }
      // tháng sau
    },
    6: () => {
      datetime = new Date(global['today'].getTime())
      datetime.setDate(1)
      datetime.setMonth(datetime.getMonth() - 1)
      time = datetime.getTime()
      return {
        start: time,
        end: datetime.setMonth(datetime.getMonth() + 1) - day
      }
      // tháng trước
    },
    7: () => {
      datetime = new Date(global['today'].getTime())
      datetime.setDate(1)
      datetime.setMonth(0)
      time = datetime.getTime()
      return {
        start: time,
        end: datetime.setYear(datetime.getFullYear() + 1)
      }
      // năm nay
    },
    8: () => {
      datetime = new Date(global['today'].getTime())
      datetime.setDate(1)
      datetime.setMonth(0)
      datetime.setYear(datetime.getFullYear() + 1)
      time = datetime.getTime()
      return {
        start: time,
        end: datetime.setYear(datetime.getFullYear() + 1)
      }
      // năm sau
    },
    9: () => {
      datetime = new Date(global['today'].getTime())
      datetime.setDate(1)
      datetime.setMonth(0)
      datetime.setYear(datetime.getFullYear() - 1)
      time = datetime.getTime()
      return {
        start: time,
        end: datetime.setYear(datetime.getFullYear() + 1)
      }
      // năm ngoái
    },
  }

  $(document).ready(() => {
    if (!Object.keys(global['filter']).length) global['filter'] = {}
    // install user select
    vremind.install('#insert-user', '#insert-user-suggest', (input) => {
      return new Promise((resolve) => {
        html = ''
        keyword = simplize(input)
        limit = 10
        global['employ'].forEach(employ => {
          if (limit && employ['alias'].search(keyword) >= 0) {
            html += `
              <div class="suggest-item" onclick="selectEmploy('filter-user-name', `+ employ['id'] + `, '` + employ['name'] + `')">
                `+ employ['name'] + `
              </div>`
          }
        });
        if (!html.length) html = 'không tìm thấy'
        resolve(html)
      })
    }, 300, 300)
    // install filter user select
    vremind.install('#filter-user', '#filter-user-suggest', (input => {
      return new Promise(resolve => {
        keyword = simplize(input)
        html = ''

        global['employ'].forEach((item, index) => {
          if (item['alias'].search(keyword) >= 0) {
            check = 0
            if (global['filter'][index]) check = 1
            html += `
              <label class="suggest-box" onclick="reloadFilterUser()">
                `+ item['name'] + `
                <input class="suggest_box" index="`+ index + `" type="checkbox" style="float: right;" ` + (check ? 'checked' : '') + `>
              </label>`
          }
        })
        if (!html.length) html = 'Không có kết quả'
        resolve(html)
      })
    }), 300, 300, 1)
    // install user insert for insert work
    vremind.install('#user-name', '#user-name-suggest', (input) => {
      return new Promise((resolve) => {
        html = ''
        keyword = simplize(input)
        limit = 10
        global['user'].forEach((user, index) => {
          if (limit && ((user['alias'].search(keyword) >= 0) || (user['username'].search(keyword) >= 0))) {
            html += `
              <div class="suggest-item" onclick="insertUserSubmit(`+ user['id'] + `, ` + index + `, 0)">
                `+ user['name'] + ` - ` + user['username'] + `
              </div>`
          }
        });
        if (!html.length) html = 'không tìm thấy'
        resolve(html)
      })
    }, 300, 300)
    // install user insert for manager
    vremind.install('#manager-name', '#manager-name-suggest', (input) => {
      return new Promise((resolve) => {
        html = ''
        keyword = simplize(input)
        limit = 10
        global['user'].forEach((user, index) => {
          if (limit && ((user['alias'].search(keyword) >= 0) || (user['username'].search(keyword) >= 0))) {
            html += `
              <div class="suggest-item" onclick="insertUserSubmit(`+ user['id'] + `, ` + index + `, 1)">
                `+ user['name'] + ` - ` + user['username'] + `
              </div>`
          }
        });
        if (!html.length) html = 'không tìm thấy'
        resolve(html)
      })
    }, 300, 300)
    // install date
    $('.date').datepicker({
      format: 'dd/mm/yyyy'
    });
    // install process parsing
    vnumber.install('insert-process', 0, 100)
    vnumber.install('report-process', 0, 100)
    // install time select
    $('#filter-time').change(e => {
      timetype = e.currentTarget.value
      if (timetype) {
        period = timechange[timetype]()
        $('#filter-starttime').val(dateToString(period['start']))
        $('#filter-endtime').val(dateToString(period['end']))
      }
    })
  })

  function clearDate() {
    $('#filter-starttime').val('')
    $('#filter-endtime').val('')
    $('#filter-time').val(0)
  }

  function selectEmploy(label, id, name) {
    $('#' + label).html(name)
    $('#' + label).attr('rel', id)
  }

  function filterSubmit() {
    list = []
    for (const key in global['filter']) {
      if (global['filter'].hasOwnProperty(key)) {
        list.push(key)
      }
    }
    data = {
      starttime: checkDate($('#filter-starttime').val()),
      endtime: checkDate($('#filter-endtime').val()),
      list: list
    }
    xtra = []
    if (data['list'].length) xtra.push('user=' + data['list'].join(','))
    if ($('#filter-starttime').val().length) {
      if (!data['starttime']) {
        alert_msg('Định dạng ngày DD/MM/YYYY')
        return 0
      }
      else xtra.push('start=' + data['starttime'])
    }
    if ($('#filter-endtime').val().length) {
      if (!data['endtime']) {
        alert_msg('Định dạng ngày DD/MM/YYYY')
        return 0
      }
      else xtra.push('end=' + data['endtime'])
    }
    window.location.replace('/' + nv_module_name + '/?' + xtra.join('&'))
  }

  function reloadFilterUser() {
    $('.suggest_box').each((index, item) => {
      itemIndex = item.getAttribute('index')
      itemCheck = item.checked
      if (itemCheck) global['filter'][itemIndex] = itemIndex
      else delete global['filter'][itemIndex]
    })
    list = []
    for (const key in global['filter']) {
      if (global['filter'].hasOwnProperty(key)) {
        list.push(global['employ'][key]['name'])
      }
    }
    $('#filter-user-text').text(list.join(', '))
  }

  function clearFilterUser() {
    global['filter'] = {}
    $('.suggest_box').prop('checked', false)
    $('#filter-user-text').text('')
  }

  function updateProcess(id, process, note, calltime) {
    global['id'] = id
    $('#report-process').val(process)
    $('#report-note').val(note)
    $('#report-calltime').val(calltime)
    $('#report-modal').modal('show')
  }

  function updateProcessSubmit() {
    freeze()
    calltime = $('#report-calltime').val()
    if (calltime.length && !checkDate(calltime)) alert_msg('Nhập hạn chót hợp lệ DD/MM/YYYY')
    else vhttp.check('', {
      action: 'update-process',
      data: {
        'id': global['id'],
        'process': $('#report-process').val(),
        'note': $('#report-note').val(),
        'calltime': checkDate(calltime)
      }
    }).then(data => {
      // thông báo
      alert_msg('Đã cập nhật công việc')
      // cập nhật 
      $('#content').html(data['html'])
      $('#report-modal').modal('hide')
      defreeze()
    }, (data) => {
      // Lỗi
      defreeze()
    })
  }

  function removeEmploy(userid) {
    freeze()
    vhttp.check('', {
      action: 'remove-employ',
      'userid': userid
    }).then(data => {
      // thông báo
      alert_msg('Đã bỏ nhân viên khỏi danh sách')
      // cập nhật 
      global['employ'] = JSON.parse(data['employ'])
      global['user'] = JSON.parse(data['user'])
      $('#manager-content').html(data['html'])
      defreeze()
    }, (data) => {
      // Lỗi
      defreeze()
    })
  }

  function setPermission(userid, role) {
    freeze()
    vhttp.check('', {
      action: 'set-permission',
      'userid': userid,
      'role': role
    }).then(data => {
      // thông báo
      alert_msg('Đã cập nhật phân quyền')
      // cập nhật 
      $('#manager-content').html(data['html'])
      defreeze()
    }, (data) => {
      // Lỗi
      defreeze()
    })
  }

  function finishWork(id) {
    freeze()
    vhttp.check('', {
      action: 'finish-work',
      'id': id
    }).then(data => {
      // thông báo
      alert_msg('Đã cập nhật công việc')
      // cập nhật 
      $('#content').html(data['html'])
      defreeze()
    }, (data) => {
      // Lỗi
      defreeze()
    })
  }

  function insertModal() {
    $('#insert-modal').modal('show')
  }

  function insertSubmit() {
    send_data = checkInsertData()
    if (typeof (send_data) === 'string') alert_msg(send_data)
    else {
      freeze()
      vhttp.check('', {
        action: 'insert',
        data: send_data
      }).then(data => {
        // xóa các trường
        $('.insert-form').val('')
        $('#insert-process').val(0)
        $('#insert-user-name').html('')
        $('#insert-user-name').attr('rel', '')
        // thông báo
        alert_msg('Đã thêm công việc')
        // cập nhật 
        $('#content').html(data['html'])
        $('#insert-modal').modal('hide')
        defreeze()
      }, (data) => {
        // Lỗi
        defreeze()
      })
    }
  }

  function checkInsertData() {
    data = {
      work: $('#insert-name').val(),
      userid: $('#insert-user-name').attr('rel'),
      starttime: $('#insert-starttime').val(),
      endtime: $('#insert-endtime').val(),
      process: $('#insert-process').val(),
      note: $('#insert-note').val(),
    }
    if (!data['work'].length) return 'Nhập nội dung công việc trước'
    if (!data['userid']) return 'Chọn Nhân viên trước'
    if (!checkDate(data['starttime'])) return 'Nhập ngày bắt đầu hợp lệ DD/MM/YYYY'
    if (!checkDate(data['endtime'])) return 'Nhập hạn cuối hợp lệ DD/MM/YYYY'
    return data
  }

  function checkDate(date) {
    try {
      dates = date.split('/')
      if (dates.length === 3) {
        datetime = new Date(dates['2'], Number(dates['1'] - 1), dates['0'])
      }
      return datetime.getTime() / 1000
    }
    catch (e) {
      return 0
    }
    return 0
  }

  function insertUser() {
    $('#user-modal').modal('show')
  }

  function managerModal() {
    $('#manager-modal').modal('show')
  }

  function insertUserSubmit(userid, userindex, manager = 0) {
    freeze()
    vhttp.check('', {
      action: 'insert-user',
      id: userid,
      manager: manager
    }).then(data => {
      // xóa các trường
      $('#user-name').val('')
      // thông báo
      alert_msg('Đã thêm nhân viên')
      // cập nhật 
      user = global['user'][userindex]
      if (manager) {
        $('#manager-content').html(data['html'])
      }
      else {
        $('#insert-user-name').html(user['name'])
        $('#insert-user-name').attr('rel', user['id'])
      }
      global['employ'].push({
        id: user['id'],
        name: user['name'],
        alias: user['alias']
      })
      global['user'] = global['user'].filter((item, index) => {
        return index !== userindex
      })
      $('#user-modal').modal('hide')
      defreeze()
    }, (data) => {
      // Lỗi
      defreeze()
    })
  }

  function dateToString(date) {
    date = new Date(date)
    var day = date.getDate()
    var month = date.getMonth()
    var year = date.getFullYear()
    if (day < 10) {
      day = "0" + day
    }
    if (month < 10) {
      month = "0" + (month + 1)
    }
    text = day + "/" + month + "/" + year
    return text
  }
</script>
<!-- END: main -->