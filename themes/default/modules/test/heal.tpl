<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="heal-filter" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div id="heal-filter-content">

        </div>
      </div>
    </div>
  </div>
</div>

<div id="heal-remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        Bạn có muốn xóa trường này không?
        <div class="text-center">
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xóa
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="heal-insert" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div class="row form-group">
          <label class="col-sm-4">Khách hàng</label>
          <div class="col-sm-8 relative">
            <div class="input-group">
              <input type="text" class="form-control" id="heal-insert-customer" autocomplete="off">
              <div class="input-group-btn">
                <button class="btn btn-success" id="heal-insert-customer-button" onclick="addCustomer()"> <span class="glyphicon glyphicon-plus"></span> </button>
              </div>
            </div>
            <div class="suggest" id="customer-suggest"> {customer_suggest} </div>
          </div>
          <label class="col-sm-4">Thú cưng</label>
          <div class="col-sm-6">
            <div class="input-group">
              <select class="form-control" id="heal-insert-pet"></select>
              <div class="input-group-btn">
                <button class="btn btn-success" id="heal-insert-pet-button" onclick="addPet()"> <span class="glyphicon glyphicon-plus"></span> </button>
              </div>
            </div>
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-4">Lứa tuổi</label>
          <div class="col-sm-2"><input type="text" class="form-control" id="heal-insert-age" value="1" placeholder="Năm" autocomplete="off"> </div>
          <label class="col-sm-4"> Cân nặng </label>
          <div class="col-sm-2"><input type="text" class="form-control" id="heal-insert-weight" value="1" placeholder="kg" autocomplete="off"> </div>
          <label class="col-sm-4"> Giống loài </label>
          <div class="col-sm-6">
            <select class="form-control" id="heal-insert-species"></select>
          </div>
        </div>
        <!-- BEGIN: manager -->
        <div class="row form-group">
          <label class="col-sm-4"> Bác sỹ điều trị </label>
          <div class="col-sm-18">
            <select class="form-control" id="heal-insert-doctor">
              <!-- BEGIN: doctor -->
              <option value="{value}">{name}</option>
              <!-- END: doctor -->
            </select>
          </div>
        </div>
        <!-- END: manager -->
        <div class="row form-group">
          <label class="col-sm-4"> Hệ thống điều trị </label>
          <div class="col-sm-18 relative">
            <input type="text" class="form-control" id="heal-insert-system" autocomplete="off">
            <div class="suggest" id="heal-system-suggest">
              <!-- BEGIN: system -->
              <div class="item-suggest sa" id="sa{systemid}"> {system} <input type="checkbox" class="right s" id="s{systemid}"></div>
              <!-- END: system -->
            </div>
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-4"> Hướng điều trị </label>
          <div class="col-sm-18">
            <input type="text" class="form-control" id="heal-insert-oriental" autocomplete="off">
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-4"> Triệu chứng </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-appear" autocomplete="off"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-4"> Xét nghiệm </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-exam" autocomplete="off"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-4"> Siêu âm </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-usg" autocomplete="off"> </div> 
        </div>
        <div class="row form-group">
          <label class="col-sm-4"> X-quang </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-xray" autocomplete="off"> </div> 
        </div>
        <div class="row">
          <label class="col-sm-4"> Thuốc điều trị  </label>
          <div class="col-sm-8">
            <div class="input-group">
              <input type="text" class="form-control" id="heal-insert-drug" autocomplete="off"> 
              <div class="input-group-btn">
                <button class="btn" onclick="clearDrug()"> <span class="glyphicon glyphicon-remove"></span> </button>
              </div>
            </div>
            <div class="suggest" id="heal-drug-suggest"> {drug_suggest} </div> 
          </div>
          <div class="col-sm-10">
            <div class="input-group">
              <span class="input-group-addon" id="heal-drug-unit"></span>
              <input type="text" class="form-control" id="heal-drug-quality" autocomplete="off">
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="addDrug()"> <span class="glyphicon glyphicon-plus"></span> </button>
              </div>
            </div>
          </div>
          <div style="width: 100%; height: 150px; margin: 4px; padding: 4px; overflow-y: scroll;" id="heal-drug-list"></div>
            
        </div>
        <div class="row form-group">
          <label class="col-sm-4"> Ghi chú </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-note" autocomplete="off"> </div> 
        </div>
        <div class="text-center">
          <button class="stat btn btn-info stat0" id="heal-healed-button" status="0"> Đã điều trị </button>
          <button class="stat btn btn-warning stat1" id="heal-healing-button" status="1"> Đang điều trị </button>
          <button class="stat btn btn-danger stat2" id="heal-dead-button" status="2"> Đã chết </button><br>
          <div class="form-group">
            <select class="form-control" id="heal-insert-insult">
              <option value="-1"> Tệ </option>
              <option value="0"> Hơi tệ </option>
              <option value="1"> Bình thường </option>
              <option value="2"> Tốt </option>
            </select>
          </div>
          <button class="btn btn-success" id="heal-insert-button" onclick="insertSubmit()"> Thêm</button>
          <button class="btn btn-success" id="heal-edit-button" onclick="editSubmit()"> Sửa</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="heal-summary" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-inline">
          <label> Từ ngày </label>
          <input type="text" class="form-control" id="summary-cometime" value="{cometime}" autocomplete="off">
          <label> Đến ngày </label>
          <input type="text" class="form-control" id="summary-calltime" value="{calltime}" autocomplete="off">
        </div>
        <div id="heal-summary-content">
          {summary}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="form-inline">
  <label> Từ ngày </label>
  <input type="text" class="form-control" id="cometime" value="{cometime}" autocomplete="off">
  <label> Đến ngày </label>
  <input type="text" class="form-control" id="calltime" value="{calltime}" autocomplete="off">
