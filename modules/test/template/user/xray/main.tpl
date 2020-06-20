<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<style>
  .pink {
    background: lightgreen;
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

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-1,
  .col-2,
  .col-3,
  .col-4,
  .col-5,
  .col-6,
  .col-7,
  .col-8,
  .col-9,
  .col-10,
  .col-11,
  .col-12 {
    float: left;
  }

  .col-1 {
    width: 8.33%;
  }

  .col-2 {
    width: 16.66%;
  }

  .col-3 {
    width: 25%;
  }

  .col-4 {
    width: 33.33%;
  }

  .col-5 {
    width: 41.66%;
  }

  .col-6 {
    width: 50%;
  }

  .col-7 {
    width: 58.33%;
  }

  .col-8 {
    width: 66.66%;
  }

  .col-9 {
    width: 75%;
  }

  .col-10 {
    width: 83.33%;
  }

  .col-11 {
    width: 91.66%;
  }

  .col-12 {
    width: 100%;
  }
</style>

<div id="msgshow" class="msgshow"></div>

{modal}

<div class="form-group" style="float: right;">
  <button class="btn btn-success" onclick="insertXray()">
    Thêm X-Quang
  </button>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
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
    vimage.install('image', 960, 960, (list) => { parseImage(list, 'image') })
    $('#image-input').hide()
  })

  function parseImage(list, name) {
    html = ''
    list.forEach((item, index) => {
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
    parseImage(vimage['data'][name], name)
  }

  function checkXray() {
    data = {
      pet: $('#pet_info').val(),
      cometime: $('#cometime').val(),
      temperate: $('#temperate').val(),
      eye: $('#eye').val(),
      other: $('#other').val(),
      treating: $('#treating2').val(),
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
    global['list'].push({
      id: 0,
      condition: last_treat['condition'],
      doctor: last_treat['doctor'],
      temperate: '',
      other: '',
      eye: '',
      treating: '',
      time: last_treat['time'] + 60 * 60 * 24,
      image: vimage['data']['image'],
    })
    parseTreat()
    selectTreat(last + 1)
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
    parseImage(vimage['data']['image'], 'image')
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
      image: [],
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
      global['id'] = lid
      if (data['data']['insult']) $('.insult').prop('disabled', true)
      else $('.insult').prop('disabled', false)
      clearXray()
      $("#edit-pet").text(data['data']["pet"])
      $("#edit-customer").text(data['data']["customer"])
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

  function summary() {
    var body = ""
    var addition = "<p><b>{lang.totaltreat} " + d_treating.length + " </b></p>"
    d_treating.forEach((treating, index) => {
      body += "<tr><td style='width: 20%'>" + treating["time"] + "</td><td style='width: 50%'><b>{lang.temperate}</b>: " + treating["temperate"] + "<br><b>{lang.eye}</b>: " + treating["eye"] + "<br><b>{lang.other}</b>: " + treating["other"] + "</td><td style='width: 30%'>" + treating["treating"] + "</td></tr>"
    })
    var html =
      "<table class='table table-border'><thead><tr style='height: 32px;'><th><span id='tk_otherhhang'>" + $("#customer").text() + "</span> / <span id='tk_thucung'>" + $("#petname").text() + "</span></th><th>{lang.eviden}</th><th>{lang.treating}</th></tr></thead><tbody>" + body + "</tbody><tfoot><tr><td colspan='3'>" + addition + "</td></tr></tfoot></table>"
    $("#vac2_body").html(html)
  }

  function editSubmit(type) {
    changeTreat(global['index'])
    count = 0
    global['list'].forEach((item, item_index) => {
      item['image'].forEach((image, image_index) => {
        if (image.length > 5000) {
          count++
          uploadImage(image, item_index, image_index).then((url) => {
            global['list'][item_index]['image'][image_index] = url
            count--
            console.log(count);
            if (count == 0) {
              vhttp.checkelse('', { action: 'edit', id: global['id'], type: type, data: global['list'] }).then(data => {
                $('#content').html(data['html'])
                $('#insert-modal').modal('hide')
              })
            }
          })
        }
      })
    })
  }

  function uploadImages(base64, item_index, image_index) {
    return new Promise(resolve => {
      var uploadTask = storageRef.child('images/' + new Date().getTime() + '-'+ item_index +'-'+ image_index +'.jpg').putString(base64, 'base64', metadata);
      uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, // or 'state_changed'
        function (snapshot) {
          var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          console.log('Upload is ' + progress + '% done', item_index, image_index);
        }, function (error) {
          resolve("")
        }, function () {
          uploadTask.snapshot.ref.getDownloadURL().then(function (downloadURL) {
            resolve(downloadURL)
          });
        });
    })
  }

  customer_name.addEventListener("keyup", (e) => {
    showSuggest(e.target.getAttribute("id"), true);
  })

  customer_phone.addEventListener("keyup", (e) => {
    showSuggest(e.target.getAttribute("id"), false);
  })

  suggest_name.addEventListener("mouseenter", (e) => {
    blur = false;
  })
  suggest_name.addEventListener("mouseleave", (e) => {
    blur = true;
  })
  customer_name.addEventListener("focus", (e) => {
    suggest_name.style.display = "block";
  })
  customer_name.addEventListener("blur", (e) => {
    if (blur) {
      suggest_name.style.display = "none";
    }
  })
  suggest_phone.addEventListener("mouseenter", (e) => {
    blur = false;
  })
  suggest_phone.addEventListener("mouseleave", (e) => {
    blur = true;
  })
  customer_phone.addEventListener("focus", (e) => {
    suggest_phone.style.display = "block";
  })
  customer_phone.addEventListener("blur", (e) => {
    if (blur) {
      suggest_phone.style.display = "none";
    }
  })
</script>
<!-- END: main -->