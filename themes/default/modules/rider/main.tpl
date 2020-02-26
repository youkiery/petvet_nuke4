<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

{modal}

<div class="form-group" style="float: right;">
  <button class="btn btn-info" onclick="statistic()">
    Thống kê
  </button>
  <button class="btn btn-success" onclick="collectModal()">
    Thêm phiếu lái xe
  </button>
  <button class="btn btn-success" onclick="payModal()">
    Thêm phiếu chi
  </button>
</div>

<div style="clear: both;"></div>
  
<div class="row form-group">
  <div class="col-sm-4">
    <select class="form-control" id="type">
      <option value="0"> Lộ trình </option>
      <option value="1"> Chi </option>
    </select>
  </div>
  <div class="col-sm-4">
    <input class="form-control" id="start-date" type="text" value="{today}" autocomplete="off">
  </div>
  <div class="col-sm-4">
    <input class="form-control" id="end-date" type="text" value="{tomorrow}" autocomplete="off">
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
</div>
<div id="content">
  {content}
</div>

<script>
  var dbdata = JSON.parse('{data}')
  var customer = dbdata["customer"] ? dbdata["customer"].length : 0
  var remind = dbdata["remind"] ? dbdata["remind"].length : 0
  var type = $("#type")
  var startDate = $("#start-date")
  var endDate = $("#end-date")
  var dateType = $("#date-type")
  var insert = $("#insert")
  var content = $("#content")

  var insertCollect = $("#insert-collect")
  var collectDoctor = $("#collect-doctor")
  var collectCustomerInfo = $("#collect-customer-info")
  var collectCustomerSuggest = $("#collect-customer-suggest")
  var collectCustomer = $("#collect-customer")
  var collectStart = $("#collect-start")
  var collectEnd = $("#collect-end")
  var collectPrice = $("#collect-price")
  var collectDestination = $("#collect-destination")
  var collectDestinationSuggest = $("#collect-destination-suggest")
  var collectNote = $("#collect-note")
  var collectInsert = $("#collect-insert")

  var insertPay = $("#insert-pay")
  var payMoney = $("#pay-money")
  var payNote = $("#pay-note")
  var payInsert = $("#pay-insert")

  var riderDetail = $("#rider-detail")
  var riderDate = $("#rider-date")
  var riderDestination = $("#rider-destination")
  var riderFrom = $("#rider-from")
  var riderEnd = $("#rider-end")

  var removeModal = $("#remove-modal")

  var suggest = $(".suggest")
  var dateTimeout = null
  var customerTimeout = null
  var destinationTimeout = null
  var customerId = 0
  var destinationId = 0
  var money = 0
  var page = {page}
  var limit = {limit}
  var clock = [Number("{clock}"), Number("{clock}")]
  var rider = {rider}
  var global_id = 0
  var global_type = 0
  const formatter = new Intl.NumberFormat('vi-VI', {
    style: 'currency',
    currency: 'VND'
  })


  type.change(() => {    
    filterData()
  })

  $("#collect-customer, #collect-destination").focus((e) => {
    e.currentTarget.parentElement.children[1].style["display"] = "block"
  })

  $("#collect-customer, #collect-destination").blur(() => {
    setTimeout(() => {
      suggest.hide()
    }, 200);
  })

  payMoney.keyup(() => {
    var value = Number((payMoney.val()).replace(/\,/g, ""));
    if (Number.isFinite(value)) {
      money = value
    }
    
    value = formatter.format(value).replace(/ ₫/g, "").replace(/\./g, ",");
    payMoney.val(value)
  })

  collectPrice.keyup(() => {
    var value = Number((collectPrice.val()).replace(/\,/g, ""));
    if (Number.isFinite(value)) {
      money = value
    }
    
    value = formatter.format(value).replace(/ ₫/g, "").replace(/\./g, ",");
    collectPrice.val(value)
  })

  dateType.change(() => {
    var date = {}
    var now = new Date();
    
    switch (dateType.val()) {
      case "1":
        // today
        date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate());
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() + 1);
      break;
      case "2":
        // this week
        date["startDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 1);
        date["endDate"] = new Date(now.getFullYear(), now.getMonth() + 1, now.getDate() - now.getDay() + 8);
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
        // this year
        date["startDate"] = new Date(now.getFullYear(), 1, 1);
        date["endDate"] = new Date(now.getFullYear() + 1, 1, 1);
      break;
      case "6":
        // last year
        date["startDate"] = new Date(now.getFullYear() - 1, 1, 1);
        date["endDate"] = new Date(now.getFullYear(), 1, 1);
      break;
      case "7":
        // all
        date["startDate"] = new Date(1970, 1, 1);
        date["endDate"] = new Date(2038, 1, 1);
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

  $("#collect-start, #collect-end").keyup((e) => {
    var current = e.currentTarget
    var val = current.value.replace(/\,|\./g, "")
    var id = current.getAttribute("id")
    var type = 0
    if (id == "collect-end") {
      type = 1
    }

    if (Number.isFinite(Number(val))) {
      clock[type] = val
    }
    else {
      val = clock[type]
    }
    val = val.split("")
    var x = val[val.length - 1]
    
    val[val.length - 1] = "."
    val[val.length] = x
    val = val.join("")
    
    current.value = val

    var start = Number(collectStart.val().trim())
    var end = Number(collectEnd.val().trim())
    
    var space = Math.floor(end - start) * 10000
    
    if (space >= 10000) {
      value = formatter.format(space).replace(/ ₫/g, "").replace(/\./g, ",");
      collectPrice.val(value)
    }
  })

  collectCustomer.keyup(() => {
    clearTimeout(customerTimeout)

    customerTimeout = setTimeout(() => {
      var keyword = collectCustomer.val()
      var list = []
      var type = "name"

      if (Number(keyword)) {
        type = "phone";
      }

      for (const customerId in dbdata["customer"]) {
        if (dbdata["customer"].hasOwnProperty(customerId)) {
          const customerData = dbdata["customer"][customerId];
          
          if (customerData[type].search(keyword) >= 0) {
            list.push(customerData)
            if (list.length >= 20) {
              break;
            }
          }
        }
      }
      
      html = "";
      if (list.length) {
        list.forEach((customerData) => {
          html += "<div class='suggest-item' onclick='selectCustomer(" + customerData["id"] + ", \"" + type + "\")'><i>" + customerData["name"] + "</i><br><b>" + customerData["phone"] + "</b></div>";
        })
      }
      else {
        html = "<div class='suggest-item'>Không tìm thấy khách hàng nào</div>"
      }
      collectCustomerSuggest.html(html)
    }, 500);
  })

  collectDestination.keyup(() => {
    clearTimeout(destinationTimeout)

    destinationTimeout = setTimeout(() => {
      var keyword = collectDestination.val()
      var list = []

      for (const destinationId in dbdata["remind"]) {
        if (dbdata["remind"].hasOwnProperty(destinationId)) {
          const destinationData = dbdata["remind"][destinationId];
          
          if (destinationData["value"].search(keyword) >= 0) {
            list.push(destinationData)
            if (list.length >= 20) {
              break;
            }
          }
        }
      }
      
      html = "";
      if (list.length) {
        list.forEach((destinationData) => {
          html += "<div class='suggest-item' onclick='selectDestination(" + destinationData["id"] + ")'><b>" + destinationData["value"] + "</b></div>";
        })
      }
      else {
        html = "<div class='suggest-item'>Không có gợi ý</div>"
      }
      collectDestinationSuggest.html(html)
    }, 500);
  })

  $("#start-date, #end-date").datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  function collectModal() {
    insertCollect.modal("show")
  }

  function payModal() {
    insertPay.modal("show")
  }

  collectInsert.click(() => {
    if (!checkNumber(collectStart.val())) {
      alert_msg("Cây số đầu phải là số")
    }
    else if (!checkNumber(collectEnd.val())) {
      alert_msg("Cây số cuối phải là số")
    }
    else if (Number(collectStart.val()) >= Number(collectEnd.val())) {
      alert_msg("Số cuối phải lớn hơn số đầu")
    }
    else {
      $(".btn, .form-control").attr("disabled", true)
      $.post(
        strHref,
        {action: "collect-insert", page: page, limit: limit, startDate: startDate.val(), endDate: endDate.val(), collectDriver: rider, collectDoctor: collectDoctor.val(), collectPrice: collectPrice.val().replace(',', ''), collectStart: collectStart.val(), collectEnd: collectEnd.val(), collectCustomer: customerId, collectDestination: collectDestination.val(), collectNote: collectNote.val()},
        (response, status) => {
          checkResult(response, status).then((data) => {
            customerId = 0
            collectStart.val(collectEnd.val())
            collectCustomer.val("")
            collectCustomerInfo.text("")
            collectPrice.val("")
            collectDestination.val("")
            collectNote.val("")
            $("#type").val(0)
            $("#insert-collect").modal('hide')
            content.html(data["html"])
            $(".btn, .form-control").attr("disabled", false)
          }, () => {
            $(".btn, .form-control").attr("disabled", false)
          })        
        }
      )
    }
  })

  payInsert.click(() => {
    currentMoney = payMoney.val().replace(/\,/g, "")
    if (!checkNumber(currentMoney)) {
      alert_msg("Tiền chi phải là số")
    }
    else {
      $(".btn, .form-control").attr("disabled", true)
      $.post(
        strHref,
        {action: "pay-insert", page: page, limit: limit, startDate: startDate.val(), endDate: endDate.val(), payDriver: rider, payMoney: currentMoney, payNote: payNote.val()},
        (response, status) => {
          checkResult(response, status).then((data) => {
            payMoney.val("0")
            payNote.val("")
            content.html(data["html"])
            $("#type").val(1)
            $("#insert-pay").modal('hide')
            $(".btn, .form-control").attr("disabled", false)
          }, () => {
            $(".btn, .form-control").attr("disabled", false)
          })        
        }
      )
    }
  })

  function removeRecord(id, type) {
    global_id = id
    global_type = type
    removeModal.modal('show')
  }

  function removeSubmit() {
    $.post(
      strHref,
      {action: 'remove', id: global_id, type: global_type, page: page, limit: limit, startDate: startDate.val(), endDate: endDate.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          removeModal.modal('hide')
        })
      }
    )
  }

  function goDetail(id) {
    var from = $("#rider-detail-from-" + id).text()
    var end = $("#rider-detail-end-" + id).text()
    var date = $("#rider-detail-date-" + id).text()
    var destination = $("#rider-detail-destination-" + id ).text()
    
    riderFrom.text(from)
    riderEnd.text(end)
    riderDate.text(date)
    riderDestination.text(destination)
    riderDetail.modal('show')
  }

  function selectCustomer(id, type) {
    customerId = id
    collectCustomer.val(dbdata["customer"][id][type])
    collectCustomerInfo.text(": " + dbdata["customer"][id]["name"] + " (" + dbdata["customer"][id]["phone"] + ")")
    suggest.hide()
  }

  function selectDestination(id) {
    destinationId = id
    collectDestination.val(dbdata["remind"][id]["value"])
    suggest.hide()
  }

  function filterData() {
    $(".btn, .form-control").attr("disabled", true)
    $.post(
      strHref,
      {action: "filter_data", page: page, limit: limit, type: type.val(), startDate: startDate.val(), endDate: endDate.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
          $(".btn, .form-control").attr("disabled", false)
        }, () => {
          $(".btn, .form-control").attr("disabled", false)
        })        
      }
    )
  }

  function goPage(pPage) {
    $(".btn, .form-control").attr("disabled", true)
    $.post(
      strHref,
      {action: "filter_data", page: pPage, limit: limit, type: type.val(), startDate: startDate.val(), endDate: endDate.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          page = pPage
          content.html(data["html"])
          $(".btn, .form-control").attr("disabled", false)
        }, () => {
          $(".btn, .form-control").attr("disabled", false)
        })        
      }
    )
  }

  $("#from, #end").datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  function checkFilter() {
    return {
      from: $("#from").val(),
      end: $("#end").val()
    }
  }

  function statistic() {
    $("#statistic-modal").modal('show')
  }

  function statisticSubmit() {
    $.post(
      '',
      {action: "statistic", filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          $("#statistic-content").html(data['html'])
        }, () => { })
      }
    )
  }
</script>
<!-- END: main -->