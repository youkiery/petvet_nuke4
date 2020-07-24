<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<style>
  .green {
    background: lightgreen;
  }

  .red {
    background: pink;
  }

  #image {
    font-size: 32px;
    line-height: 64px;
    color: green;
    top: 0;
    left: 0;
    border: 1px solid lightgray;
    border-radius: 10px;
  }

  .zimage {
    position: absolute;
    width: 64px;
    height: 64px;
    border: 1px solid lightgray;
    border-radius: 10px;
  }

  .zimage:hover {
    background: url('/assets/images/big_close.png');
    cursor: pointer;
    z-index: 10px;
  }

  .box-list {
    margin: auto;
    text-align: center;
    width: fit-content;
  }

  .box {
    position: relative;
    margin: 4px;
    float: left;
    width: 64px;
    height: 64px;
  }

  .box img {
    width: 64px;
    height: 64px;
    position: absolute;
    top: 0;
    left: 0;
  }
</style>

<div id="msgshow" class="msgshow"></div>

{modal}

<div class="form-group" style="float: right;">
  <button class="btn btn-success" onclick="insertXray()">
    Thêm phiếu
  </button>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script src="/modules/core/js/vimage.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase-storage.js"></script>
<script>
  var global = {
    id: 0,
    index: 0,
    list: []
  }
  var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
  var blur = true;
  var g_customer = -1;
  var customer_data = [];
  var customer_list = [];
  var g_index = -1
  var customer_name = document.getElementById("customer_name");
  var customer_phone = document.getElementById("customer_phone");
  var customer_address = document.getElementById("customer_address");
  var pet_info = document.getElementById("pet_info");
  var pet_note = document.getElementById("pet_note");
  var suggest_name = document.getElementById("customer_name_suggest");
  var suggest_phone = document.getElementById("customer_phone_suggest");

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
  var metadata = {
    contentType: 'image/jpeg',
  };

  $(document).ready(() => {
    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
    vremind.install('#customer_name', '#customer_name_suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'get-customer', key: input, type: 0 }).then(data => {
          resolve(data['list'])
        })
      })
    }, 300, 300)
    vremind.install('#customer_phone', '#customer_phone_suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'get-customer', key: input, type: 1 }).then(data => {
          resolve(data['list'])
        })
      })
    }, 300, 300)
    vimage.install('image', 960, 960, (list) => { parseImage('image') })
    $('#image-input').hide()
  })

  function setcustom(name, phone, pet) {
    $("#customer_name").val(name)
    $("#customer_phone").val(phone)
    $("#pet_info").html(pet)
  }

  function parseImage(name) {
    html = ''
    vimage['data'][name] = vimage['data'][name].filter(item => {
      return item.length > 10
    })
    global['list'][global['index']][image] = vimage['name']
    vimage['data'][name].forEach((item, index) => {
      html += `
      <div class="box">
        <img class="image" src="`+ item + `">
        <div class="zimage" onclick="removeImage(`+ index + `, \'` + name + `\')"></div>
      </div>`
    })
    $('#' + name + '-list').html(html)
  }

  function removeImage(remove_index, name) {
    vimage['data'][name] = vimage['data'][name].filter((item, index) => {
      return index !== remove_index
    })
    parseImage(name)
  }

  function checkXray() {
    data = {
      pet: $('#pet_info').val(),
      cometime: $('#cometime').val(),
      temperate: $('#temperate').val(),
      eye: $('#eye').val(),
      other: $('#other').val(),
      treating: $('#treating').val(),
      doctor: $('#doctor').val(),
      condition: $('#condition').val()
    }
    if (!data['pet']) {
      return "Khách hàng chưa có thú cưng!"
    }
    return data
  }

  function clearXray() {
    g_customer = 0
    $('#customer_name').val('')
    $('#customer_phone').val('')
    $('#customer_address').val('')
    $('#pet_info').html('')
    $('#temperate').val('')
    $('#eye').val('')
    $('#other').val('')
    $('#treating').val('')
  }

  function insertXray() {
    clearXray()
    $('.insult').prop('disabled', false)
    $('.insert').show()
    $('.edit').hide()
    $('#insert-modal').modal('show')
  }

  function insertXraySubmit() {
    sdata = checkXray()
    if (!sdata['pet']) {
      alert_msg(msg)
    } else {
      vhttp.checkelse('', { action: 'insert-xray', data: sdata }).then(data => {
        $('#content').html(data['html'])
        $('#insert-modal').modal('hide')
      })
    }
    return false;
  }

  function parseTreat() {
    html = ''
    global['list'].forEach((item, index) => {
      time = new Date(item['time'] * 1000)
      html += `
      <button class="btn btn-info btn-xs treat" id="treat-`+ index + `" onclick="changeTreat(` + index + `)">
        `+ (time.getDate() + '/' + (time.getMonth() + 1) + '/' + time.getFullYear()) + `
      </button>`
    })
    $('#treat-list').html(html)
  }

  function insertTreat() {
    last = global['list'].length - 1
    last_treat = global['list'][last]
    vhttp.checkelse('', { action: 'insert-treat', id: global['id'], doctor: $('#doctor').val(), condition: $('#condition').val() }).then(data => {
      global['list'].push(data['data'])
      parseTreat()
      selectTreat(last + 1)
    })
  }

  function selectTreat(index) {
    global['index'] = index
    $('.treat').attr('class', 'btn btn-info btn-xs treat')
    $('#treat-' + index).attr('class', 'btn btn-default btn-xs treat')

    treat = global['list'][index]
    $('#temperate').val(treat['temperate'])
    $('#eye').val(treat['eye'])
    $('#other').val(treat['other'])
    $('#treating').val(treat['treating'])
    $('#doctor').val(treat['doctor'])
    $('#condition').val(treat['condition'])
    vimage['data']['image'] = treat['image']
    parseImage('image')
  }

  function changeTreat(index) {
    // lưu giá trị
    global['list'][global['index']] = {
      id: global['list'][global['index']]['id'],
      condition: $('#condition').val(),
      doctor: $('#doctor').val(),
      temperate: $('#temperate').val(),
      other: $('#other').val(),
      eye: $('#eye').val(),
      treating: $('#treating').val(),
      time: global['list'][global['index']]['time'],
      image: vimage.data['image'],
    }
    selectTreat(index)
    treat = global['list'][index]

    $('#temperate').val(treat['temperate'])
    $('#eye').val(treat['eye'])
    $('#other').val(treat['other'])
    $('#treating').val(treat['treating'])
  }

  function edit(lid) {
    vhttp.checkelse('', { action: 'get-info', id: lid }).then(data => {
      $('#image').show()
      global['id'] = lid
      if (Number(data['data']['insult'])) {
        $('#image').hide()
        $('.insult').prop('disabled', true)
      }
      else $('.insult').prop('disabled', false)
      clearXray()
      $("#edit-pet").text(data['data']["pet"])
      $("#edit-customer").text(data['data']["name"])
      $("#edit-phone").text(data['data']["phone"])
      $("#edit-cometime").text(data['data']["cometime"])
      $("#edit-doctor").val(data['data']["doctorid"])
      last = data['data']['list'].length - 1
      global['list'] = data['data']['list']
      parseTreat()
      selectTreat(last)
      $('.insert').hide()
      $('.edit').show()
      $('#insert-modal').modal('show')
    })
  }

  function editSubmit(type) {
    changeTreat(global['index'])
    current = global['list'][global['index']]

    checkUploadImage(current['image']).then(() => {
      vhttp.checkelse('', { action: 'edit', id: global['id'], type: type, data: current }).then(data => {
        $('#content').html(data['html'])
        if (type) $('#insert-modal').modal('hide')
        else alert_msg('Đã lưu')
      })
    })
  }

  function checkUploadImage(images) {
    return new Promise((resolve) => {
      if (!images.length) resolve()
      count = 0
      images.forEach((image, image_index) => {
        if (image.length > 5000) {
          count++
          uploadImages(image, image_index).then((url) => {
            global['list'][global['index']]['image'][image_index] = url
            count--
            if (count == 0) {
              resolve()
            }
          })
        }
      })
    })
  }

  function uploadImages(image_base64, image_index) {
    return new Promise(resolve => {
      base64 = image_base64.substr(image_base64.indexOf(',') + 1);
      var uploadTask = storageRef.child('images/' + new Date().getTime() + '-' + image_index + '.jpg').putString(base64, 'base64', metadata);
      uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, // or 'state_changed'
        function (snapshot) {
          var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          // console.log('Upload is ' + progress + '% done', image_index);
        }, function (error) {
          resolve("")
        }, function () {
          uploadTask.snapshot.ref.getDownloadURL().then(function (downloadURL) {
            resolve(downloadURL)
          });
        });
    })
  }
</script>
<!-- END: main -->