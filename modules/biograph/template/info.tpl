<!-- BEGIN: main -->
<style>
  label {
    width: 100%;
  }
</style>

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
            <input type="text" class="form-control" id="vaccine-time" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Ngày nhắc
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="vaccine-recall" autocomplete="off">
          </div>
        </label>

        <button class="btn btn-success" onclick="insertVaccineSubmit()">
          Thêm lịch tiêm phòng
        </button>
      </div>
    </div>
  </div>
</div>


<div class="modal" id="insert-disease" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <label class="form-group">
          Ngày bệnh
          <input type="text" class="form-control" id="disease-treat" autocomplete="off">
        </label>

        <label class="form-group">
          Ngày điều trị
          <input type="text" class="form-control" id="disease-treated" autocomplete="off">
        </label>

        <!-- <label class="form-group">
          Đối tượng
          <div class="relative">
          <input type="text" class="form-control" id="disease-target">
          <div class="suggest" id="disease-suggest-target"></div>
          </div>
        </label> -->

        <label class="form-group">
          Loại bệnh
          <div class="relative">
            <input type="text" class="form-control" id="disease-disease" autocomplete="off">
            <div class="suggest" id="disease-suggest-disease"></div>
          </div>
        </label>

        <label class="form-group">
          Ghi chú
          <input type="text" class="form-control" id="disease-note">
        </label>

        <div class="tex-center">
          <button class="btn btn-success" onclick="insertDiseaseSubmit()">
            Thêm lịch sử bệnh
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="insert-breeder" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p> Thêm lịch phối giống </p>
        <label class="form-group">
          Ngày phối giống
          <input type="text" class="form-control" id="breeder-time" autocomplete="off">
        </label>
        <label class="form-group relative">
          Đối tượng phối
          <input type="text" class="form-control" id="breeder-target" autocomplete="off">
          <input type="hidden" id="breeder-targetid">
          <div class="suggest" id="breeder-suggest-target"></div>
        </label>

        <div id="breeder-child"></div>
        <button class="btn btn-success" onclick="addChild()">
          <span class="glyphicon glyphicon-plus"></span>
        </button>

        <label class="form-group">
          Ghi chú
          <input type="text" class="form-control" id="breeder-note">
        </label>

        <button class="btn btn-success" onclick="insertBreederSubmit()">
          Thêm lịch phối giống
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
            <input type="text" class="form-control" id="pet-name" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Ngày sinh
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="pet-dob" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Giống 
          </div>
          <div class="col-sm-9 relative">
            <input type="text" class="form-control" id="species-pet" autocomplete="off">
            <div class="suggest" id="species-suggest-pet"></div>
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Loài
          </div>
          <div class="col-sm-9 relative">
            <input type="text" class="form-control" id="breed-pet" autocomplete="off">
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
        </div>
      </div>
    </div>
  </div>
</div>

<div class="container" style="margin-top: 20px;">
  <a href="/biograph/">
    <img src="/modules/biograph/src/banner.png" style="width: 100px;">
  </a>
  <div style="clear: both;"></div>

  <div class="row">
    <div class="col-sm-4 thumbnail" id="avatar" style="width: 240px; height: 240px;">
    </div>
    <div class="col-sm-8">
      <p> Tên: {name} </p>
      <p> Ngày sinh: {dob} </p>
      <p> Giống: {species} </p>
      <p> Loài: {breed} </p>
      <p> Giới tính: {sex} </p>
      <p> Màu sắc: {color} </p>
      <p> microchip: {microchip} </p>
    </div>
  </div>

  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#a1"> Lịch sử phối giống </a></li>
    <li><a data-toggle="tab" href="#a2"> Lịch sử tiêm phòng </a></li>
    <li><a data-toggle="tab" href="#a3"> Lịch sử bệnh </a></li>
  </ul>

  <div class="tab-content">
    <div id="a1" class="tab-pane fade in active">
      <div id="breeder-content">
        {breeder}
      </div>
    </div>
    <div id="a2" class="tab-pane fade">
      <div id="vaccine-content">
        {vaccine}
      </div>
    </div>
    <div id="a3" class="tab-pane fade">
      <div id="disease-content">
        {disease}
      </div>
    </div>
  </div>
