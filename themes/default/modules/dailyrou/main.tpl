<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

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
          <button class="btn btn-danger" data-dismiss="modal" onclick="registOff()">
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
  
<div class="row">
  <div class="col-sm-4">
    <input class="form-control" id="start-date" type="text" value="{this_week}" autocomplete="off">
  </div>
  <div class="col-sm-4">
    <input class="form-control" id="end-date" type="text" value="{next_week}" autocomplete="off">
  </div>
  <div class="col-sm-4">
    <select class="form-control" id="date-type">
      <!-- BEGIN: date_option -->
      <option value="{date_value}"> {date_name} </option>
      <!-- END: date_option -->
    </select>
  </div>
  <div class="col-sm-4">

  </div>
  <div class="col-sm-8">
    <button class="btn btn-info right" id="register">
      Đăng ký
    </button>
    <button class="btn btn-info right" onclick="print()">
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
<div>
  {doctor}
</div>
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
  var schedule = dbdata.length
  var username = trim('{username}');
  var startDate = $("#start-date")
  var endDate = $("#end-date")
  var dateType = $("#date-type")
  var register = $("#register")
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

  var doctorId = 0

  var admin = false
  var regist = false
  var color = ["white", "green", "red", "orange"]
  var panis = []
  var exDate = -1
  var exType = -1

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
    filterData()
  })

  // wconfirm: confirm case of work each week

  // function toWconfirm() {
  //   $.post(
  //     strHref,
  //     {action: "wconfirm", startDate: startDate.val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["html"])
  //         doctorId = data["doctorId"]
  //         wconfirmInitiaze()
  //       }, () => {})
  //     }
  //   )
  // }

  // function wconfirmChange() {
  //   $.post(
  //     strHref,
  //     {action: "wconfirmChange", startDate: startDate.val(), doctorId: doctor.val()},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["html"])
  //         doctorId = doctor.val()
  //         wconfirmInitiaze()
  //       }, () => {})
  //     }
  //   )
  // }

  // function wconfirmInitiaze() {
  //   doctor = $("#doctor")
  //   doctor.change(() => {
  //     wconfirmChange()
  //   })
  // }

  // function removeWconfirm(date, type) {
  //   $.post(
  //     strHref,
  //     {action: "removeWconfirm", startDate: startDate.val(), doctorId: doctorId, date: date, type: type},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         content.html(data["html"])
  //         wconfirmInitiaze()
  //       }, () => {})
  //     }
  //   )
  // }

  // regist a case of work

  register.click(() => {
    if (regist) {
      panis = checkRegist()
      if (panis.length) {
        var html = ""
        panis.forEach(item => {
          var type = "Đăng ký"
          var retype = "lịch trực"
          if (item["color"] == "purple") {
            var type = "Bỏ đăng ký"
          }
          switch (item["type"]) {
            case 2:
              retype = "nghỉ sáng"
              break;
            case 3:
              retype = "nghỉ chiều"
              break;
          }
          html += "<div class='regist_item'>" + type + " " + retype + " ngày " + item["date"] + "</div>"
        })
        registConfirm.modal("show")
        registList.html(html)
      }
      else {
        registOff()
      }
    }
    else {
      registOn()
    }
    regist = !regist
    admin = false
  })

  dateType.change(() => {
    var date = {}
    var now = new Date();
    
    switch (dateType.val()) {
      case "1":
        // this week
        date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 1);
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 7);
      break;
      case "2":
        // next week
        date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 7);
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 14);
      break;
      case "3":
        // this month
        date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, 1);
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 2, 1);
      break;
      case "4":
        // last month
        date["startDate"] = new Date(now.getFullYear(), now.getMonth(), 1);
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, 1);
      break;
      case "5":
        // next month
        date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 2, 1);
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 3, 1);
      break;
    }
    if (date["startDate"]) {
      startDate.val(dateToString(date["startDate"]));
      endDate.val(dateToString(date["endDate"]));
      filterData(); 
    }
  })

  $("#start-date, #end-date").change(() => {
    dateTimeout = setTimeout(() => {
      filterData()
    }, 500);
  })

  $("#start-date, #end-date").datepicker({
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
        var moi = [0, 1, 1, 1, 1]
        // console.log(row.children[0].innerText);
        while (i < schedule && (row.children[0].innerText == dbdata[i]["date"])) {
        // console.log(Number(dbdata[i]["type"]) + 1);
          var thisIndex = Number(dbdata[i]["type"]) + 1
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
    var moi = [0, 0, 0, 0, 0]

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
    var moi = [0, 0, 0, 0, 0]
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
    $.post(
      strHref,
      {action: "regist", itemList: panis, startDate: startDate.val(), endDate: endDate.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
          dbdata = JSON.parse(data["json"])
          schedule = dbdata.length
          registConfirm.modal("hide")
          setEvent()
        }, () => {})
      }
    )
  }

  function filterData() {
    $.post(
      strHref,
      {action: "filter_data", startDate: startDate.val(), endDate: endDate.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
          dbdata = JSON.parse(data["json"])
          schedule = dbdata.length
          setEvent()
        }, () => {})        
      }
    )
  }

  // button function

  function print() {
    var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
    var html = content.html().toString()
    html = "<style>table {border-collapse: collapse;} td, th {border: 1px solid black; padding: 4px;} .text-center{text-align: center;}</style>" + html
    
    WinPrint.document.write(html);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();
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
        if (thisDate >= today) {
          switch (thisColor) {
            case "red":
              if (thisValue.search(",") < 0) {
                that.setAttribute("class", "blue")
              }
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
</script>
<!-- END: main -->