</div>
<div class="form-inline">
  <div class="row">
    <div class="col-sm-8 relative">
      <div class="input-group">
        <input type="text" class="form-control" id="heal-customer-filter" placeholder="Khách hàng" autocomplete="off">
        <div class="input-group-btn">
          <button class="btn" onclick="clearCustomer()"> <span class="glyphicon glyphicon-remove"></span> </button>
        </div>
      </div>
      <div class="suggest" id="customer-filter-suggest"> {customer_suggest} </div>
    </div>
    <div class="col-sm-8 relative">
      <div class="input-group">
        <input type="text" class="form-control" id="heal-pet-filter" placeholder="Thú cưng" autocomplete="off">
        <div class="input-group-btn">
          <button class="btn" onclick="clearPet()"> <span class="glyphicon glyphicon-remove"></span> </button>
        </div>
      </div>
      <div class="suggest" id="pet-filter-suggest"></div>
    </div>
    <div class="col-sm-7 input-group">
      <button class="btn btn-info" onclick="filterBy()">
        <span class="glyphicon glyphicon-filter"></span>
      </button>
      <button class="btn btn-success" onclick="insert()">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>
  </div>
</div>

<div class="form-inline">
  <button class="global-stat btn btn-info active status0" id="heal-healed-button" status="0"> Đã điều trị </button>
  <button class="global-stat btn status1" id="heal-healing-button" status="1"> Đang điều trị </button>
  <button class="global-stat btn status2" id="heal-dead-button" status="2"> Đã chết </button>
  <select class="form-control" id="limit">
    <option value="10">10</option>
    <option value="20">20</option>
    <option value="50">50</option>
    <option value="100">100</option>
  </select>
</div>

<div id="content">
  {content}
