<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="/modules/{module_file}/src/glyphicons.css">

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
            <div class="col-sm-6">
              Tên thú cưng
            </div>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="pet-name">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-6">
              Ngày sinh
            </div>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="pet-dob">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-6">
              Giống 
            </div>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="pet-species">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-6">
              Loài
            </div>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="pet-breed">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-6">
              Giới tính
            </div>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="pet-sex">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-6">
              Màu sắc
            </div>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="pet-color">
            </div>
          </label>
          
          <label class="row">
            <div class="col-sm-6">
              Microchip
            </div>
            <div class="col-sm-18">
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

  <!-- <button class="btn btn-success" onclick="addPet()">
    <span class="glyphicon glyphicon-plus">  </span>
  </button> -->
      
  <div class="row">
    <div class="col-sm-8">
      <input type="text" class="form-control" id="keyword" placeholder="Nhập từ khóa">
    </div>
    <div class="col-sm-4">
      <select class="form-control" id="limit">
        <option value="10"> 10 </option>
        <option value="20"> 20 </option>
        <option value="50"> 50 </option>
        <option value="75"> 75 </option>
        <option value="100"> 100 </option>
      </select>
    </div>
  </div>
  <label> <input type="radio" name="status" class="status" id="status-0" checked> Toàn bộ </label>
  <label> <input type="radio" name="status" class="status" id="status-1"> Chưa xác nhận </label>
  <label> <input type="radio" name="status" class="status" id="status-2"> Đã xác nhận </label>
  <button class="btn btn-info" onclick="filter()">
    <span class="glyphicon glyphicon-filter"></span>
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
    page: 1,
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

  var keyword = $("#keyword")
  var limit = $("#limit")
  var cstatus = $(".status")
  var insertPet = $("#insert-pet")
  var removetPet = $("#remove-pet")
  var petList = $("#pet-list")
  var tabber = $(".tabber")
  var ibtn = $("#ibtn")
  var ebtn = $("#ebtn")
  var maxWidth = 512
  var maxHeight = 512
  var imageType = ["jpeg", "jpg", "png", "bmp", "gif"]
  var metadata = {
    contentType: 'image/jpeg',
  };
  var file, filename

  var firebaseConfig = {
    apiKey: "AIzaSyAgxaMbHnlYbUorxXuDqr7LwVUJYdL2lZo",
    authDomain: "petcoffee-a3cbc.firebaseapp.com",
    databaseURL: "https://petcoffee-a3cbc.firebaseio.com",
    projectId: "petcoffee-a3cbc",
    storageBucket: "petcoffee-a3cbc.appspot.com",
    messagingSenderId: "351569277407",
    appId: "1:351569277407:web:8ef565047997e013"
  };
  
  firebase.initializeApp(firebaseConfig);

  var storage = firebase.storage();
  var storageRef = firebase.storage().ref();

  $("#pet-dob").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

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
      {action: 'editpet', id: global['id'], data: checkInputSet(pet), filter: checkFilter()},
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
      page: global['page'],
      limit: limit.val(),
      status: value
    }
    return data
  }

  function goPage(page) {
    global['page'] = page
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

  function filter() {
    global['page'] = 1
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
        inputSet[dataKey].val(dataSet[dataKey])
      }
    }
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

  function checkPet(id, type) {
    $.post(
      global['url'],
      {action: 'checkpet', id: id, type: type, filter: checkFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          petList.html(data['html'])
        }, () => {})
      }
    )
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
</script>
<!-- END: main -->
