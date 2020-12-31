<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<style>
  .cell-center {
    text-align: center;
    vertical-align: inherit !important;
  }

  .red {
    background: pink;
  }

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-6 {
    float: left;
    margin-left: 5px;
    margin-right: 5px;
  }

  .col-6 {
    width: calc(50% - 10px);
  }

  .relative {
    position: relative;
  }

  .suggest-item {
    height: 30px;
    line-height: 30px;
    padding: 5px;
    border-bottom: 1px solid #ddd;
  }

  .suggest {
    z-index: 100;
    background: white;
    display: none;
    position: absolute;
    overflow-y: scroll;
    max-height: 300px;
    width: -webkit-fill-available;
    width: 100%;
  }

  .suggest div:hover {
    background: #afa;
    cursor: pointer;
  }

  .hidden {
    display: none;
  }
</style>

{modal}

<form method="get">
  <!-- BEGIN: promo -->
  <input type="hidden" name="type" value="promo">
  <!-- END: promo -->
  <div class="form-group">
    <label> Họ tên </label>
    <input type="text" class="form-control" name="name" id="filter-name" value="{name}">
  </div>
  <label class="form-group">
    Ngày nâng lương/bổ nhiệm
  </label>
  <div class="form-group rows">
    <div class="col-6">
      <div class="input-group">
        <input type="text" class="form-control date" name="timestart" id="filter-salary-time-start" value="{timestart}">
        <div class="input-group-addon"> </div>
      </div>
    </div>
    <div class="col-6">
      <div class="input-group">
        <input type="text" class="form-control date" name="timeend" id="filter-salary-time-end" value="{timeend}">
        <div class="input-group-addon"> </div>
      </div>
    </div>
  </div>
  <label class="form-group">
    Ngày nâng lương/bổ nhiệm kế tiếp
  </label>
  <div class="form-group rows">
    <div class="col-6">
      <div class="input-group">
        <input type="text" class="form-control date" name="nexttimestart" id="filter-salary-next-time-start" value="{nexttimestart}">
        <div class="input-group-addon"> </div>
      </div>
    </div>
    <div class="col-6">
      <div class="input-group">
        <input type="text" class="form-control date" name="nexttimeend" id="filter-salary-next-time-end" value="{nexttimeend}">
        <div class="input-group-addon"> </div>
      </div>
    </div>
  </div>

  <button class="btn btn-info btn-block" onclick="filter()">
    Lọc danh sách
  </button>
</form>

<ul class="nav nav-tabs">
  <li {active_salary}><a href="{link_salary}"> Nâng lương </a></li>
  <li {active_promo}><a href="{link_promo}"> Bổ nhiệm </a></li>
</ul>