</div>
<script>
  var healCustomer = $("#heal-customer")
  var healCustomerName = $("#heal-customer-name")
  var healCustomerPhone = $("#heal-customer-phone")
  var healCustomerAddress = $("#heal-customer-address")
  var healCustomerPetname = $("#heal-customer-petname")
  var healCustomerWeight = $("#heal-customer-weight")
  var healCustomerAge = $("#heal-customer-age")
  var healCustomerSpecies = $("#heal-customer-species")

  var healInsert = $("#heal-insert")
  var healRemove = $("#heal-remove")
  var healSummaryContent = $("#heal-summary-content")
  var summaryCometime = $("#summary-cometime")
  var summaryCalltime = $("#summary-calltime")
  var healInsertCustomer = $("#heal-insert-customer")
  var healInsertPet = $("#heal-insert-pet")
  var healInsertAge = $("#heal-insert-age")
  var healInsertWeight = $("#heal-insert-weight")
  var healInsertSpecies = $("#heal-insert-species")
  var healInsertSystem = $("#heal-insert-system")
  var healSystemSuggest = $("#heal-system-suggest")
  var healInsertOriental = $("#heal-insert-oriental")
  var healInsertAppear = $("#heal-insert-appear")
  var healInsertExam = $("#heal-insert-exam")
  var healInsertUsg = $("#heal-insert-usg")
  var healInsertXray = $("#heal-insert-xray")
  var healInsertNote = $("#heal-insert-note")
  var healInsertDrug = $("#heal-insert-drug")
  var healDrugSuggest = $("#heal-drug-suggest")
  var healDrugQuality = $("#heal-drug-quality")
  var healDrugUnit = $("#heal-drug-unit")
  var healDrugList = $("#heal-drug-list")
  var healCustomerFilter = $("#heal-customer-filter")
  var customerFilterSuggest = $("#customer-filter-suggest")
  var healPetFilter = $("#heal-pet-filter")
  var petFilterSuggest = $("#pet-filter-suggest")
  var healInsertButton = $("#heal-insert-button")
  var healEditButton = $("#heal-edit-button")
  var healHealingButton = $("#heal-healing-button")
  var healHealedButton = $("#heal-healed-button")
  var healDeadButton = $("#heal-dead-button")
  var summaryCalltime = $("#summary-calltime")
  var healInsertInsult = $("#heal-insert-insult")
  var cometime = $("#cometime")
  var calltime = $("#calltime")
  var limit = $("#limit")
  var content = $('#content')

  var healFilter = $("#heal-filter")
  var healFilterContent = $("#heal-filter-content")
  var healInsertDoctor = $("#heal-insert-doctor")
  var healInsertCustomerButton = $("#heal-insert-customer-button")
  var healInsertPetButton = $("#heal-insert-pet-button")

  var customerSuggest = $("#customer-suggest")

  var type = $(".type")
  var insult = $(".insult")
  var sa = $(".sa")
  var stat = $(".stat")
  var globalStat = $(".global-stat")

  var editData = {}
  var g_doctorid = '{doctorid}'
  var dbdata = JSON.parse('{dbdata}')
  var drugData = JSON.parse('{drug}')
  var systemData = JSON.parse('{system}')
  var addData = JSON.parse(localStorage.getItem('add-list'))
  var drugList = {}
  var mode = 0
  var g_id = 0
  var g_type = 0
  var g_customerid = 0
  var g_petid = 0
  var page = 1
  var customerTimeout
  var customerFilterTimeout
  var PetFilterTimeout
  var drugTimeout
  var g_system = 0
  var g_target 
  var g_filterCustomer = 0
  var g_filterPet = 0
  var g_status = 0
  var global_status = 0

  const BUTTON_DATA = ['btn-info', 'btn-warning', 'btn-danger']

  $('#summary-cometime, #summary-calltime, #cometime, #calltime').datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  sa.click((e) => {
    var target = e.currentTarget
    var id = (target.children[0].getAttribute('id')).replace('sa', '')
    var check = $('#' + id)
    var system = []
    check.prop("checked", !check.prop("checked"));
    for (const key in sa) {
      if (sa.hasOwnProperty(key)) {
        const element = sa[key];
        var text = element.innerText
        if (text && element.children[0]['checked']) {
          system.push(text)
        }
      }
    }
    healInsertSystem.val(system.join(', '))
  })
  
  type.click((e) => {
    var target = e.currentTarget
    type.removeClass('active')
    type.removeClass('btn-warning')
    target.classList.add('active')
    target.classList.add('btn-warning')
    g_type = target.getAttribute('type')
    filter()
  })

  healInsertCustomer.keyup(() => {
    if (!g_id) {
      clearTimeout(customerTimeout)
      customerTimeout = setTimeout(() => {
        filterCustomer(customerSuggest, healInsertCustomer)
      }, 200);
    }
  })

  healCustomerFilter.keyup(() => {
    clearTimeout(customerTimeout)
    customerTimeout = setTimeout(() => {
      filterCustomer(customerFilterSuggest, healCustomerFilter)
    }, 200);
  })

  healPetFilter.keyup(() => {
    if (dbdata.length) {
      clearTimeout(customerTimeout)
      customerTimeout = setTimeout(() => {
        filterPet(petFilterSuggest, healPetFilter.val(), g_customerid)
      }, 200);
    }
  })

  healInsertDrug.keyup(() => {
    clearTimeout(drugTimeout)
    drugTimeout = setTimeout(() => {
      var keyword = healInsertDrug.val().toLowerCase()
      html = ''
      for (const index in drugData) {
        if (drugData.hasOwnProperty(index)) {
          const drug = drugData[index];
          if (drug['name'].toLowerCase().search(keyword) >= 0) {
            html += '<div class="item-suggest" onclick="selectDrug('+index+',\''+drug['unit']+'\')"> ' + drug['name'] + ' </div> '
          }
        }
      }
      healDrugSuggest.html(html)
    }, 200);
  })

  healInsertSystem.click(() => {
    if (g_system = !g_system) {
      healSystemSuggest.show()
    }
    else {
      healSystemSuggest.hide()
    }
  })

  healInsertCustomer.focus(() => {
    customerSuggest.show()
  })
  healCustomerFilter.focus(() => {
    customerFilterSuggest.show()
  })
  healPetFilter.focus(() => {
    petFilterSuggest.show()
  })
  healInsertCustomer.blur(() => {
    setTimeout(() => {
      customerSuggest.hide()
    }, 200);
  })
  healCustomerFilter.blur(() => {
    setTimeout(() => {
      customerFilterSuggest.hide()
    }, 200);
  })
  healPetFilter.blur(() => {
    setTimeout(() => {
      petFilterSuggest.hide()
    }, 200);
  })

  healInsertDrug.focus(() => {
    healDrugSuggest.show()
  })
  healInsertDrug.blur(() => {
    setTimeout(() => {
      healDrugSuggest.hide()
    }, 200);
  })

  healInsertPet.change((e) => {
    var target = e.target
    parsePet(g_customerid, target.selectedIndex)
  })

  stat.click((e) => {
    var target = e.target
    var id = target.getAttribute('status')
    g_status = id

    parseButton()
  })

  globalStat.click((e) => {
    var target = e.target
    var id = target.getAttribute('status')
    global_status = id

    filter()
  })

  function addPet() {
      answer = prompt('Nhập tên thú cưng của ' + dbdata[g_customerid]['name'], '');
      if (answer) {
        $.post(
          strHref,
          {action: 'add-pet', name: answer, customerid: dbdata[g_customerid]['id']},
          (response, status) => {
            checkResult(response, status).then(data => {
              dbdata = data['customer']
              g_petid = 0
              g_customerid = 0
              parsePet(g_customerid, g_petid)
            }, () => {})
          }
        )
      }
  }

  function addCustomer() {
    var phone = healInsertCustomer.val()
    if (Number.isFinite(Number(phone)) && phone.length > 9 && phone.length < 15) {
      answer = prompt('Nhập số tên khách hàng cho số điện thoại ' + phone, '');
      if (answer) {
        $.post(
          strHref,
          {action: 'add-customer', name: answer, phone: phone},
          (response, status) => {
            checkResult(response, status).then(data => {
              dbdata = data['customer']
              g_customerid = 0
            }, () => {})
          }
        )
      }
    }
  }

  function parseButton() {
    stat.removeClass('active')
    stat.each((index, item) => {
      item.classList.remove(BUTTON_DATA[index])
    })
    
    if (!Number(g_status)) {
      healInsertInsult.show()
    }
    else {
      healInsertInsult.hide()
    }
    console.log(BUTTON_DATA[g_status]);
    
    $('.stat' + g_status).addClass(BUTTON_DATA[g_status])
    $('.stat' + g_status).addClass('active')
  }

  function parseGlobalButton() {
    globalStat.removeClass('active')
    globalStat.each((index, item) => {
      item.classList.remove(BUTTON_DATA[index])
    })
    $('.status' + global_status).addClass(BUTTON_DATA[global_status])
    $('.status' + global_status).addClass('active')
  }

  function clearCustomer() {
    g_filterCustomer = 0
    g_filterPet = 0
    healCustomerFilter.val('')
    healPetFilter .val('')
  }

  function clearPet () {
    g_filterPet = 0
    healPetFilter .val('')
  }

  function filterCustomer(target, keyword) {
    $.post(
      strHref,
      {action: 'customer-suggest', keyword: keyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          dbdata = JSON.parse(data['customer'])
          parseSuggest(target)
        }, () => {})
      }
    )
  }

  function filterPet(target, keyword, customerid) {
    var html = ''
    for (const key in dbdata[customerid]['pet']) {
      if (dbdata[customerid]['pet'].hasOwnProperty(key)) {
        const pet = dbdata[customerid]['pet'][key];
        if (pet['name'].search(keyword) >= 0) {
          html += '<div class="item-suggest" onclick="selectPet('+key+')">' + pet['name'] +' </div>';
        }
      }
    }
    petFilterSuggest.html(html)
  }

  function selectPet(index) {
    g_petid = index
    g_filterPet = dbdata[g_customerid]['pet'][index]['id']
    healPetFilter.val(dbdata[g_customerid]['pet'][index]['name'])
  }

  function addDrug() {
    var quality = Number(healDrugQuality.val())
    if (drugData[g_drug] && Number.isFinite(quality)) {
      if (!drugList[g_drug]) {
        drugList[g_drug] = 0
      }
      drugList[g_drug] += quality
      parseDrug()
    }
  }

  function removeDrug(index) {
    delete drugList[index]
    parseDrug()
  }

  function parseDrug() {
    var html = ''
    for (const key in drugList) {
      if (drugList.hasOwnProperty(key)) {
        const drug = drugList[key];
        html += '<div class="item-suggest" style="overflow: auto">' + drugData[key]['name'] + '<div class="right">'+drug + ' '+drugData[key]['unit']+' <button class="btn btn-danger" onclick="removeDrug('+key+')"> <span class="glyphicon glyphicon-remove"> </span> </button></div></div>'
      }
    }
    healDrugList.html(html)
  }

  function selectDrug(index, unit) {
    g_drug = index
    healDrugUnit.text(unit)
    healDrugQuality.val(1)
    healInsertDrug.val(drugData[index]['name'])
  }

  function parseSuggest(target) {
    var html = ''
    for (const index in dbdata) {
      if (dbdata.hasOwnProperty(index)) {
        const customer = dbdata[index];
        html += '<div class="item-suggest" onclick="parsePet('+index+', 0)">' + customer['name'] + '<div class="right"> '+ customer["phone"] +' </div> </div>';
      }
    }
    target.html(html)
  }

  function parsePet(index, index2) {
    var html = ''
    g_customerid = index
    healInsertCustomer.val(dbdata[index]['name'])
    
    dbdata[index]['pet'].forEach((pet, petindex) => {
      var check = ''
      if (petindex == index2) {
        healInsertWeight.val(pet['weight'])
        healInsertAge.val(pet['age'])
        healInsertSpecies.html(pet['species'])
        check = 'selected'
        g_petid = pet['id']

        stat.removeClass('active')
        g_status = dbdata[g_customerid]['pet'][petindex]['status']
        $('.status' + g_status).addClass('active')
      }
      html += '<option value="'+pet['id']+'" ' + check + '>' + pet['name'] +' </option>';
    })
    var modal = (healInsert.data('bs.modal') || {}).isShown
    if (modal) {
      healInsertPet.html(html)
    }
    else {
      g_filterCustomer = dbdata[g_customerid]['id']
      healCustomerFilter.val(dbdata[index]['name'])
    }
  }

  function filter() {
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: page, limit: limit.val(), customer: g_filterCustomer, pet: g_filterPet, status: global_status, gdoctor: g_doctorid},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          parseGlobalButton()
        }, () => {})
      }
    )
  }

  function filterBy() {
    freeze()
    $.post(
      strHref,
      {action: 'filter-by', cometime: cometime.val(), calltime: calltime.val(), customer: g_filterCustomer, pet: g_filterPet, gdoctor: g_doctorid},
      (response, status) => {
        checkResult(response, status).then(data => {
          healFilterContent.html(data['html'])
          healFilter.modal('show')
        }, () => {})
      }
    )
  }

  function clearDrug() {
    healInsertDrug.val('')
    healDrugQuality.val('')
    healDrugUnit.text('')
    g_drug = -1
  }

  function remove(id) {
    g_id = id
    healRemove.modal('show')
  }

  function insert() {
    g_id = 0
    g_customerid = 0
    g_petid = 0
    g_target = healInsertPet
    g_status = 0

    healInsertCustomerButton.show()
    healInsertPetButton.show()
    healInsertPet.html('')
    
    parseButton()

    drugList = {}
    parseDrug()
    $(".s").each((index, item) => {
      item.check = false
    })  
    healInsertSystem.val('')
    healInsertCustomer.val('')
    healInsertWeight.val('')
    healInsertAge.val('')
    healInsertSpecies.html('')
    healInsertAppear.val('')
    healInsertExam.val('')
    healInsertOriental.val('')
    healInsertUsg.val('')
    healInsertXray.val('')
    healInsertNote.val('')
    healSystemSuggest.hide()
    healInsertButton.show()
    healEditButton.hide()
    healInsert.modal('show')
  }

  function gatherSystem() {
    var system = []
    for (const key in sa) {
      if (sa.hasOwnProperty(key)) {
        const element = sa[key];
        var text = element.innerText
        if (text && element.children[0]['checked']) {
          var id = (element.children[0].getAttribute('id')).replace('s', '')
          
          system.push(id)
        }
      }
    }
    return system;
  }
  
    function goPage(pPage) {
    freeze()
    $.post(
      strHref,
      {action: "filter", page: pPage, limit: limit.val(), customer: g_filterCustomer, pet: g_filterPet, status: global_status, gdoctor: g_doctorid},
      (response, status) => {
        checkResult(response, status).then((data) => {
          page = pPage
          content.html(data["html"])
        }, () => {})
      }
    )
  }

  function edit(id) {
    freeze()
    $.post(
      strHref,
      {action: 'get_edit', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          editData = data
          g_id = id
          g_customerid = data['customer']['id']
          g_petid = data['pet']['id']
          g_system = 0
          g_target = healInsertPet
          g_status = data['pet']['status']
          healInsertCustomerButton.hide()
          healInsertPetButton.hide()

          parseButton()

          var temp = data['customer']
          temp['pet'] = [data['pet']]
          dbdata = [temp]
          
          customerSuggest.html('')
          customerFilterSuggest.html('')
          
          drugList = {}
          data['drug'].forEach(drug => {
            drugList[drug['medicineid']] = drug['quanlity']
          })
          parseDrug()

          var text = []
          $(".s").each((index, item) => {
            item.checked = false
          })  

          data['system'].forEach(system => {
            text.push(systemData[system['systemid']]['name'])
            $("#s" + system['systemid']).prop('checked', true)
          })
          healInsertSystem.val(text.join(', '))

          healInsertCustomer.val(data['customer']['name'])
          healInsertWeight.val(data['pet']['weight'])
          healInsertAge.val(data['pet']['age'])
          healInsertSpecies.html(data['pet']['species'])
          healInsertAppear.val(data['appear'])
          healInsertExam.val(data['exam'])
          healInsertOriental.val(data['oriental'])
          healInsertUsg.val(data['usg'])
          healInsertXray.val(data['xray'])
          healInsertXray.val(data['note'])
          healSystemSuggest.hide()
          healInsertButton.hide()
          healEditButton.show()
          healInsert.modal('show')
          parsePet(0, 0)
        }, () => {})
      }
    )
  }

  function copy(id) {
    freeze()
    $.post(
      strHref,
      {action: 'get_edit', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          editData = data
          g_id = id
          g_customerid = data['customer']['id']
          g_petid = data['pet']['id']
          g_system = 0
          g_target = healInsertPet
          g_status = data['pet']['status']
          healInsertCustomerButton.hide()
          healInsertPetButton.hide()

          parseButton()

          var temp = data['customer']
          temp['pet'] = [data['pet']]
          dbdata = [temp]
          
          customerSuggest.html('')
          customerFilterSuggest.html('')
          
          drugList = {}
          data['drug'].forEach(drug => {
            drugList[drug['medicineid']] = drug['quanlity']
          })
          parseDrug()

          var text = []
          $(".s").each((index, item) => {
            item.checked = false
          })  

          data['system'].forEach(system => {
            text.push(systemData[system['systemid']]['name'])
            $("#s" + system['systemid']).prop('checked', true)
          })
          healInsertSystem.val(text.join(', '))

          healInsertCustomer.val(data['customer']['name'])
          healInsertWeight.val(data['pet']['weight'])
          healInsertAge.val(data['pet']['age'])
          healInsertSpecies.html(data['pet']['species'])
          healInsertAppear.val(data['appear'])
          healInsertExam.val(data['exam'])
          healInsertOriental.val(data['oriental'])
          healInsertUsg.val(data['usg'])
          healInsertXray.val(data['xray'])
          healInsertNote.val(data['note'])
          healSystemSuggest.hide()
          healInsertButton.show()
          healEditButton.hide()
          healInsert.modal('show')
          parsePet(0, 0)
        }, () => {})
      }
    )
  }

  function editSubmit() {
    var system = gatherSystem()
    if (g_doctorid) {
      doctorid = g_doctorid
    }
    else {
      doctorid = healInsertDoctor.val()
    }
    $.post(
      strHref,
      {action: 'edit', id: g_id, petid: g_petid, status: g_status, age: healInsertAge.val(), weight: healInsertWeight.val(), species: healInsertSpecies.val(), system: system, oriental: healInsertOriental.val(), appear: healInsertAppear.val(), exam: healInsertExam.val(), usg: healInsertUsg.val(), xray: healInsertXray.val(), note: healInsertNote.val(), insult: healInsertInsult.val(), drug: drugList, page: page, limit: limit.val(), customer: g_filterCustomer, pet: g_filterPet, fstatus: global_status, doctorid: doctorid, gdoctor: g_doctorid},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          healInsert.modal('hide')
        }, () => {})
      }
    )
  }
  
  function removeSubmit() {
    $.post(
      strHref,
      {action: 'remove', id: g_id, page: page, limit: limit.val(), customer: g_filterCustomer, pet: g_filterPet, status: global_status, gdoctor: g_doctorid},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          healRemove.modal('hide')
        }, () => {})
      }
    )
  }
  
  function insertSubmit() {
    var system = gatherSystem()
    if (g_doctorid) {
      doctorid = g_doctorid
    }
    else {
      doctorid = healInsertDoctor.val()
    }
    if (!g_petid) {
      alert_msg('Chưa chọn thú cưng');
    }
    else {
      $.post(
        strHref,
        {action: 'insert', petid: g_petid, status: g_status, age: healInsertAge.val(), weight: healInsertWeight.val(), species: healInsertSpecies.val(), system: system, oriental: healInsertOriental.val(), appear: healInsertAppear.val(), exam: healInsertExam.val(), usg: healInsertUsg.val(), xray: healInsertXray.val(), note: healInsertNote.val(), insult: healInsertInsult.val(), drug: drugList, page: page, limit: limit.val(), customer: g_filterCustomer, pet: g_filterPet, fstatus: global_status, doctorid: doctorid, gdoctor: g_doctorid},
        (response, status) => {
          checkResult(response, status).then(data => {
            content.html(data['html'])
            healInsert.modal('hide')
          }, () => {})
        }
      )
    }
  }
  
</script>
<!-- END: main -->
