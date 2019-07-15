<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="summary" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bản thống kê ngày nghỉ tháng </h2>
        <br>
        <div class="form-inline">
          <div class="form-group">
            <label>
              Từ ngày
            </label>
            <input type="text" class="form-control" id="summary-date-from" value="{startDate}" autocomplete="off">
          </div>
          <div class="form-group">
            <label>
              Đến ngày
            </label>
            <input type="text" class="form-control" id="summary-date-end" value="{endDate}" autocomplete="off">
          </div>
          <button class="btn btn-info" onclick="summarySubmit()">
            Xem tổng kết
          </button>
        </div>
        <div id="summary-content">
          {summary}
        </div>
        <div class="text-center">
          <button class="btn btn-danger" data-dismiss="modal">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="regist_confirm" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bạn có muốn đăng ký những ngày này không? </h2>
        <div id="regist_list">

        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="registSubmit()">
            Đăng ký
          </button>
          <button class="btn btn-danger" data-dismiss="modal">
            Hủy
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="wconfirm_alert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bạn có muốn Thay đổi những mục này không? </h2>
        <div id="wconfirm_alert_content">

        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="wconfirmSubmit()">
            Xác nhận
          </button>
          <button class="btn btn-danger" data-dismiss="modal">
            Hủy
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- BEGIN: tab -->
  <button rel="1" class="tab btn btn-info active">
    Người dùng
  </button>
  <button rel="2" class="tab btn">
    Quản lý
  </button>
<!-- END: tab -->
<div class="row">
  <div class="col-sm-4">
    <input class="form-control" id="start-date" type="text" value="{this_week}" autocomplete="off">
  </div>
  <div class="col-sm-4">
    <button class="btn btn-warning" onclick="prevWeek()">
      <span class="glyphicon glyphicon-chevron-left"></span>
    </button>
    <button class="btn btn-warning" onclick="nextWeek()">
      <span class="glyphicon glyphicon-chevron-right"></span>
    </button>
    <!-- <select class="form-control" id="date-type"> -->
      <!-- BEGIN: date_option -->
      <!-- <option value="{date_value}"> {date_name} </option> -->
      <!-- END: date_option -->
    <!-- </select> -->
  </div>
  <div class="col-sm-8">

  </div>
  <div class="col-sm-8">
    <!-- BEGIN: manager -->
    <button class="btn btn-info right" onclick="showSummary()">
      Tổng kết
    </button>
    <!-- END: manager -->
    <button class="btn btn-info right" id="register">
      Đăng ký
    </button>
    <button class="btn btn-success right" id="cconfirm" style="display: none;">
      Xác nhận
    </button>
    <button class="btn btn-success right" id="dconfirm" style="display: none;">
      Xác nhận
    </button>
    <button class="btn btn-danger right" id="reset" style="display: none;">
      Hủy
    </button>
    <button class="btn btn-info right" id="print" onclick="printer()">
      In
    </button>
  </div>
</div>
<!-- BEGIN: doctor -->
<div>
  {doctor}
</div>
<!-- END: doctor -->
<div id="content">
  {content}
</div>
<div>
  <div style="width: 20px; height: 20px; display: inline-block; background: gray;"> </div> Quá hạn đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: green;"></div> Có thể đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: red;"> </div> Không thể đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: orange;"></div> Có thể bỏ đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: purple;"></div> Bỏ đắng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: blue;"></div> Đăng ký <br>
