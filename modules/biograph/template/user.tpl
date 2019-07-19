<!-- BEGIN: main -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>

  <style>
    label {
      width: 100%;
    }
  </style>
  <div class="container">
    <div id="remove-pet" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-body text-center">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <p>
              Xác nhận xóa?
            </p>
            <button class="btn btn-danger" onclick="removePetSubmit()">
              Xóa
            </button>
          </div>
        </div>
      </div>
    </div>


    <div id="insert-pet" class="modal fade" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-body">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <p class="text-center"> <b> Thêm thú cưng </b> </p>
            <label class="row">
              <div class="col-sm-3">
                Tên thú cưng
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-name">
              </div>
            </label>

            <label class="row">
              <div class="col-sm-3">
                Ngày sinh
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-dob">
              </div>
            </label>

            <label class="row">
              <div class="col-sm-3">
                Giống 
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-species">
              </div>
            </label>

            <label class="row">
              <div class="col-sm-3">
                Loài
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-breed">
              </div>
            </label>

            <label class="row">
              <div class="col-sm-3">
                Giới tính
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-sex">
              </div>
            </label>

            <label class="row">
              <div class="col-sm-3">
                Màu sắc
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-color">
              </div>
            </label>
            
            <label class="row">
              <div class="col-sm-3">
                Microchip
              </div>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="pet-microchip">
              </div>
            </label>

            <div class="text-center">
              <button class="btn btn-success" id="ibtn" onclick="insertPetSubmit()">
                Thêm thú cưng
              </button>
              <button class="btn btn-success" id="ebtn" onclick="editPetSubmit()" style="display: none;">
                Chỉnh sửa
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- BEGIN: nolog -->
    <ul class="nav nav-tabs">
      <li class="active"><a class="tabber tabber-1" data-toggle="tab" href="#login"> Đăng nhập </a></li>
      <li><a class="tabber tabber-0" data-toggle="tab" href="#signup"> Đăng ký </a></li>
    </ul>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Tên Đăng nhập
        </div>
        <div class="col-sm-9">
          <input type="text" class="form-control" id="username">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Mật khẩu
        </div>
        <div class="col-sm-9">
          <input type="password" class="form-control" id="password">
        </div>
      </label>
    </div>

    <div class="tab-content">
      <div id="login" class="tab-pane fade in active">
        <div class="text-center">
          <button class="btn btn-info" onclick="login()">
            Đăng nhập
          </button>
        </div>
      </div>
  
      <div id="signup" class="tab-pane fade">
        <div class="row">
          <label>
            <div class="col-sm-3">
              Xác nhận mật khẩu
            </div>
            <div class="col-sm-9">
              <input type="password" class="form-control" id="vpassword">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Họ và tên
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="fullname">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Điện thoại
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="phone">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Địa chỉ
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="address">
            </div>
          </label>
        </div>

        <div class="text-center">
          <button class="btn btn-info" id="button" onclick="signup()">
            Đăng ký
          </button>
        </div>
      </div>
    </div>    
  <!-- END: nolog -->
  <!-- BEGIN: log -->
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#profile"> Thông tin cá nhân </a></li>
    <li><a data-toggle="tab" href="#list"> Danh sách thú cưng </a></li>
    <!-- BEGIN: adminnav -->
    <li><a data-toggle="tab" href="#adminuser"> Xác nhận người dùng </a></li>
    <li><a data-toggle="tab" href="#adminpet"> Xác nhận thú cưng </a></li>
    <!-- END: adminnav -->
  </ul>

  <div class="tab-content">
    <div id="profile" class="tab-pane fade in active">
      <h2> Thông tin cá nhân </h2>
      <div style="float: left;">
        <img src="" style="width: 50px; height: 50px;">
      </div>
      <div style="float: left; margin-left: 10px;">
        <p> Tên: {fullname} </p>
        <p> Điện thoại: {mobile} </p>
        <p> Địa chỉ: {address} </p>
      </div>
    </div>
    <div id="list" class="tab-pane fade">
      <button class="btn btn-success" onclick="addPet()">
        <span class="glyphicon glyphicon-plus">  </span>
      </button>

      <div class="row">
        <div class="col-sm-4">
          <label> <input type="radio" name="status" class="status" id="status-0" checked> Toàn bộ </label>
          <label> <input type="radio" name="status" class="status" id="status-1"> Chưa xác nhận </label>
          <label> <input type="radio" name="status" class="status" id="status-2"> Đã xác nhận </label>
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="keyword" placeholder="Nhập từ khóa">
          <button class="btn btn-info" onclick="filter()">
            <span class="glyphicon glyphicon-filter"></span>
          </button>
        </div>
      </div>
      <div id="pet-list">
        {list}
      </div>
    </div>
    <!-- BEGIN: adminnav2 -->
    <div id="adminuser" class="tab-pane fade">

    </div>
    <div id="adminpet" class="tab-pane fade">

    </div>
    <!-- END: adminnav2 -->

  </div>
    
  <!-- END: log -->
