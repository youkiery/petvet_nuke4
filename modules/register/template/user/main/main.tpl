<!-- BEGIN: main -->
<style>
  .child {
    margin-left: 5px;
    padding-left: 5px;
    border-left: 2px solid green;
  }

  .red {
    color: red;
  }

  .form-group {
    clear: both;
  }

  .box-bordered {
    margin: auto;
    border: 1px solid lightgray;
    border-radius: 10px;
    padding: 10px;
  }

  .vetleft,
  .vetright {
    position: absolute;
    top: 0px;
    width: 135px;
    text-align: center;
  }

  .vetleft {
    left: 0px;
  }

  .vetright {
    right: 0px;
  }

  .vetleft img,
  .vetright img {
    width: 75px !important;
  }

  label {
    font-weight: normal;
  }

  .banner {
    width: 100%;
  }

  .vblock {
    top: 80px;
  }

  .thumb {
    width: 100px; height: 100px;
    display: inline-block;
    position: relative;
  }
  .thumb img {
    max-width: 100px; max-height: 100px;
  }
  .close {
    position: absolute; top: 0px; right: 0px;
  }

  @media screen and (max-width: 992px) {
    .p_left {
      display: none;
    }

    .vetleft,
    .vetright {
      position: unset;
      display: inline-block;
      width: auto;
    }

    .vetright_block {
      display: block;
    }
  }

  @media screen and (max-width: 768px) {
    .checkbox input[type=checkbox] {
      position: inherit;
      margin-left: inherit;
    }
  }

  @media screen and (max-width: 600px) {

    .vetleft img,
    .vetright img {
      width: 50px !important;
    }

    .hideout {
      display: none;
    }
  }
</style>
<div class="container" style="margin-top: 20px; margin-bottom: 20px; ">
  <div id="msgshow"></div>

  <div id="content" style="position: relative;">
    <div class="text-center">
      <div class="vetleft">
        <img src="/assets/images/1.jpg">
      </div>
      <div class="vetleft vblock">
        <p class="p_left"
          style="font-weight: bold; margin: 14px; font-size: 1.25em; color: deepskyblue; text-shadow: 2px 2px 6px;">
          Ngày yêu thương </p>
      </div>
      <div class="vetright">
        <img src="/assets/images/2.jpg">
      </div>
      <div class="vetright vetright_block vblock">
        <p style="font-weight: bold; margin: 14px; font-size: 1.25em; color: deepskyblue; text-shadow: 2px 2px 6px;">
          Cắt tỉa miễn phí </p>
      </div>
    </div>
    <div>
      <div class="box-bordered" style="max-width: 500px;">
        <div class="text-center" style="font-size: 1.5em; color: green; margin-bottom: 20px;"> <b> Mẫu đăng ký </b>
        </div>
        <div class="form-group row-x">
          <div class="col-3"> Chủ nuôi </div>
          <div class="col-9">
            <input type="text" class="form-control" id="signup-fullname">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Tên thú cưng </div>
          <div class="col-9">
            <input type="text" class="form-control" id="signup-name">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Giống loài </div>
          <div class="col-9">
            <input type="text" class="form-control" id="signup-species">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Số điện thoại <span style="color:red; font-size: 1.2em">(*)</span> </div>
          <div class="col-9">
            <input type="text" class="form-control" id="signup-mobile">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Địa chỉ </div>
          <div class="col-9">
            <input type="text" class="form-control" id="signup-address">
          </div>
        </div>

        <div class="text-center">
          <span id="image-list"></span>
          <label class="insert text-center thumb">
            <img style="width: 100px; height: 100px;" src="/assets/images/upload.png">
            <div style="width: 50px; height: 50px; display: none;" id="image"></div>
          </label>
        </div>

        <div style="clear: both;"></div>
        <div class="text-center">
          <button class="btn btn-success" onclick="submit()">
            Đăng ký
          </button>
          <div id="notify" style="color: red; font-size: 1.3em; font-weight: bold;"> </div>
        </div>
      </div>
      <div></div>
    </div>
    <br>
  </div>
  <div class="box-bordered" id="notify-content" style="display: none; margin-bottom: 20px;">
    <p>Bạn đã đăng ký thành công, chúng tôi sẽ liên hệ với bạn theo số điện thoại cung cấp
      để thông báo về lịch học cùng các vấn đề liên quan</p>
    <p class="text-center">
      Bạn có thể muốn: <br>
      <a href="/{module_name}"> Đăng ký thêm </a>
    </p>
  </div>
  <div class="box-bordered" style="max-width: 500px;">
    <div class="text-center">
      <img class="banner" src="/assets/images/banner.jpg">
      <p style="color: green; font-size: 1.2em;"> <b> BỆNH VIỆN THÚ CƯNG THANH XUÂN </b> </p>
    </div>
    <p>Địa chỉ: 12-14 Lê Đại Hành, Buôn Ma Thuột</p>
    <p>Số điện thoại: 02626.290.609</p>
  </div>
