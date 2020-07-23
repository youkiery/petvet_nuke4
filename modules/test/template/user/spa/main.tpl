<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>
<style>
  .boxed {
    display: inline-block;
    width: 49%;
  }

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .green {
    background: #dfd;
  }
  .blue {
    background: #ddf;
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

<!-- <div style="width: 100%; height: 100%; top: 0px; left: 0px; position: fixed; background: black; opacity: 0.5; z-index: 2;">
</div> -->

{modal}

<div id="content">
  {content}
</div>

<button class="btn btn-success" onclick="insert()">
  Thêm
</button>

<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase-storage.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
  var global = {
    type: 0,
    id: 0
  }
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
  var timer;
  var refresh = 0
  var img = $("#img")
  var imgSrc = $("#img-src")

  $(document).ready(() => {
    setInterval(() => {
      if (!refresh) {
        refresh = 1
        vhttp.checkelse('', { action: 'refresh' }).then(data => {
          $("#content").html(data["list"])
          refresh = 0
        })
      }
    }, 10000);
    vremind.install('#customer', '#customer-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'get-customer', key: input, type: 0 }).then(data => {
          resolve(data['list'])
        })
      })
    }, 300, 300)
    vremind.install('#phone', '#phone-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'get-customer', key: input, type: 1 }).then(data => {
          resolve(data['list'])
        })
      })
    }, 300, 300)
  })

  function insert() {
    global['type'] = 0;
    $('[name=spa]').prop('checked', false)
    $('.insert').show()
    $('.update').hide()
    $('#insert-modal').modal('show')
  }

  function setcustom(id, name, phone) {
    $("#customer").val(name)
    $("#phone").val(phone)
  }

  function insertSubmit(e) {
    if (!$('#phone').val().length || !$('#customer').val().length) alert_msg("{lang.no_customer}")
    else {
      var check = [];
      $("[name=spa]").each((index, item) => {
        var id = item.getAttribute("class")
        var checking = item.checked
        check.push({ id: id, checking: Number(checking) })
      })

      uploader().then(image => {
        vhttp.checkelse('', { action: "insert", phone: $('#phone').val(), customer: $('#customer').val(), note: $("#note").val(), doctor: $("#doctor").val(), weight: $("#weight").val(), check: check, image: image }).then(data => {
          $("#content").html(data["list"])
          $("#insert-modal").modal("hide")
        })
      })
    }
  }
  
  function update() {
    var check = [];
    $("[name=spa]").each((index, item) => {
      var id = item.getAttribute("class")
      var checking = item.checked
      check.push({ id: id, checking: Number(checking) })
    })

    uploader().then(image => {
      vhttp.checkelse('', { action: "update", note: $("#note").val(), id: global['id'], check: check, image: image }).then(data => {
        $("#content").html(data["list"])
        $("#insert-modal").modal("hide")
      })
    })
  }

  function preview(url) {
    imgSrc.attr('src', url)
    img.modal('show')
  }

  function view_detail(id) {
    vhttp.checkelse('', { action: "get_detail", id: id }).then(data => {
      global['id'] = id
      $("#btn-detail").attr("disabled", true)
      if (data["done"] == 0 && data["payment"] == 0) {
        $("#btn-detail").attr("disabled", false)
      }

      for (const key in data['data']) {
        if (data['data'].hasOwnProperty(key)) {
          const item = data['data'][key];
          $('.' + key).prop('checked', Number(item))
        }
      }

      $("#detail_doctor").text(data["doctor"])
      $("#detail_from").text(data["from"])
      $("#detail_weight").text(data["weight"])
      $("#note").val(data["note"])

      global['type'] = 1
      $('.insert').hide()
      $('.update').show()
      $('#insert-modal').modal('show')
    })
  }

  function detail(id) {
    vhttp.checkelse('', { action: 'confirm', id: id }).then(data => {
      $("#content").html(data["list"])
      $('#insert-modal').modal('hide')
    })
  }

  function payment(id) {
    vhttp.checkelse('', { action: 'payment', id: id }).then(data => {
      $("#content").html(data["list"])
      $('#insert-modal').modal('hide')
    })
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