</div>

<script>
  var global = {
    login: 1,
    text: ['Đăng ky', 'Đăng nhập'],
    url: '{origin}',
    id: -1
  }
  var pet = {
    name: $("#pet-name"),
    dob: $("#pet-dob"),
    species: $("#pet-species"),
    breed: $("#pet-breed"),
    sex: $("#pet-sex"),
    color: $("#pet-color"),
    microchip: $("#pet-microchip"),
  }
  var username = $("#username")
  var password = $("#password")
  var vpassword = $("#vpassword")
  var fullname = $("#fullname")
  var phone = $("#phone")
  var address = $("#address")
  var keyword = $("#keyword")
  var cstatus = $(".status")
  var button = $("#button")
  var ibtn = $("#ibtn")
  var ebtn = $("#ebtn")

  var insertPet = $("#insert-pet")
  var removetPet = $("#remove-pet")
  var petList = $("#pet-list")
  var tabber = $(".tabber")

  tabber.click((e) => {
    var className = e.currentTarget.getAttribute('class')
    global[login] = Number(splipper(className, 'tabber'))
    // button.text(global['text'][global['login']])
  })

  $("#pet-dob").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function deletePet(id) {
    global['id'] = id
    removetPet.modal('show')
  }

  function removePetSubmit() {
    $.post(
      global['url'],
      {action: 'remove', id: global['id'], filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
          removetPet.modal('hide')
        }, () => {})
      }
    )
  }

  function editPet(id) {
    $.post(
      global['url'],
      {action: 'get', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = id
          parseInputSet(data['data'])
          ibtn.hide()
          ebtn.show()
          insertPet.modal('show')
        }, () => {})
      }
    )
  }

  function editPetSubmit() {
    $.post(
      global['url'],
      {action: 'editpet', id: global['id'], data: checkInputSet(pet)},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
          clearInputSet(pet)
          insertPet.modal('hide')
        }, () => {})
      }
    )
  }

  function splipper(text, part) {
    var pos = text.search(part + '-')
    var overleft = text.slice(pos)
    if (number = overleft.search(' ') >= 0) {
      overleft = overleft.slice(0, number)
    }
    var tick = overleft.search('-')
    var result = overleft.slice(tick + 1, overleft.length)

    return result
  }

  function checkFilter() {
    var temp = cstatus.filter((index, item) => {
      return item.checked
    })
    var value = 0
    if (temp[0]) {
      value = splipper(temp[0].getAttribute('id'), 'status')
    }
    var data = {
      keyword: keyword.val(),
      status: value
    }
    return data
  }

  function filter() {
    $.post(
      global['url'],
      {action: 'filter', filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
        }, () => {})
      }
    )
  }

  function check(id, type) {
    $.post(
      global['url'],
      {action: 'check', id: id, type: type, filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
        }, () => {})
      }
    )
  }

  function login() {
    $.post(
      global['url'],
      {action: 'login', username: username.val(), password: password.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          location.reload()
        }, () => {})
      }
    )
  }

  function signup() {
    if (password.val() == vpassword.val()) {
      $.post(
        global['url'],
        {action: 'signup', username: username.val(), password: password.val(), fullname: fullname.val(), phone: phone.val(), address: address.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            location.reload()
          }, () => {})
        }
      )
    }
  }

  function addPet() {
    ibtn.show()
    ebtn.hide()
    insertPet.modal('show')
  }

  function insertPetSubmit() {
    $.post(
      global['url'],
      {action: 'insertpet', data: checkInputSet(pet)},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
          clearInputSet(pet)
          insertPet.modal('hide')
        }, () => {})
      }
    )
  }

  function clearInputSet(dataSet) {
    for (const dataKey in dataSet) {
      if (dataSet.hasOwnProperty(dataKey)) {
        dataSet[dataKey].val('')
      }
    }
  }

  function checkInputSet(dataSet) {
    var data = {}

    for (const dataKey in dataSet) {
      if (dataSet.hasOwnProperty(dataKey)) {
        const cell = dataSet[dataKey];

        data[dataKey] = cell.val()
      }
    }

    return data
  }

  function parseInputSet(dataSet) {
    for (const dataKey in dataSet) {
      if (dataSet.hasOwnProperty(dataKey)) {
        pet[dataKey].val(dataSet[dataKey])
      }
    }
  }
</script>
<!-- END: main -->
