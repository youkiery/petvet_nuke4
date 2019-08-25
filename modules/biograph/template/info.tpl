<!-- BEGIN: main -->
<style>
  .label {
    display: block;
    min-width: 150px;
    padding: 5px 10px;
    line-height: 20px;
    text-align: center;
    border: 2px solid #eee9dc;
    border-radius: 5px;
    position: absolute;
    left: 0;
    top: 50%;
    margin-top: -15px;
    color: black;
    height: 54px;
    font-weight: normal;
    font-size: inherit;
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
            <div class="input-group">
              <select class="form-control" id="vaccine-type">
                {v}
              </select>
              <div class="input-group-btn" onclick="addDiseaseSuggest()">
                <button class="btn btn-success">
                  <span class="glyphicon glyphicon-plus"></span>
                </button>
              </div>
            </div>
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Ngày tiêm phòng
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="vaccine-time" value="{today}" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Ngày nhắc
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="vaccine-recall" value="{recall}" autocomplete="off">
          </div>
        </label>

        <button class="btn btn-success" onclick="insertVaccineSubmit()">
          Thêm lịch tiêm phòng
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="insert-disease-suggest" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p class="text-center"> Nếu mũi tiêm phòng không có trong danh sách, hãy thêm tại đây </p>

        <label>
          Tên mũi tiêm phòng
          <input type="text" class="form-control" id="disease-suggest" autocomplete="off">
        </label>

        <div class="text-center">
          <button class="btn btn-success" onclick="insertDiseaseSuggestSubmit()">
            Thêm lịch sử bệnh
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="insert-disease" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <label class="form-group">
          Ngày bệnh
          <input type="text" class="form-control" id="disease-treat" autocomplete="off">
        </label>

        <label class="form-group">
          Ngày điều trị
          <input type="text" class="form-control" id="disease-treated" autocomplete="off">
        </label>

        <label class="form-group">
          Loại bệnh
          <div class="relative">
            <input type="text" class="form-control" id="disease-disease" autocomplete="off">
            <div class="suggest" id="disease-suggest-disease"></div>
          </div>
        </label>

        <label class="form-group">
          Ghi chú
          <input type="text" class="form-control" id="disease-note" autocomplete="off">
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
          <input type="text" class="form-control" id="breeder-time" value="{today}" autocomplete="off">
        </label>

        <label class="form-group relative">
          Đối tượng phối
          <div class="input-group">
            <input type="text" class="form-control" id="breeder-target" autocomplete="off">
            <input type="hidden" id="breeder-targetid">
            <div class="input-group-btn">
              <button class="btn btn-success" onclick="addTarget()">
                <span class="glyphicon glyphicon-plus"></span>
              </button>
            </div>
          </div>
          <div class="suggest" id="breeder-suggest-target"></div>
        </label>

        <label class="form-group relative">
          Số lượng con dự đoán
          <input type="number" class="form-control" id="breeder-number" value="1" autocomplete="off">
        </label>

        <!-- <div id="breeder-child"></div> -->
        <!-- <button class="btn btn-success" onclick="addChild()">
          <span class="glyphicon glyphicon-plus"></span>
        </button> -->

        <label class="form-group">
          Ghi chú
          <input type="text" class="form-control" id="breeder-note" autocomplete="off">
        </label>

        <div class="text-center">
          <button class="btn btn-success" id="btn-breeder-insert" onclick="insertBreederSubmit()">
            Thêm lịch phối giống
          </button>
          <button class="btn btn-success" id="btn-breeder-edit" onclick="editBreederSubmit()">
            Sửa lịch phối giống
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="modal-target" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
          <p class="text-center"> <b> Thêm thú cưng </b> </p>
          <label class="row">
            <div class="col-sm-3">
              Chủ thú cưng
            </div>
            <div class="col-sm-9 relative">
              <div class="input-group">
                <input type="text" class="form-control" id="owner" autocomplete="off">
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="addOwner()">
                    <span class="glyphicon glyphicon-plus"></span>
                  </button>
                </div>
              </div>
              <div class="suggest" id="owner-suggest"></div>
            </div>
          </label>

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
              <input type="text" class="form-control" id="pet-dob" value="{today}" autocomplete="off">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Giống
            </div>
            <div class="col-sm-9 relative">
              <input type="text" class="form-control" id="species" autocomplete="off">
              <div class="suggest" id="species-suggest"></div>
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
                <input type="radio" name="sex2" id="pet-sex-0" checked> Đực
              </label>
              <label>
                <input type="radio" name="sex2" id="pet-sex-1"> Cái
              </label>
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Màu sắc
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="pet-color" autocomplete="off">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Microchip
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="pet-microchip" autocomplete="off">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Xăm tai
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="pet-miear" autocomplete="off">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Xuất xứ
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="origin-pet" autocomplete="off">
            </div>
          </label>

          <label class="row">
            <div class="col-sm-3">
              Hình ảnh
            </div>
            <div class="col-sm-9">
              <div>
                <img class="img-responsive" id="pet-preview"
                  style="display: inline-block; width: 128px; height: 128px; margin: 10px;">
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

<div id="modal-owner" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p> Điền thông tin chủ trại </p>
        <label class="row">
          <div class="col-sm-3">
            Tên
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="owner-name">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Số điện thoại
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="owner-mobile">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Địa chỉ
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="owner-address">
          </div>
        </label>

        <div class="text-center">
          <button class="btn btn-success" onclick="insertOwnerSubmit()">
            Thêm khách hàng
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- <div id="insert-pet" class="modal fade" role="dialog">
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
            <input type="text" class="form-control" id="pet-color" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Microchip
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="pet-microchip" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Xăm tai
          </div>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="pet-miear" autocomplete="off">
          </div>
        </label>

        <label class="row">
          <div class="col-sm-3">
            Hình ảnh
          </div>
          <div class="col-sm-9">
            <div>
              <img class="img-responsive" id="pet-preview"
                style="display: inline-block; width: 128px; height: 128px; margin: 10px;">
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
</div> -->

<div class="container" style="margin-top: 20px;">
  <a href="/biograph/">
    <img src="/modules/biograph/src/banner.png" style="width: 100px;">
  </a>
  <div style="clear: both;"></div>
  <a href="/biograph/login" style="margin: 8px 0px; display: block;"> <span class="glyphicon glyphicon-chevron-left">  </span> Trở về </a>

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

  <div id="wrapper" style="margin: 20px 0px;">
    <span class="label" style="line-height: 40px;"> {name} </span>
    <div class="branch lv1">
      <div class="entry">
        <span class="label"> 
          Bố <br> {papa} 
          <div class="igleft">
            <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px; min-height: 22px;" data-html="true"  data-toggle="popover" data-content="{igpapa}"><span class="glyphicon glyphicon-info-sign"></span></button>  
          </div>
          <div class="igright">
            <button class="btn btn-sm btn-success after-hack" id="igrandon" style="min-height: 22px;" onclick="toggleX('igrand')"><span class="glyphicon glyphicon-arrow-right"></span></button>  
            <button class="btn btn-sm btn-warning after-hack" id="igrandoff" style="display: none; min-height: 22px;" onclick="toggleX('igrand')"><span class="glyphicon glyphicon-arrow-left"></span></button>  
          </div>
        </span>
        <div class="branch lv2" id="igrand" style="display: none;">
          <div class="entry">
            <span class="label"> Ông nội <br> {grandpa} 
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px; min-height: 22px;" data-html="true"  data-toggle="popover" data-content="{igigrandpa}"><span class="glyphicon glyphicon-info-sign"></span></button>
              </div>
            </span>
          </div>
          <div class="entry">
            <span class="label">
              Bà nội <br> {igrandma}
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px; min-height: 22px;" data-html="true"  data-toggle="popover" data-content="{igigrandma}"><span class="glyphicon glyphicon-info-sign"></span></button>
              </div>
            </span>
          </div>
        </div>
      </div>
      <div class="entry">
        <span class="label">
          Mẹ <br> {mama} 
          <div class="igleft">
            <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px; min-height: 22px;" data-html="true"  data-toggle="popover" data-content="{igmama}"><span class="glyphicon glyphicon-info-sign"></span></button>  
          </div>
          <div class="igright">
            <button class="btn btn-sm btn-success after-hack" id="egrandon" style="min-height: 22px;" onclick="toggleX('egrand')"><span class="glyphicon glyphicon-arrow-right"></span></button>  
            <button class="btn btn-sm btn-warning after-hack" id="egrandoff" style="display: none; min-height: 22px;" onclick="toggleX('egrand')"><span class="glyphicon glyphicon-arrow-left"></span></button>  
          </div>
        </span>
        <div class="branch lv2" id="egrand" style="display: none;">
          <div class="entry">
            <span class="label">
              Ông ngoại <br> {egrandpa}
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px; min-height: 22px;" data-html="true"  data-toggle="popover" data-content="{igegrandpa}"><span class="glyphicon glyphicon-info-sign"></span></button>
              </div>
            </span>
          </div>
          <div class="entry">
            <span class="label"> Bà ngoại <br> {egrandma}
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px; min-height: 22px;" data-html="true"  data-toggle="popover" data-content="{igegrandma}"><span class="glyphicon glyphicon-info-sign"></span></button>
              </div>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <ul class="nav nav-tabs">
    <li {a1}><a data-toggle="tab" href="#a1"> Lịch sử phối giống </a></li>
    <li {a2}><a data-toggle="tab" href="#a2"> Lịch sử tiêm phòng </a></li>
    <li {a3}><a data-toggle="tab" href="#a3"> Lịch sử bệnh </a></li>
  </ul>

  <div class="tab-content">
    <div id="a1" class="tab-pane fade {al1}">
      <div id="breeder-content">
        {breeder}
      </div>
    </div>
    <div id="a2" class="tab-pane fade {al2}">
      <div id="vaccine-content">
        {vaccine}
      </div>
    </div>
    <div id="a3" class="tab-pane fade {al3}">
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
    childid: 0,
    owner: -1,
    breeder: 0
  }
  var owner = {
    fullname: $("#owner-name"),
    mobile: $("#owner-mobile"),
    address: $("#owner-address")
  }
  var breeder = {
    time: $("#breeder-time"),
    target: $("#breeder-targetid"),
    number: $("#breeder-number"),
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
    userid: $("#pet-id"),
    type: $("#owner-type")
  }
  var button = {
    breeder: {
      insert: $("#btn-breeder-insert"),
      edit: $("#btn-breeder-edit")
    }
  }

  var modalTarget = $("#modal-target")
  var modalOwner = $("#modal-owner")

  var insertBreeder = $("#insert-breeder")
  var insertDisease = $("#insert-disease")
  var insertDiseaseSuggest = $("#insert-disease-suggest")
  var insertPet = $("#insert-pet")
  var breederContent = $("#breeder-content")
  var breederChild = $("#breeder-child")
  var petVaccine = $("#pet-vaccine")
  var diseaseContent = $("#disease-content")
  var vaccineContent = $("#vaccine-content")
  var petPreview = $("#pet-preview")
  var avatar = $("#avatar")
  var diseaseTreat = $("#disease-treat")
  var diseaseTreated = $("#disease-treated")
  var diseaseDisease = $("#disease-disease")
  var diseaseNote = $("#disease-note")
  var def = {
    today: '{today}'
  }
  var remind = JSON.parse('{remind}')

  loadImage('{image}', avatar)

  $("#breeder-time, #pet-dob, #disease-treat, #disease-treated, #vaccine-time, #vaccine-recall").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function addOwner() {
    modalOwner.modal('show')
  }

  function insertOwnerSubmit() {
    $.post(
      global['url'],
      { action: 'insert-owner', data: checkInputSet(owner) },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#owner").val(data['name'])
          global['owner'] = data['id']
          global['type'] = data['type']
          modalOwner.modal('hide')
          clearInputSet(owner)
        }, () => { })
      }
    )
  }

  function pickSpecies(name, id) {
    $("#species").val(name)
  }

  function pickOwner(name, id, type) {
    $("#owner-id").val(id)
    $("#owner-type").val(type)
    $("#owner").val(name)
  }

  function installRemindSpecies(section) {
    var timeout
    var input = $("#" + section)
    var suggest = $("#" + section + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
          global['url'],
          { action: 'species', keyword: key },
          (response, status) => {
            checkResult(response, status).then(data => {
              suggest.html(data['html'])
            }, () => { })
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

  function installRemind3(section) {
    var timeout
    var input = $("#" + section)
    var suggest = $("#" + section + "-suggest")


    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
          global['url'],
          { action: 'owner', keyword: key },
          (response, status) => {
            checkResult(response, status).then(data => {
              suggest.html(data['html'])
            }, () => { })
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

  function addTarget() {
    modalTarget.modal('show')
  }

  function addDiseaseSuggest() {
    insertDiseaseSuggest.modal('show')
  }

  function insertDiseaseSuggestSubmit() {
    $.post(
      global['url'],
      { action: 'insert-disease-suggest', disease: $('#disease-suggest').val() },
      (response, status) => {
        checkResult(response, status).then(data => {
          insertDiseaseSuggest.modal('hide')
          vaccine['type'].html(data['html'])
        }, () => { })
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
      { action: 'insertpet', data: checkInputSet(pet) },
      (response, status) => {
        checkResult(response, status).then(data => {
          clearInputSet(pet)
          petPreview.val('')
          remind = JSON.parse(data['remind'])
          $("#species").val("")
          $("#breeder-target").val(data['name'])
          $("#breeder-targetid").val(data['id'])
          modalTarget.modal('hide')
        }, () => {
        })
      }
    )
  }
  // function insertPetSubmit() {
  //   $.post(
  //     global['url'],
  //     { action: 'insertpet', data: checkInputSet(pet) },
  //     (response, status) => {
  //       checkResult(response, status).then(data => {
  //         clearInputSet(pet)
  //         petPreview.val('')
  //         remind = JSON.parse(data['remind'])
  //         $("#child-" + global['childid']).val(data['name'])
  //         $("#childid-" + global['childid']).val(data['id'])
  //         insertPet.modal('hide')
  //       }, () => {
  //       })
  //     }
  //   )
  // }

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

  function addDisease() {
    insertDisease.modal('show')
  }

  function editBreeder (id) {
    insertBreeder.modal('show')
    $.post(
      global['url'],
      { action: 'get-breeder', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          parseInputSet(data['data'], breeder);
          global['breeder'] = id
          $("#breeder-target").val(data['name'])
          button['breeder']['edit'].show()
          button['breeder']['insert'].hide()
        }, () => {})
      }
    )
  }

  function addBreeder() {
    insertBreeder.modal('show')
    button['breeder']['edit'].show()
    button['breeder']['insert'].hide()
  }

  function editBreederSubmit() {
    $.post(
      global['url'],
      { action: 'edit-breeder', data: checkInputSet(breeder), bid: global['breeder'], id: global['id'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          breederContent.html(data['html'])
          clearInputSet(breeder)
          $("#breeder-time").val(def['today'])
          $("#breeder-target").val('')
          $("#breeder-number").val('1')
          insertBreeder.modal('hide')
        }, () => {
        })
      }
    )
  }

  function insertBreederSubmit() {
    $.post(
      global['url'],
      { action: 'insert-breeder', data: checkInputSet(breeder), id: global['id'] },
      // {action: 'insert-breeder', data: checkInputSet(breeder), id: global['id'], child: checkChild()},
      (response, status) => {
        checkResult(response, status).then(data => {
          breederContent.html(data['html'])
          global['child'] = []
          clearInputSet(breeder)
          $("#breeder-time").val(def['today'])
          $("#breeder-number").val('1')
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

  // function checkDiseaseData() {
  //   return {
  //     treat: diseaseTreat.val(),
  //     treated: diseaseTreated.val(),
  //     disease: diseaseDisease.val(),
  //     note: diseaseNote.val(),
  //   }
  // }

  function checkVaccineData() {
    var type = vaccine['type'].val().split('-')
    return {
      type: type['0'],
      val: type['1'],
      time: vaccine['time'].val(),
      recall: vaccine['recall'].val()
    }
  }

  function addVaccine(id) {
    petVaccine.modal('show')
  }

  function insertVaccineSubmit() {
    $.post(
      global['url'],
      { action: 'insert-vaccine', data: checkVaccineData(), id: global['id'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          vaccineContent.html(data['html'])
          petVaccine.modal('hide')
        }, () => { })
      }
    )
  }


  function insertDiseaseSubmit() {
    $.post(
      global['url'],
      { action: 'insert-disease', id: global['id'], data: checkDiseaseData() },
      (response, status) => {
        checkResult(response, status).then(data => {
          diseaseContent.html(data['html'])
          insertDisease.modal('hide')
        }, () => { })
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
          { action: 'target', keyword: key, index: index, func: func },
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
          { action: 'disease', keyword: key },
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
        { action: 'editpet', id: global['id'], data: checkInputSet(pet), image: imageUrl },
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

  function toggleX(name) {
    var target = $("#" + name)
    if (target.css('display') == 'block') {
      $("#" + name + "on").show()
      $("#" + name + "off").hide()
    }
    else {
      $("#" + name + "on").hide()
      $("#" + name + "off").show()
    }
    target.toggle()
  }

  $(document).ready(function(){
    installRemindv2('pet', 'breed')
    installRemindv2('pet', 'origin')
    installRemindSpecies('species')

    installRemind('target', 'breeder')
    installRemind2('disease', 'disease')
    installRemind3('owner')

    $('[data-toggle="popover"]').popover({
      placement: 'left',
    });

    $('[data-toggle="popover"]').click(function (e) {
      e.stopPropagation();
      var name = e.currentTarget.children[0].className
    });
  });

  $(document).click(function (e) {
    if (($('.popover').has(e.target).length == 0) || $(e.target).is('.close')) {
      $('[data-toggle="popover"]').popover('hide');
    }
  });
</script>
<!-- END: main -->
