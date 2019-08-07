<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/biograph/src/glyphicons.css">

<style>
  label {
    width: 100%;
  }
</style>

<div class="container">
  <!-- BEGIN: log -->
  <a href="/biograph/">
    <img src="/modules/biograph/src/banner.png" style="width: 200px;">
  </a>

  <div id="request-detail" class="modal fade" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body text-center">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p>
            Yêu cầu tiêm phòng, bắn chip
          </p>

          <div id="request-content"></div>
        </div>
      </div>
    </div>
  </div>

  <div id="pet-vaccine" class="modal fade" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body text-center">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p>
            Thêm lịch tiêm phòng
          </p>

          <label class="row">
            <div class="col-sm-3">
              Loại tiêm phòng
            </div>
            <div class="col-sm-9">
              <select class="form-control" id="vaccine-type">
                <option value="0"> Dại </option>
                <option value="1"> 5 Bệnh </option>
                <option value="2"> 6 Bệnh </option>
                <option value="3"> 7 Bệnh </option>
              </select>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Ngày tiêm phòng
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="vaccine-time">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Ngày nhắc
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="vaccine-recall">
            </div>
          </label>

          <button class="btn btn-success" onclick="insertVaccineSubmit()">
            Thêm lịch tiêm phòng
          </button>
        </div>
      </div>
    </div>
  </div>

  <div id="insert-user" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-body text-center">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p>
            Chỉnh sửa thông tin
          </p>

          <label class="row">
            <div class="col-sm-3">
              Tên
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-name">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Số điện thoại
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-mobile">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Địa chỉ
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-address">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Hình ảnh
            </div>
            <div class="col-sm-9">
              <div>
                <img class="img-responsive" id="user-preview" style="display: inline-block; width: 128px; height: 128px; margin: 10px;">
              </div>
              <input type="file" class="form-control" id="user-image" onchange="onselected(this, 'user')">
            </div>
          </label>

          <button class="btn btn-danger" onclick="editUserSubmit()">
            Chỉnh sửa thông tin
          </button>
        </div>
      </div>
    </div>
  </div>

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

  <div id="remove-user" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-body text-center">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p>
            Xác nhận xóa?
          </p>
          <button class="btn btn-danger" onclick="removeUserSubmit()">
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
            <div class="col-sm-9 relative">
              <input type="text" class="form-control" id="species-pet">
              <div class="suggest" id="species-suggest-pet"></div>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Loài
            </div>
            <div class="col-sm-9 relative">
              <input type="text" class="form-control" id="breed-pet">
              <div class="suggest" id="breed-suggest-pet"></div>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Giới tính
            </div>
            <div class="col-sm-9">
              <label>
                <input type="radio" name="sex" id="pet-sex-0" checked> Giống đực
              </label>
              <label>
                <input type="radio" name="sex" id="pet-sex-1"> Giống cái
              </label>
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

          <label class="row">
            <div class="col-sm-3">
              Xăm tai
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="pet-miear">
            </div>
          </label>

          <div class="row">
            <div class="col-sm-6">
              Chó cha
              <div class="relative">
                <div class="input-group">
                  <input class="form-control" id="parent-m" type="text" autocomplete="off">
                  <input class="form-control" id="parent-m-s" type="hidden">
                  <div class="input-group-btn">
                    <button class="btn btn-success" style="height: 34px;" onclick="addParent('m')">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="parent-suggest-m"></div>
              </div>
            </div>

            <div class="col-sm-6">
              Chó mẹ
              <div class="relative">
                <div class="input-group">
                  <input class="form-control" id="parent-f" type="text" autocomplete="off">
                  <input class="form-control" id="parent-f-s" type="hidden">
                  <div class="input-group-btn relative">
                    <button class="btn btn-success" style="height: 34px;" onclick="addParent('f')">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="parent-suggest-f"></div>
              </div>
            </div>
          </div>

                    
          <label class="row">
            <div class="col-sm-3">
              Hình ảnh
            </div>
            <div class="col-sm-9">
              <div>
                <img class="img-responsive" id="pet-preview" style="display: inline-block; width: 128px; height: 128px; margin: 10px;">
              </div>
              <input type="file" class="form-control" id="user-image" onchange="onselected(this, 'pet')">
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

  <div id="insert-parent" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-body">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p class="text-center"> <b> Thêm cha mẹ </b> </p>
          <label class="row">
            <div class="col-sm-3">
              Tên thú cưng
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="parent-name">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Ngày sinh
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="parent-dob">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Giống 
            </div>
            <div class="col-sm-9 relative">
              <input type="text" class="form-control" id="species-parent">
              <div class="suggest" id="species-suggest-parent"></div>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Loài
            </div>
            <div class="col-sm-9 relative">
              <input type="text" class="form-control" id="breed-parent">
              <div class="suggest" id="breed-suggest-parent"></div>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Giới tính
            </div>
            <div class="col-sm-9">
              <label>
                <input type="radio" name="psex" id="parent-sex-0" checked> Giống đực
              </label>
              <label>
                <input type="radio" name="psex" id="parent-sex-1"> Giống cái
              </label>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Màu sắc
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="parent-color">
            </div>
          </label>
          
          <label class="row">
            <div class="col-sm-3">
              Microchip
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="parent-microchip">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Xăm tai
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="parent-miear">
            </div>
          </label>
                    
          <label class="row">
            <div class="col-sm-3">
              Hình ảnh
            </div>
            <div class="col-sm-9">
              <div>
                <img class="img-responsive" id="parent-preview" style="display: inline-block; width: 128px; height: 128px; margin: 10px;">
              </div>
              <input type="file" class="form-control" id="user-image" onchange="onselected(this, 'parent')">
            </div>
          </label>

          <div class="text-center">
            <button class="btn btn-success" onclick="insertParentSubmit()">
              Thêm thú cưng
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div style="float: right;">
    <a href="/biograph/logout"> Đăng xuất </a>
  </div>

  <h2> Thông tin cá nhân </h2>
  <div style="float: left;">
    <img src="{image}" style="width: 128px; height: 128px;">
  </div>
  <div style="float: left; margin-left: 10px;">
    <p> Tên: {fullname} </p>
    <p> Điện thoại: {mobile} </p>
    <p> Địa chỉ: {address} </p>

    <button class="btn btn-info" onclick="editUser({userid})">
      Chỉnh sửa thông tin
    </button>

    <!-- BEGIN: center -->
    <button class="btn btn-info" onclick="center()">
      Đăng ký trại
    </button>
    <!-- END: center -->
    <!-- BEGIN: xcenter -->
    <button class="btn btn-success btn-xs">
      Đã đăng ký trại
    </button>
    <!-- END: xcenter -->
  </div>
  <div style="clear: left;"></div>
  <h2> Danh sách thú cưng </h2>

  <button class="btn btn-success" onclick="addPet()">
    <span class="glyphicon glyphicon-plus">  </span>
  </button>
  
  <div id="pet-list">
    {list}
  </div>
