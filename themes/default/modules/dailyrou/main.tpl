<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
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
  <div class="col-sm-4">
    <button class="btn btn-info" id="register">
      Đăng ký
    </button>
  </div>
  <div class="col-sm-4">
    <button class="btn btn-info" id="list">
      Danh sách
    </button>
  </div>
</div>
<div id="content">
  {content}
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
  var list = $("#list")
  var content = $("#content")
  var registConfirm = $("#regist_confirm")
  var registList = $("#regist_list")

  var regist = false
  var color = ["white", "green", "red", "orange"]
  var panis = []

  setEvent()

  function setEvent(params) {
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
      // case "6":
      //   // this year
      //   date["startDate"] = new Date(now.getFullYear(), 1, 1);
      //   date["endDate"] = new Date(now.getFullYear() + 1, 1, 1);
      // break;
      // case "7":
      //   // last year
      //   date["startDate"] = new Date(now.getFullYear() - 1, 1, 1);
      //   date["endDate"] = new Date(now.getFullYear(), 1, 1);
      // break;
      // case "8":
      //   // all
      //   date["startDate"] = new Date(1970, 1, 1);
      //   date["endDate"] = new Date(2038, 1, 1);
      // break;
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

  list.click(() => {

  })

  function registOn() {
    var table = content[0].children[0].children[1].children
    var i = 0
    for (const rowKey in table) {
      if (table.hasOwnProperty(rowKey)) {
        const row = table[rowKey];
        var moi = [0, 1, 1, 1]
        while (i < schedule && (row.children[0].innerText == dbdata[i]["date"])) {
          if (row.children[dbdata[i]["type"] + 1].innerText.search(username) >= 0) {
            moi[dbdata[i]["type"] + 1] = 3
          }
          else {
            moi[dbdata[i]["type"] + 1] = 2
          }
          i ++
        }
        moi.forEach((cellColor, index) => {
          row.children[index].setAttribute("class", color[cellColor])
        });
      }
    }
  }

  function checkRegist() {
    var table = content[0].children[0].children[1].children
    var moi = [0, 0, 0, 0]
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

  function registOff() {
    var table = content[0].children[0].children[1].children
    var moi = [0, 0, 0, 0]

    for (const rowKey in table) {
      if (table.hasOwnProperty(rowKey)) {
        const row = table[rowKey];
        moi.forEach((cellColor, index) => {
          row.children[index].setAttribute("class", color[cellColor])
        });
      }
    }
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
</script>
<!-- END: main -->