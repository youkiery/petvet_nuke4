<!-- BEGIN: main -->
<div id="msgshow"></div>
<style>
  .rhead {
    border-top: 1px solid;
    border-bottom: 1px solid;
  }

  .rbody {
    border-bottom: 1px solid;
  }

  .rows {
    border-left: 1px solid;
  }

  .th, .td {
    border-right: 1px solid;
    height: 30px;
  }

  #upload-status {
    position: absolute;
    width: 100%;
    height: 100%;
    line-height: 100px;
    font-size: 50px;
    font-weight: bold;
    color: white;
    background: radial-gradient(black, transparent);
    display: none;
  }

  label {
    width: 100%;
  }

  .error {
    color: red;
    font-size: 1.2em;
    font-weight: bold;
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
    padding: 5px;
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

{modal}

<h2> Hướng dẫn sử dụng {device_name} </h2>

<div class="text-center">
  <button class="btn btn-info" onclick="videoModal()">
    thêm video
  </button>
</div>
<div id="content"></div>
<div class="text-center">
  <button class="btn btn-info" onclick="saveManual()">
    Lưu thay đổi
  </button>
</div>

<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase-storage.js"></script>
<script src="/modules/core/js/ckeditor/ckeditor.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
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
  var storageRef = firebase.storage().ref().child('/videos');

  $(document).ready(() => {
    CKEDITOR.replace('content')
    CKEDITOR.instances.content.setData('{data}')
  })

  function videoModal() {
    $("#upload-status").hide()
    $("#video-modal").modal('show')
  }

  function saveManual() {
    vhttp.checkelse('', { action: 'save-manual', data: CKEDITOR.instances.content.getData() }).then(data => {
      window.location.replace(data['url'])
    })
  }

  function selectVideo(name, url) {
    data = CKEDITOR.instances.content.getData()
    data += ''
    CKEDITOR.instances.content.setData(data)
  }

  function uploadVideo() {
    video = $("#video")[0].files[0]
    pos = video.name.lastIndexOf('.')
    name = video.name.slice(0, pos - video.name.length)
    ext = video.name.slice(pos - video.name.length)

    uploadTask = storageRef.child(name + '-' + Math.floor(new Date().getTime() / 1000) + ext).put(video)
    $("#upload-status").text('0')
    $("#upload-status").show()

    uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED,
      function (snapshot) {
        var progress = Math.floor((snapshot.bytesTransferred / snapshot.totalBytes) * 100);
        $("#upload-status").text(progress)

        switch (snapshot.state) {
          case firebase.storage.TaskState.PAUSED:
            // console.log('Upload is paused');
            break;
          case firebase.storage.TaskState.RUNNING:
            // console.log('Upload is running');
            break;
        }
      }, function (error) { }, function () {
        $("#upload-status").text('OK')
        uploadTask.snapshot.ref.getDownloadURL().then(function (url) {
          vhttp.checkelse('', { action: 'insert-video', name: video.name, size: video.size, url: url }).then(data => {
            $("#upload-status").hide()
            $("#video-content").html(data['html'])
          })
        });
      });
  }
</script>
<!-- END: main -->