</div>
<script>
  var today = new Date('{date}').setHours(0)
  var dbdata = JSON.parse('{data}')
  var userdb = JSON.parse('{position}')
  var except = JSON.parse('{except}')
  var user_position = '{user_position}'
  var schedule = dbdata.length
  var username = trim('{username}');
  var startDate = $("#start-date")
  var dateType = $("#date-type")
  var register = $("#register")
  var cconfirm = $("#cconfirm")
  var reset = $("#reset")
  var doctor = $("#doctor")
  // var list = $("#list")
  var content = $("#content")
  var registConfirm = $("#regist_confirm")
  var registList = $("#regist_list")
  var dconfirm = $("#dconfirm")
  var wconfirmAlert = $("#wconfirm_alert")
  var wconfirmAlertContent = $("#wconfirm_alert_content")
  var print = $("#print")
  var summary = $("#summary")
  var summaryDateFrom = $("#summary-date-from")
  var summaryDateEnd = $("#summary-date-end")
  var summaryContent = $("#summary-content")
  var tab = $(".tab")

  var doctorId = {doctorId}

  var admin = {admin}
  var regist = false
  var color = ["white", "gray", "green", "red", "orange", "blue", "yellow"]
  var panis = []
  var exDate = -1
  var exType = -1
  var wconfirmData = []
  var manager = 0

  var global = {
    register: JSON.parse('{register}'),
    regist: [
      [
        [],[],[],[]
      ],
      [
        [],[],[],[]
      ],
      [
        [],[],[],[]
      ],
      [
        [],[],[],[]
      ],
      [
        [],[],[],[]
      ],
      [
        [],[],[],[]
      ],
      [
        [],[],[],[]
      ]
    ],
    weekLimit: [2, 2, 2, 2, 2, 1, 1],
    registing: [],
    registStatus: false,
    user: JSON.parse('{user_list}'),
    except: JSON.parse('{except}'),
    floor: JSON.parse('{floor}'),
    ufloor: JSON.parse('{ufloor}'),
    username: trim('{username}'),
    day: '{this_date}',
    time: '{this_time}'
  }

  setEvent()

  // general

  doctor.change((e) => {
    doctorId = doctor.val()
    user_position = doctor[0].children[doctor[0].selectedIndex].getAttribute('position')
    username = trim($("#doctor option:selected").text())
    regist = false
  })

  tab.click((e) => {
    current = e.currentTarget

    tab.removeClass("active")
    tab.removeClass("btn-info")
    current.classList.add("active")
    current.classList.add("btn-info")

    if (current.getAttribute("rel") == 1)  {
      print.show()
      register.show()
      dconfirm.hide()
      manager = false
      filterData()
    }
    else {
      print.hide()
      register.hide()
      reset.hide()
      cconfirm.hide()
      dconfirm.show()
      manager = true
      toWconfirm()
    }
  })

  dconfirm.click(() => {
    pan = []
    html = ""
    $(".cdailyrou").each((item, row) => {
      var thisDate = row.getAttribute("date")
      var thisColor = row.getAttribute("class").replace("cdailyrou ", "")
      var thisType = row.getAttribute("dtype")
      if (thisColor == "purple" || thisColor == "yellow") {
        var name = trim(row.parentElement.children[1].innerText)
        pan.push({
          color: thisColor,
          date: thisDate,
          type: Number(thisType),
          name: name
        })
        html += "<p>" + dateToString(new Date(Number(thisDate) * 1000)) + ": " + (thisColor == "yellow" ? "Thêm" : "Bỏ") + " ca " + ((thisType - 2) ? "chiều" : "sáng") + " cho " + name + "</p>"
      }
    })
    wconfirmData = pan
    if (wconfirmData.length) {
      wconfirmAlertContent.html(html)
      wconfirmAlert.modal("show")
    }
  })

  // function parseWeekView() {
  //   global['register'].forEach((registerRow, rowIndex) => {
  //     registerRow.forEach((registerData, dataIndex) => {
  //       if (registerData.length) {
  //         registerData.forEach(registerUserid => {
  //           if (global['user'][registerUserid]) {
  //             $('#' + rowIndex + '_' + dataIndex).text(global['user'][registerUserid])
  //           }
  //         })
  //       }
  //     })
  //   })
  // }

  function parseWeekEdit() {
    global['registStatus'] = !global['registStatus']
    global['registing'] = global['regist'] 
    if (global['registStatus']) {
      parseWeekOn()
    }
    parseWeek()
  }

  function parseWeekOn() {
    global['register'].forEach((registerRow, rowIndex) => {
      var time = $("#" + rowIndex).attr('time')
      var day = reparseDay(new Date(time * 1000).getDay())
      // var color = ["white", "gray", "green", "red", "orange", "blue", "yellow"]
      //               0        1       2        3      4         5       6

      if (global['time'] > time) {
        global['registing'][rowIndex] = [1, 1, 1, 1]
      }
      else {
        global['registing'][rowIndex] = [2, 2, 2, 2]
      }
      registerRow.forEach((registerData, dataIndex) => {
        if (registerData.length) {
          var userListString = $('#' + rowIndex + '_' + dataIndex).text()
          var userList = userListString.split(', ')
          console.log(global['registing'][rowIndex][dataIndex])
          if (global['registing'][rowIndex][dataIndex] == 1) {

          }
          else if (userListString.search(global['username']) >= 0) {
            global['registing'][rowIndex][dataIndex] = 4
          }
          else if (checkExcept(userList) >= global['weekLimit'][day] || checkFloor(userList) < 2) {
            global['registing'][rowIndex][dataIndex] = 3
          }
        }
      })
    })
  }

  function parseWeek() {
    global['registing'].forEach((XCell, XCellIndex) => {
      XCell.forEach((YCell, YCellIndex) => {
        $('#' + XCellIndex + '_' + YCellIndex).attr('class', color[YCell])
      })
    })
  }

  function reparseDay(day) {
    if (day) {
      day --
    }
    else {
      day = 6
    }
    return day
  }

  function showSummary() {
    summary.modal("show")
  }

  function summarySubmit() {
    freeze()
    $.post(
      strHref,
      {action: "summary", startDate: summaryDateFrom.val(), endDate: summaryDateEnd.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          summary.modal("show")
          summaryContent.html(data["html"])
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }

  // wconfirm: confirm case of work each week

  function wconfirmSubmit() {
    $.post(
      strHref,
      {action: "wconfirmSubmit", startDate: startDate.val(), data: wconfirmData},
      (response, status) => {
        checkResult(response, status).then(data => {
          wconfirmAlert.modal("hide")
          content.html(data["html"])
          doctorId = data["doctorId"]
          wconfirmInitiaze()
        }, () => {})
      }
    )
  }

  function toWconfirm() {
    $.post(
      strHref,
      {action: "wconfirm", startDate: startDate.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data["html"])
          doctorId = data["doctorId"]
          wconfirmInitiaze()
        }, () => {})
      }
    )
  }

  function wconfirmInitiaze() {
    $(".cdailyrou").click((e) => {
      var current = e.currentTarget
      var thisColor = current.getAttribute("class").replace("cdailyrou ", "")

      switch (thisColor) {
        case "red":
          current.setAttribute("class", "cdailyrou purple")
          break;
        case "purple":
          current.setAttribute("class", "cdailyrou red")
          break;
        case "green":
          current.setAttribute("class", "cdailyrou yellow")
          break;
        case "yellow":
          current.setAttribute("class", "cdailyrou green")
          break;
      }

      var date = 0
      $(".ddailyrou").each((index, row) => {
        row.innerText = 0
      })
      $(".cdailyrou").each((index, row) => {
        currentRow = row
        var thisDate = currentRow.getAttribute("date")
        var thisColor = currentRow.getAttribute("class").replace("cdailyrou ", "")
        var thisType = currentRow.getAttribute("dtype")
        if (thisColor == "red" || thisColor == "yellow") {
          var parentChild = currentRow.parentElement.children
          var parentChildFor = parentChild[parentChild.length - 5 + Number(thisType)]
          parentChildFor.innerText = Number(parentChildFor.innerText) + 1
          parentChild[parentChild.length - 1].innerText = Number(parentChild[parentChild.length - 2].innerText) + Number(parentChild[parentChild.length - 3].innerText)
        }
      })
    })
  }

  // regist a case of work

  function tickOn() {
    cconfirm.show()
    reset.show()
    register.hide()
    regist = true
  }

  function tickOff() {
    cconfirm.hide()
    reset.hide()
    register.show()
    regist = false
  }

  register.click(() => {
    parseWeekEdit()
    tickOn()
  })

  reset.click(() => {
    registOff()
    tickOff()
  })

  cconfirm.click(() => {
    panis = checkRegist()
    if (panis.length) {
      var html = ""
      panis.forEach(item => {
        var type = "Đăng ký"
        if (item["color"] == "purple") {
          var type = "Bỏ đăng ký"
        }
        switch (item["type"]) {
          case 2:
            retype = "lịch trực sáng"
            break;
          case 3:
            retype = "lịch trực tối"
            break;
          case 4:
            retype = "lịch nghỉ sáng"
            break;
          case 5:
            retype = "lịch nghỉ chiều"
            break;
        }
        html += "<div class='regist_item'>" + type + " " + retype + " ngày " + item["date"] + "</div>"
      })
      registConfirm.modal("show")
      registList.html(html)
    }
    else {
      registOff()
      tickOff()
    }
  })


  $("#start-date").change(() => {
    dateTimeout = setTimeout(() => {
      filterData()
    }, 500);
  })

  $("#start-date, #summary-date-from, #summary-date-end").datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  // event function

  function registOff() {
    var table = content[0].children[0].children[1].children
    var moi = [0, 0, 0, 0, 0, 0]

    for (const rowKey in table) {
      if (table.hasOwnProperty(rowKey)) {
        const row = table[rowKey];
        moi.forEach((cellColor, index) => {
          row.children[index].setAttribute("class", color[cellColor])
        });
      }
    }
  }

  function checkRegist() {
    var table = content[0].children[0].children[1].children
    var moi = [0, 0, 0, 0, 0, 0]
    var pan = []

    for (const rowKey in table) {
      if (table.hasOwnProperty(rowKey)) {
        const row = table[rowKey];
        moi.forEach((cellColor, index) => {
          var this_class = row.children[index].getAttribute("class")
          if (this_class == "purple" || this_class == "blue") {
            pan.push({
              date: trim(row.children[0].innerText),
              type: index,
              color: this_class
            })
          }
        });
      }
    }
    
    return pan
  }

  function registSubmit() {
    $(".btn, .form-control").attr("disabled", true)
    $.post(
      strHref,
      {action: "regist", doctorId: doctorId, itemList: panis, startDate: startDate.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          $(".btn").attr("disabled", false)
          content.html(data["html"])
          setEvent()
          dbdata = JSON.parse(data["json"])
          schedule = dbdata.length
          registConfirm.modal("hide")
          tickOff()
          registOff()
          global['registStatus'] = false
        }, () => { })
      }
    )
  }

  function filterData() {
    tickOff()
    $(".btn, .form-control").attr("disabled", true)
      $.post(
        strHref,
        {action: "filter_data", startDate: startDate.val()},
        (response, status) => {
          checkResult(response, status).then((data) => {
            content.html(data["html"])
            setEvent()
            dbdata = JSON.parse(data["json"])
            schedule = dbdata.length
            $(".btn, .form-control").attr("disabled", false)
          }, () => {
            $(".btn, .form-control").attr("disabled", false)
          })        
        }
      )
  }

  // button function

  function printer() {
    var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
    var html = content.html().toString()
    html = "<style>table {border-collapse: collapse; width: 100%;} td, th {border: 1px solid black; padding: 4px;} .text-center{text-align: center;}</style>" + html
    
    WinPrint.document.write(html);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();
  }

  function nextWeek() {
    var dateVal = startDate.val().split("/")
    var date = new Date(dateVal[2], parseInt(dateVal[1]) - 1, dateVal[0])
    var day = date.getDay()
    var diff = date.getDate() - day + 1
    date.setDate(diff + 7)
    startDate.val(dateToString(date))

    if (manager) {
      toWconfirm()
    }
    else {
      filterData()
    }
  }

  function prevWeek() {
    var dateVal = startDate.val().split("/")
    var date = new Date(dateVal[2], parseInt(dateVal[1]) - 1, dateVal[0])
    var day = date.getDay()
    var diff = date.getDate() - day + 1
    date.setDate(diff - 7)
    startDate.val(dateToString(date))
    
    if (manager) {
      toWconfirm()
    }
    else {
      filterData()
    }
  }

  // initiaze

  function setEvent() {
    var td = $(".dailyrou")
    td.click((e) => {
      if (regist) {
        var that = e.currentTarget
        var thisDateVal = (trim(that.parentElement.children[0].innerText)).split("/")
        var thisDate = new Date(thisDateVal[2], parseInt(thisDateVal[1]) - 1, thisDateVal[0])
        var thisColor = that.getAttribute("class")
        var thisValue = trim(that.innerText)
        
        if (admin || (thisDate > today)) {
          switch (thisColor) {
            case "red":
              // if (thisValue.search(username) > 0) {
              //   that.setAttribute("class", "purple")
              // }
              // else if (checkExcept(thisValue)) {
              //   that.setAttribute("class", "blue")
              // }
            break;
            case "blue":
              // blue turn green
              that.setAttribute("class", "green")
            break;
            case "green":
              // green turn blue
              that.setAttribute("class", "blue")
            break;
            case "purple":
              // not a thing
              // if (username && thisValue.search(username) >= 0) {
                that.setAttribute("class", "orange")
              // }
            break;
            case "orange":
              // not a thing
              that.setAttribute("class", "purple")
            break;
            case "yellow":
              // yellow turn red
              // that.setAttribute("class", "green")
            break;
          }
        }
      }
    })
  }

  function checkExcept(list) {
    var count = list.length

    global['except'].forEach(exceptName => {
      if (list.indexOf(exceptName) >= 0) {
        count --
      }
    })
    return count
  }

  function checkFloor(list) {
    var count = global['floor'][global['ufloor']]
    list.forEach(username => {
      count = count.filter(userfloor => {
        return count.indexOf(username) < 0
      })
    })
    return count.length
  }
</script>
<!-- END: main -->