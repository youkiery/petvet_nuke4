<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<style>
  .box { float: left; width: 49%; }
</style>

<!-- <div style="width: 100%; height: 100%; top: 0px; left: 0px; position: fixed; background: black; opacity: 0.5; z-index: 2;">
</div> -->

<div class="modal fade" id="img" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <img class="img-responsive" id="img-src">
      </div>
    </div>
  </div>
</div>

<div id="customer_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_custom_title}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return customer_submit(event)">
          <div class="row">
            <div class="form-group col-md-12">
              <label>{lang.customer}</label>
              <input type="text" class="form-control" id="customer_name">
            </div>
            <div class="form-group col-md-12">
              <label>{lang.phone}</label>
              <input type="text" class="form-control" id="customer_phone">
            </div>
          </div>
          <div class="form-group">
            <label>{lang.address}</label>
            <input type="text" class="form-control" id="customer_address">
          </div>
          <button class="btn btn-info">
            {lang.submit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_insert}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return insert(event)">
          <div class="form-group">
            <label>{lang.customer} <span class="small_icon" data-toggle="modal" data-target="#customer_modal"> + </span></label>
            <div class="relative">
              <input class="form-control" id="customer" type="text" name="customer" autocomplete="off">
              <div class="suggest"></div>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-md-12">
              <b>
                {lang.customer_name}:
              </b>
              <span id="customer_name_info"> </span>
            </div>
            <div class="col-md-12">
              <b>
                {lang.customer_number}:
              </b>
              <span id="customer_phone_info"> </span>
            </div>
          </div>
          <div class="form-group">
            <label>{lang.spa_weight}</label>
            <select class="form-control" id="weight">
              <!-- BEGIN: weight -->
              <option value="{weight_value}">{weight_name}</option>
              <!-- END: weight -->
            </select>
          </div>
          <div class="row form-group">
            Hình ảnh
            <label class="btn btn-info" for="file">
                <input id="file" type="file" style="display: none" onchange="onselected(this)">
                <span class="glyphicon glyphicon-upload"></span>
              </label>
              <img id="blah" width="64px" height="64px">
          </div>
          <div class="form-group">
            <label>{lang.spa_doctor}</label>
            <select class="form-control" id="doctor">
              <!-- BEGIN: doctor -->
              <option value="{doctor_value}">{doctor_name}</option>
              <!-- END: doctor -->
            </select>
          </div>
          <div id="insert_content">
            {insert_content}
          </div>
          <div style="clear: both;"></div>
          <div class="form-group">
            <label>
              {lang.note}
            </label>
            <input type="text" class="form-control" id="c_note">
          </div>
          <button class="btn btn-info">
            {lang.submit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="detail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_detail}</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <span> {lang.doctor}: </span>
          <span id="detail_doctor"></span>
        </div>
        <div class="form-group">
          <span> {lang.spa_from}: </span>
          <span id="detail_from"></span>
        </div>
        <div class="form-group">
          <label> {lang.spa_weight} </label>
          <select class="form-control" id="detail_weight"> </select>
        </div>
        <div class="form-group">
          <label> {lang.spa_doctor2} </label>
          <select class="form-control" id="detail_doctor2"> </select>
        </div>
        <div id="detail_content"></div>
        <div style="clear: both;"></div>
        <div class="form-group">
          <label>
            {lang.note}
          </label>
          <input type="text" class="form-control" id="c_note2">
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" onclick="update()" id="btn-detail">
          {lang.update}
        </button>
        <button class="btn btn-info" onclick="detail()" id="btn-detail2">
          {lang.complete}
        </button>
        <button class="btn btn-info" onclick="payment()" id="btn-detail3">
          {lang.payment}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<table class="table">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <!-- <th>
        {lang.spa_doctor}
      </th> -->
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.customer_number}
      </th>
      <!-- <th>
        {lang.spa_from}
      </th> -->
      <th>
        {lang.spa_end}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="6">
        <button class="btn btn-info" data-toggle="modal" data-target="#insert">
          {lang.add}
        </button>
      </td>
    </tr>
  </tfoot>
