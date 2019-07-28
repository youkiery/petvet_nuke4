<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/biograph/src/glyphicons.css">

<style>
  label {
    width: 100%;
  }
</style>

<div class="container">
  <!-- BEGIN: log -->
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
                <img class="img-responsive" id="user-preview" style="display: inline-block; height: 128px; margin: 10px;">
              </div>
              <input type="file" class="form-control" id="user-image" onchange="onselected(this)">
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

          <div class="row">
            <div class="col-sm-6">
              Chó cha
              <div class="relative">
                <input class="form-control" id="parent-m" type="text">
                <div class="suggest" id="parent-suggest-m"></div>
              </div>
            </div>
            <div class="col-sm-6">
              Chó mẹ
              <div class="relative">
                <input class="form-control" id="parent-f" type="text">
                <div class="suggest" id="parent-suggest-f"></div>
              </div>
            </div>
          </div>

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

    <button class="btn btn-info">
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
    parentm: $("#parent-m"),
    parentf: $("#parent-f"),
  }
  var user = {
    fullname: $("#user-name"),
    mobile: $("#user-mobile"),
    address: $("#user-address")
  }
  var userImage = $("#user-image")
  var userPreview = $("#user-preview")
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

  $("#pet-dob").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  $(this).ready(() => {
    installRemind('m', 'parent')
    installRemind('f', 'parent')
  })

  function pickParent(e, id) {
    var idp = splipper(e.parentNode.getAttribute('id'), 'parent-suggest')
    $('#parent-' + idp).val(id)
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

  function onselected(input) {
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
            userPreview.attr('src', file)
            file = file.substr(file.indexOf(',') + 1);
          }
        };
      };

      if (imageType.indexOf(extension) >= 0) {
        reader.readAsDataURL(input.files[0]);
      }
    }
	}


  function preview() {
    var file = userImage[0]['files']
    if (file && file[0]) {
      var reader = new FileReader();
      reader.readAsDataURL(file[0]);  
      reader.onload = (e) => {
        var type = e.target["result"].split('/')[1].split(";")[0];
        if (["jpeg", "jpg", "png", "bmp", "gif"].indexOf(type) >= 0) {
          cc.width = image.width * ratio;
          cc.height = image.height * ratio;
          cctx.fillStyle = "#fff";
          cctx.fillRect(0, 0, cc.width, cc.height);
          cctx.drawImage(c, 0, 0, c.width, c.height, 0, 0, cc.width, cc.height);
          var base64Image = cc.toDataURL("image/jpeg");
          this.post.image.push(base64Image)
        }
      }
    }
  }

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

  function parseInputSet(dataSet, inputSet) {
    for (const dataKey in dataSet) {
      if (dataSet.hasOwnProperty(dataKey)) {
        console.log(dataKey)
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