</div>

<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase-storage.js"></script>
<script>
  var global = {
    login: 1,
    text: ['Đăng ky', 'Đăng nhập'],
    url: '{origin}',
    id: -1,
    parent: 'm'
  }
  var vaccine = {
    type: $("#vaccine-type"),
    time: $("#vaccine-time"),
    recall: $("#vaccine-recall")
  }
  var pet = {
    name: $("#pet-name"),
    dob: $("#pet-dob"),
    species: $("#species-pet"),
    breed: $("#breed-pet"),
    sex0: $("#pet-sex-0"),
    sex1: $("#pet-sex-1"),
    color: $("#pet-color"),
    microchip: $("#pet-microchip"),
    miear: $("#pet-miear"),
    parentm: $("#parent-m-s"),
    parentf: $("#parent-f-s")
  }
  var parent = {
    name: $("#parent-name"),
    dob: $("#parent-dob"),
    sex0: $("#parent-sex-0"),
    sex1: $("#parent-sex-1"),
    color: $("#parent-color"),
    microchip: $("#parent-microchip"),
    miear: $("#pet-miear"),
    species: $("#species-parent"),
    breed: $("#breed-parent")
  }
  var user = {
    fullname: $("#user-name"),
    mobile: $("#user-mobile"),
    address: $("#user-address")
  }
  var userImage = $("#user-image")
  var userPreview = $("#user-preview")
  var petPreview = $("#pet-preview")
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
  var insertUser = $("#insert-user")
  var insertParent = $("#insert-parent")
  var petVaccine = $("#pet-vaccine")
  var requestContent = $("#request-content")
  var requestDetail = $("#request-detail")
  var removetPet = $("#remove-pet")
  var removetUser = $("#remove-user")
  var petList = $("#pet-list")
  var userList = $("#user-list")
  var tabber = $(".tabber")
  var maxWidth = 512
  var maxHeight = 512
  var imageType = ["jpeg", "jpg", "png", "bmp", "gif"]
  var metadata = {
    contentType: 'image/jpeg',
  };
  var file, filename
  remind = JSON.parse('{remind}')
  var thumbnail
  var canvas = document.createElement('canvas')

  var thumbnailImage = new Image()
  thumbnailImage.src = '/modules/biograph/src/thumbnail.jpg'
  thumbnailImage.onload = (e) => {
    var context = canvas.getContext('2d')
    var width = thumbnailImage.width
    var height = thumbnailImage.height
    var x = width
    if (height > width) {
      x = height
    }
    var rate = 256 / x
    canvas.width = rate * width
    canvas.height = rate * height

    context.drawImage(thumbnailImage, 0, 0, width, height, 0, 0, canvas.width, canvas.height)
    thumbnail = canvas.toDataURL("image/jpeg")
  }

  var firebaseConfig = {
  apiKey: "AIzaSyDWt6y4laxeTBq2RYDY6Jg4_pOkdxwsjUE",
  authDomain: "directed-sonar-241507.firebaseapp.com",
  databaseURL: "https://directed-sonar-241507.firebaseio.com",
  projectId: "directed-sonar-241507",
  storageBucket: "directed-sonar-241507.appspot.com",
  messagingSenderId: "816396321770",
  appId: "1:816396321770:web:193e84ee21b16d41"
  };

  firebase.initializeApp(firebaseConfig);

  var storage = firebase.storage();
  var storageRef = firebase.storage().ref();
  
  tabber.click((e) => {
    var className = e.currentTarget.getAttribute('class')
    global[login] = Number(splipper(className, 'tabber'))
    // button.text(global['text'][global['login']])
  })

  $("#pet-dob, #parent-dob, #vaccine-time, #vaccine-recall").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  $(this).ready(() => {
    installRemind('m', 'parent')
    installRemind('f', 'parent')
    installRemindv2('pet', 'species')
    installRemindv2('pet', 'breed')
    installRemindv2('parent', 'species')
    installRemindv2('parent', 'breed')
  })

  function request(id) {
    $.post(
      global['url'],
      {action: 'get-request', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          requestContent.html(data['html'])
          requestDetail.modal('show')
        }, () => {})
      }
    )
  }

  function requestSubmit(id, type) {
    $.post(
      global['url'],
      {action: 'request', id: id, type: type},
      (response, status) => {
        checkResult(response, status).then(data => {
          requestContent.html(data['html'])
        }, () => {})
      }
    )
  }

  function cancelSubmit(id, type) {
    $.post(
      global['url'],
      {action: 'cancel', id: id, type: type},
      (response, status) => {
        checkResult(response, status).then(data => {
          requestContent.html(data['html'])
        }, () => {})
      }
    )
  }

  function addVaccine(id) {
    global['id'] = id
    petVaccine.modal('show')
  }

  function insertVaccineSubmit() {
    $.post(
      global['url'],
      {action: 'insert-vaccine', data: checkInputSet(vaccine), id: global['id']},
      (response, status) => {
        checkResult(response, status).then(data => {
          petVaccine.modal('hide')
        }, () => {})
      }
    )
  }

  function addParent(name) {
    insertParent.modal('show')
    global['parent'] = name
    clearInputSet(parent)
    petPreview.val('')
    $("#parent" + global['parent']).val('')
    $("#parent" + global['parent' + '-s']).val(0)
  }

  function insertParentSubmit() {
    uploader().then((imageUrl) => {
      $.post(
        global['url'],
        {action: 'insert-parent', id: global['id'], data: checkInputSet(parent), image: imageUrl},
        (response, status) => {
          checkResult(response, status).then(data => {
            petList.html(data['html'])
            clearInputSet(parent)
            petPreview.val('')
            remind = JSON.parse(data['remind'])
            insertParent.modal('hide')
            $("#parent-" + global['parent']).val(data['name'])
            $("#parent-" + global['parent'] + '-s').val(data['id'])
          }, () => {})
        }
      )
    })
  }

  function pickParent(e, name, id) {
    var idp = splipper(e.parentNode.getAttribute('id'), 'parent-suggest')
    $('#parent-' + idp + '-s').val(id)
    $('#parent-' + idp).val(name)
  }

  function installRemind(name, type) {
    var timeout
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-suggest-" + name)

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
          global['url'],
          {action: 'parent', keyword: key},
          (response, status) => {
            checkResult(response, status).then(data => {
              suggest.html(data['html'])
            }, () => {})
          }
        )
        
        suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 200);
    })
  }

  function installRemindv2(name, type) {
    var timeout
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-suggest-" + name)

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''
        
        for (const index in remind[type]) {
          if (remind[type].hasOwnProperty(index)) {
            const element = paintext(remind[type][index]['name']);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest_item" onclick="selectRemindv2(\'' + name + '\', \'' + type + '\', \'' + remind[type][index]['name'] + '\')"><p class="right-click">' + remind[type][index]['name'] + '</p></div>'
            }
          }
        }
        suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 200);
    })
  }

  function selectRemindv2(name, type, value) {
    $("#"+ type +"-" + name).val(value)
  }

  function center() {
    $.post(
      global['url'],
      {action: 'center'},
      (response, status) => {
        checkResult(response, status).then(data => {
          window.location.reload()
        }, () => {})
      }
    )
  }

  function onselected(input, previewname) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      var fullname = input.files[0].name
      var name = Math.round(new Date().getTime() / 1000) + '_' + fullname.substr(0, fullname.lastIndexOf('.'))
      var extension = fullname.substr(fullname.lastIndexOf('.') + 1)
      filename = name + '.' + extension
      
      reader.onload = function (e) {
        var type = e.target["result"].split('/')[1].split(";")[0];
        if (["jpeg", "jpg", "png", "bmp", "gif"].indexOf(type) >= 0) {
          var image = new Image();
          image.src = e.target["result"];
          image.onload = (e2) => {
            var c = document.createElement("canvas")
            var ctx = c.getContext("2d");
            var ratio = 1;
            if(image.width > maxWidth)
              ratio = maxWidth / image.width;
            else if(image.height > maxHeight)
              ratio = maxHeight / image.height;
            c.width = image["width"];
            c.height = image["height"];
            ctx.drawImage(image, 0, 0);
            var cc = document.createElement("canvas")
            var cctx = cc.getContext("2d");
            cc.width = image.width * ratio;
            cc.height = image.height * ratio;
            cctx.fillStyle = "#fff";
            cctx.fillRect(0, 0, cc.width, cc.height);
            cctx.drawImage(c, 0, 0, c.width, c.height, 0, 0, cc.width, cc.height);
            file = cc.toDataURL("image/jpeg")
            $("#" + previewname + "-preview").attr('src', file)
            file = file.substr(file.indexOf(',') + 1);
          }
        };
      };

      if (imageType.indexOf(extension) >= 0) {
        reader.readAsDataURL(input.files[0]);
      }
    }
	}

  // function preview() {
  //   var file = userImage[0]['files']
  //   if (file && file[0]) {
  //     var reader = new FileReader();
  //     reader.readAsDataURL(file[0]);  
  //     reader.onload = (e) => {
  //       var type = e.target["result"].split('/')[1].split(";")[0];
  //       if (["jpeg", "jpg", "png", "bmp", "gif"].indexOf(type) >= 0) {
  //         cc.width = image.width * ratio;
  //         cc.height = image.height * ratio;
  //         cctx.fillStyle = "#fff";
  //         cctx.fillRect(0, 0, cc.width, cc.height);
  //         cctx.drawImage(c, 0, 0, c.width, c.height, 0, 0, cc.width, cc.height);
  //         var base64Image = cc.toDataURL("image/jpeg");
  //         this.post.image.push(base64Image)
  //       }
  //     }
  //   }
  // }

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
          parseInputSet(data['data'], pet)
          $("#parent-f").val(data['more']['f'])
          $("#parent-m").val(data['more']['m'])
          $("#pet-sex-" + data['more']['sex']).prop('checked', true)
          var image = new Image()
          image.src = data['image']
          petPreview.attr('src', thumbnail)
          image.addEventListener('load', (e) => {
            petPreview.attr('src', image.src)
          })

          ibtn.hide()
          ebtn.show()
          insertPet.modal('show')
        }, () => {})
      }
    )
  }

  function editPetSubmit() {
    uploader().then((imageUrl) => {
      $.post(
        global['url'],
        {action: 'editpet', id: global['id'], data: checkInputSet(pet), image: imageUrl},
        (response, status) => {
          checkResult(response, status).then(data => {
            petList.html(data['html'])
            clearInputSet(pet)
            $("#parent-m").val('')
            $("#parent-f").val('')
            petPreview.val('')
            remind = JSON.parse(data['remind'])
            insertPet.modal('hide')
          }, () => {})
        }
      )
    })
  }

  function splipper(text, part) {
    var pos = text.search(part + '-')
    var overleft = text.slice(pos)
    if (number = overleft.search(' ') >= 0) {
      overleft = overleft.slice(0, number)
    }
    var tick = overleft.lastIndexOf('-')
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

  function addPet() {
    ibtn.show()
    ebtn.hide()
    insertPet.modal('show')
    clearInputSet(pet)
    $("#parent-m").val('')
    $("#parent-f").val('')
    petPreview.attr('src', thumbnail)
  }

  function insertPetSubmit() {
    $.post(
      global['url'],
      {action: 'insertpet', data: checkInputSet(pet)},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
          clearInputSet(pet)
          $("#parent-m").val('')
          $("#parent-f").val('')
          petPreview.val('')
          remind = JSON.parse(data['remind'])
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

  function parseInputSet(dataSet, inputSet) {
    for (const dataKey in dataSet) {
      if (dataSet.hasOwnProperty(dataKey)) {
        inputSet[dataKey].val(dataSet[dataKey])
      }
    }
  }

  function editUser(id) {
    $.post(
      global['url'],
      {action: 'getuser', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = id
          parseInputSet(data['data'], user)
          var image = new Image()
          image.src = data['image']
          image.addEventListener('load', (e) => {
            userPreview.attr('src', image.src)
          })
          insertUser.modal('show')
        }, () => {})
      }
    )
  }

  function editUserSubmit() {
    uploader().then((imageUrl) => {
      $.post(
        global['url'],
        {action: 'edituser', data: checkInputSet(user), image: imageUrl, id: global['id'], filter: checkUserFilter()},
        (response, status) => {
          checkResult(response, status).then(data => {
            userList.html(data['html'])
            clearInputSet(pet)
            insertUser.modal('hide')
            window.location.reload()
          }, () => {})
        }
      )
    })
  }

  function uploader() {
    return new Promise(resolve => {
      if (!(file || filename)) {
        resolve('')
      }
      else {
        var uploadTask = storageRef.child('images/' + filename).putString(file, 'base64', metadata);
        uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, // or 'state_changed'
          function(snapshot) {
            var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
            switch (snapshot.state) {
              case firebase.storage.TaskState.PAUSED: // or 'paused'
                console.log('Upload is paused');
                break;
              case firebase.storage.TaskState.RUNNING: // or 'running'
                console.log('Upload is running');
                break;
            }
          }, function(error) {
            resolve('')
            switch (error.code) {
              case 'storage/unauthorized':
                // User doesn't have permission to access the object
              break;
              case 'storage/canceled':
                // User canceled the upload
              break;
              case 'storage/unknown':
                // Unknown error occurred, inspect error.serverResponse
              break;
            }
          }, function() {
            // Upload completed successfully, now we can get the download URL
            uploadTask.snapshot.ref.getDownloadURL().then(function(downloadURL) {

            file = false
            resolve(downloadURL)
            console.log('File available at', downloadURL);
          });
        });
      }
    })
	}

  // function editPetSubmit() {
  //   $.post(
  //     global['url'],
  //     {action: 'editpet', id: global['id'], data: checkInputSet(pet)},
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         petList.html(data['html'])
  //         clearInputSet(user)
  //         insertUser.modal('hide')
  //       }, () => {})
  //     }
  //   )
  // }

  function checkUserFilter() {
    var temp = $(".user-status").filter((index, item) => {
      return item.checked
    })
    var value = 0
    if (temp[0]) {
      value = splipper(temp[0].getAttribute('id'), 'user-status')
    }
    var data = {
      keyword: $("#user-keyword").val(),
      status: value
    }
    return data
  }

  function deleteUser(id) {
    global['id'] = id
    removetUser.modal('show')
  }

  function removeUserSubmit() {
    $.post(
      global['url'],
      {action: 'removeuser', id: global['id'], filter: checkUserFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
          removetUser.modal('hide')
        }, () => {})
      }
    )
  }

  function checkUser(id, type) {
    $.post(
      global['url'],
      {action: 'checkuser', id: id, type: type, filter: checkUserFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          userList.html(data['html'])
        }, () => {})
      }
    )
  }

  function filterUser() {
    $.post(
      global['url'],
      {action: 'filteruser', filter: checkUserFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          userList.html(data['html'])
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
