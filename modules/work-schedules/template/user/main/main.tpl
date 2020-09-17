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
    background: pink;
  }

  .input-group-btn > button {
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

<div class="form-group">
  <div style="float: left;">
    <button class="btn btn-info" onclick="filterModal()">
      Lọc công việc
    </button>
  </div>
  
  <div style="float: right;">
    <!-- BEGIN: manager -->
    <button class="btn btn-info" onclick="insertModal()">
      Thêm công việc
    </button>
    <!-- END: manager -->
  </div>
  <div style="clear: both;"></div>
</div>


<div id="content">
  {content}
</div>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vnumber-2.js"></script>
<script src="/modules/core/js/vremind-7.js"></script>
<script>
  // var dbdata = JSON.parse('{data}')
  // var today = '{today}'
  // var userid = -1
  // var g_id = -1
  // var g_departid = 0
  // var x_depart = '{g_depart}'
  // var current = 0
  // var typing
  // var complete = $(".complete")
  // var count = $("#count")
  // var content = $("#content")
  // var nav = $("#nav")
  // var completeStatus = 0
  // var page = {page}
  // var limit = {limit}

  var global = {
    role: JSON.parse('{role}'),
    employ: JSON.parse('{employ}'),
    user: JSON.parse('{user}'),
    depart: JSON.parse('{depart}'),
    filter: JSON.parse('{filter}')
  }

  $(document).ready(() => {
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
    // install user insert
    vremind.install('#user-name', '#user-name-suggest', (input) => {
      return new Promise((resolve) => {
        html = ''
        keyword = simplize(input)
        limit = 10
        global['user'].forEach((user, index) => {
          if (limit && ((user['alias'].search(keyword) >= 0) || (user['username'].search(keyword) >= 0))) {
            html += `
              <div class="suggest-item" onclick="insertUserSubmit(`+ user['id'] + `, ` + index + `)">
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
  })

  function selectEmploy(label, id, name) {
    $('#' + label).html(name)
    $('#' + label).attr('rel', id)
  }

  function filterSubmit() {
    list = []
    for (const key in global['filter']) {
      if (global['filter'].hasOwnProperty(key)) {
        const item = global['filter'][key];
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

  function filterModal() {
    $('#filter-modal').modal('show')
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

  function insertUserSubmit(userid, userindex) {
    freeze()
    vhttp.check('', {
      action: 'insert-user',
      id: userid
    }).then(data => {
      // xóa các trường
      $('#user-name').val('')
      // thông báo
      alert_msg('Đã thêm nhân viên')
      // cập nhật 
      user = global['user'][userindex]
      $('#insert-user-name').html(user['name'])
      $('#insert-user-name').attr('rel', user['id'])
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

  // $("#depart, #edit_depart").change((e) => {
  //   var current = e.currentTarget
  //   x_depart = current.value
  //   $(".user-suggest-list").html("")
  // })

  // complete.click((e) => {
  //   var currentTarget = e.currentTarget
  //   complete.removeClass("active")
  //   complete.removeClass("btn-warning")

  //   currentTarget.classList.add("active")
  //   currentTarget.classList.add("btn-warning")

  //   if (trim(currentTarget.innerHTML).length > 12) {
  //     completeStatus = 0
  //   }
  //   else {
  //     completeStatus = 1
  //   }

  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "change_data", page: page, limit: limit, completeStatus: completeStatus, departid: g_departid, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         change_tab(g_departid)
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // })

  // $('#starttime, #endtime, #edit_starttime, #edit_endtime, #starttime-filter, #endtime-filter, #cometime, #calltime').datepicker({
  //   format: 'dd/mm/yyyy'
  // });

  // $("#user, #edit_user").focus(() => {
  //   $(".user-suggest-list").show()
  // });
  // $("#user, #edit_user").blur(() => {
  //   setTimeout(() => {
  //     $(".user-suggest-list").hide()
  //   }, 200)
  // });

  // $("#user, #edit_user").keydown(e => {
  //   clearTimeout(typing)
  //   typing = setTimeout(() => {
  //     var stora = dbdata[x_depart]
  //     var keyword = e.currentTarget.value
  //     var html = "";
  //     var count = 0;
  //     stora.forEach(user => {
  //       if (count > 9) {
  //         stora = []
  //       }
  //       if (user["name"].search(keyword) >= 0) {
  //         html += '<div class="user-suggest-item" onclick="set_user('+user['userid']+', \''+user['name']+'\')"> '+user['name']+' </div>'
  //         count ++
  //       }
  //     });

  //     $(".user-suggest-list").html(html)
  //     // $.post(
  //     //   strHref,
  //     //   {action: "search", keyword: e.target.value},
  //     //   (response, status) => {
  //     //     if (status === "success" && response) {
  //     //       try {
  //     //         var data = JSON.parse(response)
  //     //         if (data["status"]) {
  //     //           $(".user-suggest-list").html(data["list"])
  //     //         }
  //     //         alert_msg(data["notify"])
  //     //       } catch (e) {
  //     //         alert_msg("{lang.g_error}")
  //     //       }
  //     //     }
  //     //   }
  //     // )      
  //   }, 200)
  // })

  // function set_user(id, name) {
  //   userid = id
  //   $("#user, #edit_user").val(name)
  // }

  // function change_process_submit(e) {
  //   e.preventDefault()
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "change_process", page: page, limit: limit, completeStatus: completeStatus, departid: g_departid, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), process: $("#edit_process2").val().replace("%", ""), note: $("#edit_note").val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         $("#process_change").modal("hide")
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )    
  // }

  // function change_process(id) {
  //   g_id = id
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "get_process", id: g_id},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         current = data["process"]
  //         $("#edit_process2").val(data["process"] + "%")
  //         $("#edit_note2").val(data["note"])
  //         $("#process_change").modal("show")
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // function change_data_2(e) {
  //   e.preventDefault()
  //   change_data(g_departid)
  // }

  // function change_data(id) {
  //   g_departid = id
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "change_data", page: page, limit: limit, completeStatus: completeStatus, departid: g_departid, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         change_tab(id)
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // function change_confirm(id) {
  //   g_id = id
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "change_confirm", id: g_id},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         $("#change_confirm").modal("show")
  //         $("#confirm_value").html(data["confirm"])
  //         $("#confirm_review").html(data["review"])
  //         $("#confirm_note").val(data["note"])
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // function change_confirm_submit(e) {
  //   e.preventDefault()
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "confirm", page: page, limit: limit, completeStatus: completeStatus, departid: g_departid, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), confirm: $("#confirm_value").val(), review: $("#confirm_review").val(), note: $("#confirm_note").val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         $("#change_confirm").modal("hide")
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // $("#edit_process, #edit_process2, #process").keyup((e) => {
  //   var key = e.currentTarget.value.replace("%", "")
  //   var check = isFinite(key)
  //   if (check && key >= 0 && key <= 100) {
  //     current = key
  //   }
  //   e.currentTarget.value = current + "%"
  // })


  // function edit(id) {
  //   g_id = id
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "get_work", id: g_id},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         $("#edit_name").val(data["content"])
  //         $("#edit_starttime").val(data["starttime"])
  //         $("#edit_endtime").val(data["endtime"])
  //         // $("#edit_customer").html(data["customer"])
  //         $("#edit_depart").html(data["depart"])
  //         $("#edit_user").val(data["user"])
  //         userid = data["userid"]
  //         $("#edit_note").html(data["note"])
  //         $("#edit_save_user").val(data["username"])
  //         $("#edit_process").val(data["process"] + "%")
  //         userid = data["userid"]
  //         $("#edit").modal("show")
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // function insert(e) {
  //   e.preventDefault()
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "insert", page: page, limit: limit, completeStatus: completeStatus, departid: g_departid, cometime: $("#cometime").val(), calltime: $("#calltime").val(), content: $("#name").val(), starttime: $("#starttime").val(), endtime: $("#endtime").val(), /*customer: $("#customer").val(),*/ userid: userid, depart: $("#depart").val(), process: $("#process").val().replace("%", "")},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         $("#insert").modal("hide")
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // function edit_submit(e) {
  //   e.preventDefault()
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "edit", page: page, limit: limit, completeStatus: completeStatus, departid: g_departid, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), content: $("#edit_name").val(), starttime: $("#edit_starttime").val(), endtime: $("#edit_endtime").val(), /*customer: $("#edit_customer").val(),*/ userid: userid, depart: $("#edit_depart").val(), note: $("#edit_note").val(), process: $("#edit_process").val().replace("%", "")},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         $("#edit").modal("hide")
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }

  // function reload_date(data) {
  //   if (data["cometime"]) {
  //     $("#cometime").val(data["cometime"])
  //   }
  //   if (data["calltime"]) {
  //     $("#calltime").val(data["calltime"])
  //   }
  //   $("#count").text(data["count"])
  // }

  // function change_tab(id) {
  //   $(".depart").removeClass("active")
  //   $(".depart").removeClass("btn-info")
  //   $("#depart_" + id).addClass("active")
  //   $("#depart_" + id).addClass("btn-info")
  // }

  // function goPage(pPage) {
  //   freeze()
  //   $.post(
  //     strHref,
  //     {action: "change_data", page: pPage, limit: limit, completeStatus: completeStatus, departid: g_departid, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), confirm: $("#confirm_value").val(), review: $("#confirm_review").val(), note: $("#confirm_note").val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         page = pPage
  //         $("#change_confirm").modal("hide")
  //         content.html(data["list"]["html"])
  //         count.text(data["list"]["count"])
  //         nav.html(data["list"]["nav"])
  //         reload_date(data)
  //         defreeze()
  //       }, () => {
  //         defreeze()
  //       })
  //     }
  //   )
  // }
</script>
<!-- END: main -->