</div>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vimage.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase-storage.js"></script>
<!-- <script src="/modules/core/js/"></script> -->
<script>
  var firebaseConfig = {
    apiKey: "AIzaSyAgxaMbHnlYbUorxXuDqr7LwVUJYdL2lZo",
    authDomain: "petcoffee-a3cbc.firebaseapp.com",
    databaseURL: "https://petcoffee-a3cbc.firebaseio.com",
    projectId: "petcoffee-a3cbc",
    storageBucket: "petcoffee-a3cbc.appspot.com",
    messagingSenderId: "351569277407",
    appId: "1:351569277407:web:8ef565047997e013"
  };
  var metadata = {
    contentType: 'image/jpeg',
  };

  firebase.initializeApp(firebaseConfig);

  var storage = firebase.storage();
  var storageRef = firebase.storage().ref();

  $(document).ready(() => {
    vimage.install('image', 640, 640, (list) => {
      refreshImage(list)
    })
    // $(".primary").change(e => {
    //   id = e.currentTarget.getAttribute('rel')
    //   $(".sub[rel="+ id +"]").prop('checked', false)
    // })

    // $(".sub").change(e => {
    //   id = e.currentTarget.getAttribute('rel')
    //   $(".primary[rel="+ id +"]").prop('checked', false)
    // })
  })

  function refreshImage(list) {
    html = ''
    list.forEach((item, index) => {
      html += `
      <div class="thumb">
        <button type="button" class="close insert" onclick="removeImage(`+ index + `)">&times;</button>
        <img src="`+ item + `">
      </div>`
    })
    $("#image-list").html(html)
  }

  function submit() {
    sdata = checkData()
    if (!sdata['name']) notify(sdata)
    else {
      upload('image').then(list => {
        vhttp.checkelse('', { action: 'submit', data: sdata, list: list }).then(data => {
          // hiển thị thông báo liên hệ
          $("#content").hide()
          $("#notify-content").show()
        })
      })
    }
  }

  function checkData() {
    var data = {
      fullname: $("#signup-fullname").val(),
      name: $("#signup-name").val(),
      species: $("#signup-species").val(),
      address: $("#signup-address").val(),
      mobile: $("#signup-mobile").val()
    }
    if (!data.mobile.length) return 'Số điện thoại không được để trống'
    return data
  }

  function notify(text) {
    $("#notify").show()
    $("#notify").text(text)
    $("#notify").delay(1000).fadeOut(1000)
  }

  function upload(id) {
    return new Promise((resolve) => {
      source = vimage.data[id]
      limit = source.length
      index = 0
      checker = 0
      image_data = []
      if (!source.length) resolve([])
      source.forEach(item => {
        index++
        name = index + '-' + Math.floor((new Date()).getTime() / 1000)
        file = item.substr(item.indexOf(',') + 1);

        var uploadTask = storageRef.child('images/' + name).putString(file, 'base64', metadata);
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
            console.log(error);
            checker++
            if (checker == limit) {
              resolve(image_data)
            }
          }, function () {
            uploadTask.snapshot.ref.getDownloadURL().then(function (downloadURL) {
              image_data.push(downloadURL)
              checker++
              if (checker == limit) {
                resolve(image_data)
              }
            });
          });
      });
    })
  }
</script>
<!-- END: main -->