</table>
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

  $("#detail_content").click((e) => {
    var row = e.target;
    if (row.tagName !== "INPUT") {
      row = e.target.parentElement.children[2].children[0];
      if (row.checked) {
        row.checked = false
      }
      else {
        row.checked = true
      }
    }
  })
  $("#customer").blur(() => {
    setTimeout(() => {
      $(".suggest").hide()
    }, 200)
  })
  $("#customer").focus(() => {
    $(".suggest").show()
  })
  $("#customer").keyup(e => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      $.post(
        strHref,
        {action: "getcustomer", key: $("#customer").val()},
        (response, status) => {
          var data = JSON.parse(response)
          $(".suggest").html(data["list"])
        }
      )
    }, 500);
  }) 

  function customer_submit(e) {
    e.preventDefault()
    var name = $("#customer_name").val()
    var phone = $("#customer_phone").val()
    var address = $("#customer_address").val()
    
    if (!name) {
      alert_msg("{lang.no_custom_name}");
    }
    else if (!phone) {
      alert_msg("{lang.no_custom_phone}");
    }
    else {
      $.post(
        strHref,
        {action: "custom", name: name, phone: phone, address: address},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            customer = data["id"]
            $("#customer_modal").modal("toggle")
            $("#customer_name_info").text(name)
            $("#customer_phone_info").text(phone)
            alert_msg(data["notify"])
          }
          else {alert_msg(data["notify"])}
        }
      )
    }
  }

  function setcustom(id, name, phone) {
    customer = id
    $("#customer_name_info").text(name)
    $("#customer_phone_info").text(phone)
  }

  function insert(e) {
    e.preventDefault()
    if (customer > 0) {
      var check = [];
      var check = [];
      $("#insert_content .check").each((index, item) => {
        check.push({id: item.getAttribute('rel'), checking: item.checked})
      })
      
      uploader().then(image => {
        $.post(
          strHref,
          {action: "insert", note: $("#c_note").val(), customer: customer, doctor: $("#doctor").val(), doctor2: $("#doctor2").val(), weight: $("#weight").val(), check: check, image: image},
          (response, status) => {
            var data = JSON.parse(response);
            if (data["status"]) {
              $("#content").html(data["list"])
              $("#insert").modal("toggle")
              alert_msg(data["notify"])
            }
            else {
              alert_msg(data["notify"])
            }
          }
        )
      })
    }
    else {      
      alert_msg("{lang.no_customer}")
    }
  }

  function preview(url) {
    imgSrc.attr('src', url)
    img.modal('show')
  }

  function update() {
    if (g_id > 0) {
      var check = [];
      $("#detail_content .check").each((index, item) => {
        check.push({id: item.getAttribute('rel'), checking: item.checked})
      })
      
      uploader().then(image => {
        $.post(
          strHref,
          {action: "update", note: $("#c_note2").val(), doctor: $("#detail_doctor2").val(), weight: $("#detail_weight").val(), customer: g_id, check: check, image: image},
          (response, status) => {
            var data = JSON.parse(response);
            if (data["status"]) {
              $("#content").html(data["list"])
              $("#detail").modal("toggle")
              alert_msg(data["notify"])
            }
            else {
              alert_msg(data["notify"])
            }
          }
        )
      })
    }
    else {      
      alert_msg("{lang.no_customer}")
    }
  }

  function payment() {
    $.post(
      strHref,
      {action: "payment", id: g_id},
      (response, status) => {
        var data = JSON.parse(response);
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#detail").modal("toggle")
        }
        alert_msg(data["notify"])
      }
    )
  }

  function view_detail(id) {
    $("#btn-detail").attr("disabled", "disabled")
    $("#btn-detail2").attr("disabled", "disabled")
    $("#btn-detail3").attr("disabled", "disabled")
    $.post(
      strHref,
      {action: "get_detail", id: id},
      (response, status) => {
        g_id = id
        var data = JSON.parse(response);
        if (data["done"] == 0) {
          $("#btn-detail").removeAttr("disabled")
        }
        if (data["payment"] == 0) {
          $("#btn-detail2").removeAttr("disabled")
          $("#btn-detail3").removeAttr("disabled")
        }
        $("#detail").modal("toggle")
        $("#detail_content").html(data["list"])
        $("#detail_doctor2").html(data["html"])
        $("#detail_weight").html(data["weight"])
        $("#detail_doctor").text(data["doctor"])
        $("#detail_from").text(data["from"])
        $("#c_note2").val(data["note"])
      }
    )
  }
  function detail() {
    if (g_id > 0) {
      var check = [];
      $("#detail_content").each((index, element) => {
        var length = element.children.length
        for (var i = 0; i < length; i++) {
          tr = element.children[i];
          var input = tr.children[2].children[0]
          var id = input.getAttribute("class")
          var checking = input.checked

          check.push({id: id, checking: checking})
        } 
      })

      $.post(
        strHref,
        {action: "confirm", note: $("#c_note2").val(), doctor: $("#detail_doctor2").val(), customer: g_id, check: check},
        (response, status) => {
          var data = JSON.parse(response);
          $("#detail").modal("toggle")
          $("#content").html(data["list"])
          alert_msg(data["notify"])
        }
      )    
    }
    else {
      alert_msg("{lang.no_customer}")
    }
  }

  setInterval(() => {
    if (!refresh) {
      refresh = 1
      $.post(
        strHref,
        {action: "refresh"},
        (response, status) => {
          var data = JSON.parse(response);
          $("#content").html(data["list"])
          refresh = 0
        }
      )
    }
  }, 10000);

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

</script>
<!-- END: main -->
