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

<!-- <div id="confirm_work" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Xác nhận lịch tuần </h2>
        <div id="confirm_work_content">

        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="checkAdRegist()">
            Đăng ký
          </button>
          <button class="btn btn-danger" data-dismiss="modal" onclick="registOff()">
            Hủy
          </button>
        </div>
      </div>
    </div>
  </div>
</div> -->

<!-- <div id="exchange_work" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Chọn người bạn muốn đổi ca? </h2>
        <div>
          <div id="exchange_work_head">

          </div>
          <select id="exchange_work_doctor" class="form-control">
            BEGIN: doctor
            <option value="{doctor_value}">{doctor_name}</option>
            END: doctor
          </select>
          <div id="exchange_work_content">
          </div>
        </div>
        <div class="text-center">
          <button class="btn btn-danger" data-dismiss="modal">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div> -->

<!-- <div id="work_list" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Danh sách ngày các ca đã đăng ký? </h2>
        <div id="work_content_list">

        </div>
        <div class="text-center">
          <button class="btn btn-danger" data-dismiss="modal" onclick="registOff()">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div> -->
  
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
    <!-- <button class="btn btn-info right" onclick="toWconfirm()">
      Xác nhận
    </button> -->
    <!-- <button class="btn btn-info" id="list">
      Danh sách
    </button> -->
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
  <div style="width: 20px; height: 20px; display: inline-block; background: green;"></div> Chưa đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: red;"></div> Có người đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: orange;"></div> Bản thân đăng ký <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: yellow;"></div> Đăng ký thêm <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: blue;"></div> Đăng ký thêm <br>
  <div style="width: 20px; height: 20px; display: inline-block; background: purple;"></div> Bỏ đăng ký <br>