</div>
<script>
  var global = {
    id: '{id}',
    url: '{url}',
    child: [],
    childid: 0
  }
  var breeder = {
    time: $("#breeder-time"),
    target: $("#breeder-targetid"),
    note: $("#breeder-note"),
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
  }

  var insertBreeder = $("#insert-breeder")
  var insertDisease = $("#insert-disease")
  var insertPet = $("#insert-pet")
  var breederContent = $("#breeder-content")
  var breederChild = $("#breeder-child")
  var petVaccine = $("#pet-vaccine")
  var diseaseContent = $("#disease-content")
  var petPreview = $("#pet-preview")
  var avatar = $("#avatar")
  var diseaseTreat = $("#disease-treat")
  var diseaseTreated = $("#disease-treated")
  var diseaseDisease = $("#disease-disease")
  var diseaseNote = $("#disease-note")

  var remind = JSON.parse('{remind}')

  loadImage('{image}', avatar)

  $("#breeder-time, #pet-dob, #disease-treat, #disease-treated, #vaccine-time, #vaccine-recall").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  installRemind('target', 'breeder')
  // installRemind('target', 'disease', 0, 'pickTarget2')
  installRemind2('disease', 'disease')
  installRemindv2('pet', 'species')
  installRemindv2('pet', 'breed')

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

  function pickTarget(name, id, type = 1, index = 0) {
    if (type) {
      $("#breeder-target").val(name)
      $("#breeder-targetid").val(id)
    } else {
      $("#child-" + index).val(name)
      $("#childid-" + index).val(id)
  }
  }

  // function pickTarget2(name, id) {
  //   global['id'] = id
  //   $("#disease-target").val(name)
  // }

  function pickDisease(name) {
    diseaseDisease.val(name)
  }

  function checkChild() {
    var dat = []
    $(".child").each((index, item) => {
      var ids = item.getAttribute('id')
      var id = splipper(ids, 'child')

      dat.push({
        id: $("#childid-" + id).val(),
        name: $("#child-" + id).val()
      })
    })
    return dat
  }

  function insertPetSubmit() {
    $.post(
        global['url'],
        {action: 'insertpet', data: checkInputSet(pet)},
        (response, status) => {
      checkResult(response, status).then(data => {
        clearInputSet(pet)
        petPreview.val('')
        remind = JSON.parse(data['remind'])
        $("#child-" + global['childid']).val(data['name'])
        $("#childid-" + global['childid']).val(data['id'])
        insertPet.modal('hide')
      }, () => {
      })
    }
    )
  }

  function installRemindv2(name, type) {
    var timeout
    var input = $("#" + type + "-" + name)
    var suggest = $("#" + type + "-suggest-" + name)

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
    $("#" + type + "-" + name).val(value)
  }

  function clearInputSet(dataSet) {
    for (const dataKey in dataSet) {
      if (dataSet.hasOwnProperty(dataKey)) {
        dataSet[dataKey].val('')
      }
    }
  }

  function addBreeder() {
    insertBreeder.modal('show')
    parseChild()
  }

  function addDisease() {
    insertDisease.modal('show')
  }

  function insertBreederSubmit() {
    $.post(
        global['url'],
        {action: 'insert-breeder', data: checkInputSet(breeder), id: global['id'], child: checkChild()},
        (response, status) => {
      checkResult(response, status).then(data => {
        breederContent.html(data['html'])
        global['child'] = []
        clearInputSet(breeder)
        parseChild()
        insertBreeder.modal('hide')
      }, () => {
      })
    }
    )
  }

  function parseChild() {
    var html = ''
    var installer = []
    if (!global['child'].length) {
      global['child'] = [{
          id: 0,
          name: ''
        }]
    }

    global['child'].forEach((child, index) => {
      html += `
    <div class="relative">
      <div class="input-group">
      <input class="form-control childid-` + index + `" id="childid-` + index + `" type="hidden" value="` + child['id'] + `">
      <input class="form-control child child-` + index + `" id="child-` + index + `" type="text" value="` + child['name'] + `" autocomplete="off">
      <div class="input-group-btn">
        <button class="btn btn-success" style="height: 34px;" onclick="addPet(` + index + `)">
        <span class="glyphicon glyphicon-plus"></span>
        </button>
      </div>
      <div class="input-group-btn">
        <button class="btn btn-danger" style="height: 34px;" onclick="deleteChild(` + index + `)">
        <span class="glyphicon glyphicon-remove"></span>
        </button>
      </div>
      </div>
      <div class="suggest" id="child-suggest-` + index + `"></div>
    </div>`
      installer.push({
        type: 'child',
        name: index
      })
    })
    breederChild.html(html)
    installer.forEach((item, index) => {
      installRemind(item['name'], item['type'], index)
    })
  }

  function addChild() {
    global['child'] = checkChild()
    global['child'].push({
      id: 0,
      name: ''
    })
    parseChild()
  }

  function deleteChild(index) {
    global['child'] = global['child'].filter((item, child) => {
      return index !== child
    })
    parseChild()
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

  function addPet(id) {
    global['childid'] = id
    insertPet.modal('show')
  }

  function checkDiseaseData() {
    return {
      treat: diseaseTreat.val(),
      treated: diseaseTreated.val(),
      disease: diseaseDisease.val(),
      note: diseaseNote.val(),
    }
  }

  function checkDiseaseData() {
    return {
      treat: diseaseTreat.val(),
      treated: diseaseTreated.val(),
      disease: diseaseDisease.val(),
      note: diseaseNote.val(),
    }
  }

  function checkVaccineData() {
    return {
      type: vaccine['type'].val(),
      time: vaccine['time'] .val(),
      recall: vaccine['recall'].val()
    }
  }

  function addVaccine(id) {
    petVaccine.modal('show')
  }

  function insertVaccineSubmit() {
    $.post(
      global['url'],
      {action: 'insert-vaccine', data: checkVaccineData(), id: global['id']},
      (response, status) => {
        checkResult(response, status).then(data => {
          petVaccine.modal('hide')
        }, () => {})
      }
    )
  }


  function insertDiseaseSubmit() {
    $.post(
        global['url'],
        {action: 'insert-disease', id: global['id'], data: checkDiseaseData()},
        (response, status) => {
      checkResult(response, status).then(data => {
        diseaseContent.html(data['html'])
      }, () => {
      })
    }
    )
  }

  function installRemind(name, type, index = - 1, func = '') {
    var timeout
    var input = $("#" + type + "-" + name)
    var suggest = $("#" + type + "-suggest-" + name)

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
            global['url'],
            {action: 'target', keyword: key, index: index, func: func},
            (response, status) => {
          checkResult(response, status).then(data => {
            suggest.html(data['html'])
          }, () => {
          })
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

  function installRemind2(name, type) {
    var timeout
    var input = $("#" + type + "-" + name)
    var suggest = $("#" + type + "-suggest-" + name)

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
            global['url'],
            {action: 'disease', keyword: key},
            (response, status) => {
          checkResult(response, status).then(data => {
            suggest.html(data['html'])
          }, () => {
          })
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
            if (image.width > maxWidth)
              ratio = maxWidth / image.width;
            else if (image.height > maxHeight)
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
        }
        ;
      };

      if (imageType.indexOf(extension) >= 0) {
        reader.readAsDataURL(input.files[0]);
      }
    }
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
        }, () => {
        })
      }
      )
    })
  }

  function uploader() {
    return new Promise(resolve => {
      if (!(file || filename)) {
        resolve('')
      } else {
        var uploadTask = storageRef.child('images/' + filename).putString(file, 'base64', metadata);
        uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, // or 'state_changed'
            function (snapshot) {
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
            }, function (error) {
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
        }, function () {
          // Upload completed successfully, now we can get the download URL
          uploadTask.snapshot.ref.getDownloadURL().then(function (downloadURL) {

            file = false
            resolve(downloadURL)
            console.log('File available at', downloadURL);
          });
        });
      }
    })
  }

</script>
<!-- END: main -->
