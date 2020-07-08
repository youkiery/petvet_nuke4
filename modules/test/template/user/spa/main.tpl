<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<div class="msgshow" id="msgshow"></div>

<style>
  .cell-center {
    vertical-align: inherit; text-align: center;
  }
</style>

{modal}

<div id="content">
  {content}
</div>

<!-- BEGIN: manager -->
<div class="form-group">
  <button class="btn btn-info" onclick="insertModal()">
    {lang.add}
  </button>
</div>
<!-- END: manager -->

<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase-storage.js"></script>
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

  firebase.initializeApp(firebaseConfig);

  var storage = firebase.storage();
  var storageRef = firebase.storage().ref();
  var fileInput = document.getElementById('file')
  var blah = document.getElementById('blah')
  var file
  var filename
  var maxWidth = 480
  var maxHeight = 480
  var metadata = {
    contentType: 'image/jpeg',
  };
  var imageType = ['jpg', 'png', 'gif']
  var list = [];
  var customer = 0;
  var g_id = 0;
  var timer;
  var refresh = 0
  var img = $("#img")
  var imgSrc = $("#img-src")

  $(document).ready(() => {
    // Tự động cập nhật mỗi 10s
    setInterval(() => {
      if (!refresh) {
        refresh = 1
        vhttp.checkelse('', { action: "refresh" }).then(data => {
          $("#content").html(data["list"])
          refresh = 0
        })
      }
    }, 10000);
    // gợi ý khách hàng
    vremind.install('#customer', '#customer-suggest', (input) => {
      return new Promise((resolve) => {
        vhttp.checkelse('', { action: "getcustomer", key: input }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 300)
  })

  function checkSpaData() {
    var selected = {}
    $(".box").each((index, item) => {
      selected[item.getAttribute('id')] = (Number(item.checked))
    });
    data = {
      customer: customer,
      note: $("#c_note").val(),
      doctor: $("#doctor").val(),
      selected: selected
    }
    if (data['customer'] < 1) return 'Chưa chọn khách hàng'
    return data
  }

  function insertSubmit() {
    idata = checkSpaData()
    if (!idata['customer']) alert_msg(idata)
    else {
      freeze()
      uploader().then(image => {
        vhttp.check('', { action: "insert-spa", data: idata, image: image }).then(data => {
          customer = 0
          alert_msg('Đã lưu')
          $("#content").html(data["html"])
          $("#insert-modal").modal("hide")
          $(".box").prop('checked', false)
          defreeze()
        }, () => { defreeze() })
      })
    }
  }

  function editSubmit() {
    customer = 1
    idata = checkSpaData()

    freeze()
    vhttp.check('', { action: "update-spa", data: idata, id: g_id }).then(data => {
      customer = 0
      alert_msg('Đã lưu')
      $("#content").html(data["html"])
      $("#insert-modal").modal("hide")
      defreeze()
    }, () => { defreeze() })
  }

  function insertModal() {
    $(".edit").hide()
    $(".insert").show()
    $("#insert-modal").modal('show')
  }

  function customer_submit() {
    var name = $("#customer_name").val()
    var phone = $("#customer_phone").val()
    var address = $("#customer_address").val()

    if (!name) alert_msg("{lang.no_custom_name}");
    else if (!phone) alert_msg("{lang.no_custom_phone}");
    else {
      freeze()
      vhttp.check('', { action: "custom", name: name, phone: phone, address: address }).then(data => {
        customer = data["id"]
        $("#customer_modal").modal("toggle")
        $("#customer_name_info").text(name)
        $("#customer_phone_info").text(phone)
        alert_msg('Đã thêm khách hàng')
        defreeze()
      }, () => { 
        alert_msg('Số điện thoại đã được sử dụng')
        defreeze()
      })
    }
  }

  function setcustom(id, name, phone) {
    customer = id
    $("#customer_name_info").text(name)
    $("#customer_phone_info").text(phone)
  }

  function complete(id) {
    freeze()
    vhttp.check('', { action: "complete", id: id }).then(data => {
      $("#content").html(data["html"])
      defreeze()
    }, () => { defreeze() })
  }

  function paid(id) {
    freeze()
    vhttp.check('', { action: "paid", id: id }).then(data => {
      $("#content").html(data["html"])
      defreeze()
    }, () => { defreeze() })
  }

  function view_detail(id) {
    freeze()
    vhttp.check('', { action: "get_detail", id: id }).then(data => {
      g_id = id
      $(".insert").hide()
      $(".edit").show()
      data['data']['selected'].forEach(item => {
        $("#" + item['id']).prop('checked', item['value'])
      });
      $("#doctor").val(data['data']["doctor"])
      $("#c_note").val(data['data']["note"])
      $("#detail_customer").text(data['data']["customer"])
      $("#detail_phone").text(data['data']["phone"])
      $("#image").attr('src', data['data']["image"])
      $("#time").text(data['data']["time"])
      $("#insert-modal").modal('show')
      defreeze()
    }, () => { defreeze() })
  }

  function onselected(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      var fullname = input.files[0].name
      var name = Math.round(new Date().getTime() / 1000) + '_' + fullname.substr(0, fullname.lastIndexOf('.'))
      var extension = fullname.substr(fullname.lastIndexOf('.') + 1)
      filename = name + '.' + extension

      reader.onload = function (e) {
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
          blah.setAttribute('src', file)
          file = file.substr(file.indexOf(',') + 1);
        };
      };

      if (imageType.indexOf(extension) >= 0) {

        reader.readAsDataURL(input.files[0]);
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
              resolve(downloadURL)
              console.log('File available at', downloadURL);
            });
          });
      }
    })
  }

</script>
<!-- END: main -->