</div>
<script>
  var today = new Date('{date}').setHours(0)
  var dbdata = JSON.parse('{data}')
  var except = JSON.parse('{except}')
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
  // var workList = $("#work_list")
  // var workContentList = $("#work_content_list")
  // var exchangeWork = $("#exchange_work")
  // var exchangeWorkContent = $("#exchange_work_content")
  // var exchangeWorkDoctor = $("#exchange_work_doctor")
  // var confirmWork = $("#confirm_work")
  // var confirmWorkContent = $("#confirm_work_content")
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
  var color = ["white", "green", "red", "orange"]
  var panis = []
  var exDate = -1
  var exType = -1
  var wconfirmData = []
  var manager = 0

  setEvent()

  // #exchange
  // exchangeWorkDoctor.change(() => {
  //   getWorkList()
  // })

  // function exchange(exchangeDate, exchangeType) {
  //   exDate = exchangeDate
  //   exType = exchangeType

  //   getWorkList().then(() => {
  //     exchangeWork.modal("show")
  //   })
  // }

  // function getWorkList() {
  //   return new Promise(resolve => {
  //     $.post(
  //       strHref,
  //       {action: "getWorkList", doctorId: exchangeWorkDoctor.val(), exType: exType, startDate: startDate.val(), endDate: endDate.val()},
  //       (response, status) => {
  //         checkResult(response, status).then((data) => {
  //           exchangeWorkContent.html(data["html"])
  //           resolve()
  //         }, () => {})
  //       }    
  //     )
  //   })
  // }

  // function exchangeSubmit(exDate2, extype2) {
  //   $.post(
  //     strHref,
  //     {action: "exchange", exDate: exDate, exType: exType, exDate2: exDate2, exType2: exType2},
  //     (response, status) => {
  //       checkResult(response, status).then((data) => {

  //       }, () => {})
  //     }
  //   )
  // }

  // #confirm schedule
  // function editSchedule() {
  //   $.post(
  //     strHref,
  //     {action: "editSchedule", doctorId: exchangeWorkDoctor.val(), exType: exType, startDate: startDate.val(), endDate: endDate.val()},
  //     (response, status) => {
  //       checkResult(response, status).then((data) => {
  //         confirmWorkContent.html(data["html"])
  //         confirmWork.modal("show")
          
  //         setEvent2()
  //       }, () => {})
  //     }    
  //   )
  // }

  // function registOnAdmin() {
  //   if (admin) {
  //     registOff()
  //   }
  //   else {
  //     var table = content[0].children[0].children[1].children
  //     var i = 0
  //     var thisDateString = "", thisDate = 0
  //     for (const rowKey in table) {
  //       if (table.hasOwnProperty(rowKey)) {
  //         const row = table[rowKey];
  //         var moi = [0, 0, 0, 0, 0]
          
  //         while (i < schedule && (row.children[0].innerText == dbdata[i]["date"])) {
  //           moi[dbdata[i]["type"] + 1] = 2
  //           i ++
  //         }
  //         moi.forEach((cellColor, index) => {
  //           row.children[index].setAttribute("class", color[cellColor])
  //         });
  //       }
  //     }
      
  //   }
  //   admin = !admin
  // }

  // list.click(() => {
  //   var table = content[0].children[0].children[1].children
  //   var i = 0
  //   html = ""
  //   for (const rowKey in table) {
  //     if (table.hasOwnProperty(rowKey)) {
  //       const row = table[rowKey];
  //       var last_type = -1
  //       var last_date = -1

  //       while (i < schedule && (row.children[0].innerText == dbdata[i]["date"])) {
  //         if (row.children[dbdata[i]["type"] + 1].innerText.search(username) >= 0) {
  //           if (last_date != dbdata[i]["date"] || last_type != dbdata[i]["type"]) {
  //             switch (dbdata[i]["type"]) {
  //               case 0:
  //                 type = "trực sáng"
  //                 break;
  //               case 1:
  //                 type = "trực tối"
  //                 break;
  //               case 2:
  //                 type = "nghỉ sáng"
  //                 break;
  //               case 3:
  //                 type = "nghỉ chiều"
  //                 break;
  //             }
  //             html += "<div class='item'>Ngày " + dbdata[i]["date"] + ": " + type + "<button class='btn btn-info right' onclick='exchange(\"" + dbdata[i]["date"] + "\", " + dbdata[i]["type"] +")'><span class='glyphicon glyphicon-retweet'></span></button></div>"
  //           }
  //         }
  //         last_date = dbdata[i]["date"]
  //         last_type = dbdata[i]["type"]
  //         i ++
  //       }
  //     }
  //   }
  //   workContentList.html(html)
  //   workList.modal("show")
  // })

  // general

  doctor.change((e) => {
    doctorId = doctor.val()
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
    registOn()
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

  // dateType.change(() => {
  //   var date = {}
  //   var now = new Date();
    
  //   switch (dateType.val()) {
  //     case "1":
  //       // this week
  //       date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 1);
  //       date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 7);
  //     break;
  //     case "2":
  //       // next week
  //       date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 7);
  //       date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 14);
  //     break;
  //     case "3":
  //       // this month
  //       date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, 1);
  //       date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 2, 1);
  //     break;
  //     case "4":
  //       // last month
  //       date["startDate"] = new Date(now.getFullYear(), now.getMonth(), 1);
  //       date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, 1);
  //     break;
  //     case "5":
  //       // next month
  //       date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 2, 1);
  //       date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 3, 1);
  //     break;
  //   }
  //   if (date["startDate"]) {
  //     startDate.val(dateToString(date["startDate"]));
  //     endDate.val(dateToString(date["endDate"]));
  //     filterData(); 
  //   }
  // })

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

  function registOn() {
    var table = content[0].children[0].children[1].children
    var i = 0
    for (const rowKey in table) {
      if (table.hasOwnProperty(rowKey)) {
        const row = table[rowKey];
        var moi = [0, 0, 1, 1, 1, 1]
        while (i < schedule && (row.children[0].innerText == dbdata[i]["date"])) {
          var thisIndex = Number(dbdata[i]["type"]) + 2
          // var color = ["white", "green", "red", "orange"]
          
          if (row.children[thisIndex].innerText.search(username) >= 0) {
            moi[thisIndex] = 3
          }
          else {
            moi[thisIndex] = 2
          }
          i ++
        }
        moi.forEach((cellColor, index) => {
          row.children[index].setAttribute("class", color[cellColor])
        });
      }
    }
  }

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
          if (this_class == "yellow" || this_class == "purple" || this_class == "blue") {
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
          $(".btn, .form-control").attr("disabled", false)
        }, () => {
          $(".btn, .form-control").attr("disabled", false)
        })
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
        var thisDay = new Date(today).getDay()
        
        if (admin || (thisDate >= today)) {
          switch (thisColor) {
            case "red":
              var limit = 2
              var x = thisValue.split(', ')

              if (thisDay == 0 || thisDay == 6) {
                var limit = 1
              }

              if (except.join('').search(username) >= 0) {
                that.setAttribute("class", "blue")
              }
              else {
                except.forEach(item => {
                  if ((m = x.indexOf(item)) >= 0) {
                    x.splice(m, 1)
                  }
                })
                
                if (x.length < limit) {
                  that.setAttribute("class", "blue")
                }                
              }

              // if (x.length == 1 && thisValue.search(except.join('-')) >= 0) {
              //   limit --
              // }

              // if (thisValue.search(username) > 0) {
              //   that.setAttribute("class", "purple")
              // }
              // else if (checkExcept(thisValue)) {
              //   that.setAttribute("class", "blue")
              // }
            break;
            case "blue":
              that.setAttribute("class", "red")
            break;
            case "green":
              that.setAttribute("class", "yellow")
            break;
            case "purple":
              if (username && thisValue.search(username) >= 0) {
                that.setAttribute("class", "orange")
              }
            break;
            case "orange":
              that.setAttribute("class", "purple")
            break;
            case "yellow":
              that.setAttribute("class", "green")
            break;
          }
        }
      }
    })
  }

  function checkExcept(listText) {
    var count = (listText.match(/,/g) || []).length
    except.forEach(exceptName => {
      var x = listText.search(exceptName)
      if (x >= 0) {
        count --
      }
    })
    if (count < 1) {
      return 1
    }
    return 0
  }
</script>
<!-- END: main -->