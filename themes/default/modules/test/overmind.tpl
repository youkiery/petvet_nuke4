<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div class="msgshow" id="msgshow"></div>

<div id="vaccine_recall" class="modal fade" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"> Xác nhận ngày tái chủng </h4>
        </div>
        <div class="modal-body">
          <div class="form-group">
                <label> Ngày tái chủng </label>
                <input type="text" class="form-control" id="vaccine_time">
              </div>
              <div class="form-group">
                <label>{lang.doctor}</label>
                <select class="form-control" id="vaccine_doctor">
                  <!-- BEGIN: doctor -->
                  <option value="{doctor_id}">
                    {doctor_name}
                  </option>
                  <!-- END: doctor -->
                </select>      
              </div>
              <div class="form-group text-center">
                <button class="btn btn-info" id="vaccine_button" onclick="save_form()">
                  Lưu tái chủng
                </button>
              </div>
        </div>
      </div>
    </div>
  </div>

<div>
    <div class="form-group">
        <label> Từ khóa </label>
        <input class="form-control" id="keyword" type="text">
      </div>
      <div class="form-group">
        <label> Từ ngày </label>
        <input class="form-control" id="fromtime" type="text" value="{fromtime}">
      </div>
      <div class="form-group">
        <label> Đến ngày </label>
        <input class="form-control" id="totime" type="text" value="{totime}">
      </div>
      <button class="btn btn-info" id="filter">
        Lọc danh sách
      </button>
</div>

<div>
  <button class="filter-button btn btn-info active" id="vaccine">
    Tiêm phòng
  </button>
  <button class="filter-button btn btn-info" id="usg">
    Siêu âm
  </button>
  <button class="filter-button btn btn-info" id="birth">
    Tiêm phòng siêu âm
  </button>
</div>

<div id="content">
  {content}
</div>

<script>
  var keyword = $("#keyword");
  var fromtime = $("#fromtime");
  var totime = $("#totime");
  var vaccine = $("#vaccine");
  var usg = $("#usg");
  var birth = $("#birth");
  var content = $("#content");
  var filter = $("#filter");
  var filterButton = $(".filter-button")
  var position = 0
  filter.click(() => {
    var signal = "remind_vaccine"
    switch (position) {
      case 1:
        signal = "remind_usg"        
        break;
      case 2:
        signal = "remind_birth"        
        break;
    }
    $.post(
      strHref,
      {action: signal, keyword: keyword.text(), fromtime: fromtime.text(), totime: totime.text()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
        }, () => {})
      }
    )
  })
  filterButton.click(() => {
    filterButton.removeClass("active")
    $(this).addClass("active")
  })
  vaccine.click(() => {
    $.post(
      strHref,
      {action: "remind_vaccine", keyword: keyword.text(), fromtime: fromtime.text(), totime: totime.text()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
          
        }, () => {})
      }
    )
  })
  usg.click(() => {
    $.post(
      strHref,
      {action: "remind_usg", keyword: keyword.text(), fromtime: fromtime.text(), totime: totime.text()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
        }, () => {})
      }
    )
  })
  birth.click(() => {
    $.post(
      strHref,
      {action: "remind_birth", keyword: keyword.text(), fromtime: fromtime.text(), totime: totime.text()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
        }, () => {})
      }
    )
  })
  function checkResult(response, status) {
    return new Promise((resolve, reject) => {
      if (status === 'OK') {
        try {
          data = JSON.parse(response)
          if (data["status"]) {
            resolve(data)          
          }
          else {
            throw "error"
          }
        }
        catch (e) {
          alert_msg("Có lỗi xảy ra")
          reject()
        }
      }
    })
  }
</script>
<!-- END: main --> 