<div class="form-group"></div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-8.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.1/firebase-storage.js"></script>
<script>
  var global = {
    id: 0,
    filemodal: '',
    file: '',
    formal: '{formal}'.split('|'),
    employ: '{employ}'.split('|'),
  }
  // vodaityr@gmail.com vetcenter5
  var firebaseConfig = {
    apiKey: "AIzaSyAl59TONLslojQnmb4q24P6vTMl7wpahMQ",
    authDomain: "vetcenter5.firebaseapp.com",
    projectId: "vetcenter5",
    storageBucket: "vetcenter5.appspot.com",
    messagingSenderId: "544572326815",
    appId: "1:544572326815:web:004624826f802f9ef933aa",
    measurementId: "G-6X07Q4GM8D"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  var storage = firebase.storage();
  var storageRef = storage.ref();

  $(document).ready(() => {
    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });

    $('#salary-up-level-const').html($('#salary-up-level').val())
    $('#salary-up-level').change((e) => {
      $('#salary-up-level-const').html(e.currentTarget.value)
    })

    vremind.install('#salary-up-name', '#salary-up-name-suggest', (input) => {
      return new Promise(resolve => {
        html = ''
        input = input.toLowerCase()

        global.employ.forEach(item => {
          if (item.search(input) >= 0) html += `
            <div class="suggest-item" onclick="select('salary-up-name', '`+ item + `')">
              `+ item + `
            </div>`
        });
        resolve(html)
      })
    }, 500, 300)
    vremind.install('#salary-up-formal', '#salary-up-formal-suggest', (input) => {
      return new Promise(resolve => {
        html = ''
        input = input.toLowerCase()

        global.formal.forEach(item => {
          if (item.search(input) >= 0) html += `
            <div class="suggest-item" onclick="select('salary-up-formal', '`+ item + `')">
              `+ item + `
            </div>`
        });
        resolve(html)
      })
    }, 500, 300)
    vremind.install('#promo-up-name', '#promo-up-name-suggest', (input) => {
      return new Promise(resolve => {
        html = ''
        input = input.toLowerCase()

        global.employ.forEach(item => {
          if (item.search(input) >= 0) html += `
            <div class="suggest-item" onclick="select('promo-up-name', '`+ item + `')">
              `+ item + `
            </div>`
        });
        resolve(html)
      })
    }, 500, 300)
  })

  function select(selector, name) {
    $('#' + selector).val(name)
  }

  // function filterModal() {
  //   $('#filter-modal').modal('show')
  // }

  // function employInsert(e) {
  //   e.preventDefault()
  //   vhttp.checkelse('', {
  //     action: 'employ-insert',
  //     name: $('#employ-insert-name').val()
  //   }).then(response => {
  //     $('#employ-insert-name').val('')
  //     $('#content').html(response.html)
  //     $('#employ-insert-content').html(response.html2)
  //   })
  //   return false
  // }

  // function employRemoveModal(employid) {
  //   global.id = employid
  //   $('#employ-remove-modal').modal('show')
  // }

  // function employRemove() {
  //   vhttp.checkelse('', {
  //     action: 'employ-remove',
  //     employid: global.id
  //   }).then(response => {
  //     $('#content').html(response.html)
  //     $('#employ-insert-content').html(response.html2)
  //     $('#employ-remove-modal').modal('hide')
  //   })
  // }

  function salaryUpModal() {
    global.file = ''
    global.filemodal = 'salary'
    $('#salary-up-modal').modal('show')
  }

  function salaryUp(e) {
    e.preventDefault()
    upload().then(url => {
      console.log(url);
      vhttp.checkelse('', {
        action: 'salary-up',
        data: {
          name: $('#salary-up-name').val(),
          time: $('#salary-up-time').val(),
          level: $('#salary-up-level').val(),
          next_time: $('#salary-up-next-time').val(),
          formal: $('#salary-up-formal').val(),
          file: url,
          note: $('#salary-up-note').val(),
        }
      }).then(response => {
        global.employ = response.employ
        global.formal = response.formal
        $('#content').html(response.html)
        $('#salary-up-name').val('')
        $('#salary-up-formal').val('')
        $('#salary-up-file').val('')
        $('#salary-up-note').val('')
      })
    })
    return 0
  }

  function salaryRemoveModal(id) {
    global.id = id
    $('#remove-modal').modal('show')
  }

  function remove() {
    vhttp.checkelse('', {
      action: 'remove',
      id: global.id,
    }).then(response => {
      $('#content').html(response.html)
      $('#remove-modal').modal('hide')
    })
  }

  function promoUpModal() {
    global.file = ''
    global.filemodal = 'promo'
    $('#promo-up-modal').modal('show')
  }

  function promoUp(e) {
    e.preventDefault()
    vhttp.checkelse('', {
      action: 'promo-up',
      data: {
        name: $('#promo-up-name').val(),
        time: $('#promo-up-time').val(),
        next_time: $('#promo-up-next-time').val(),
        file: $('#promo-up-file').val(),
        note: $('#promo-up-note').val(),
      }
    }).then(response => {
      global.employ = response.employ
      $('#content').html(response.html)
      $('#promo-up-name').val(''),
        $('#promo-up-file').val('')
      $('#promo-up-note').val('')
    })
    return 0
  }

  // function historyModal(employid) {
  //   vhttp.checkelse('', {
  //     action: 'history',
  //     employid: employid
  //   }).then(response => {
  //     $('#history-content').html(response.html)
  //     $('#history-modal').modal('show')
  //   })
  // }

  function pickFile() {
    global.file = $('#' + global.filemodal + '-up-file').prop('files')[0]
  }

  function upload() {
    return new Promise((resolve) => {
      if (!(global.file && global.file.name)) resolve(global.file)
      fullname = global.file.name
      pos = fullname.lastIndexOf('.')
      if (pos >= 0) {
        filename = fullname.substring(0, pos) + ((new Date()).getTime() / 1000) + fullname.substring(pos)
      }
      else filename = fullname + '.temp'

      var uploadTask = storageRef.child('document/' + filename).put(global.file);
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
          resolve('')
        }, function () {
          uploadTask.snapshot.ref.getDownloadURL().then(function (downloadURL) {
            global.file = downloadURL
            resolve(downloadURL)
          });
        });
    });
  }
</script>
<!-- END: main -->