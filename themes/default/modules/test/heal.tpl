<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>


<div id="heal-remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
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
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row form-group">
          <label class="col-sm-6">Khách hàng</label>
          <div class="col-sm-8 relative">
            <input type="text" class="form-control" id="heal-insert-customer" autocomplete="off">
            <div class="suggest" id="customer-suggest"> {customer_suggest} </div>
          </div>
          <label class="col-sm-4">Thú nuôi</label>
          <div class="col-sm-6"> <select class="form-control" id="heal-insert-pet"> </select> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6">Lứa tuổi</label>
          <div class="col-sm-2"><input type="text" class="form-control" id="heal-insert-age" value="1" placeholder="Năm" autocomplete="off"> </div>
          <label class="col-sm-4"> Cân nặng </label>
          <div class="col-sm-2"><input type="text" class="form-control" id="heal-insert-weight" value="1" placeholder="kg" autocomplete="off"> </div>
          <label class="col-sm-4"> Giống loài </label>
          <div class="col-sm-6">
            <select class="form-control" id="heal-insert-species"></select>
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Hệ thống điều trị </label>
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
          <label class="col-sm-6"> Hướng điều trị </label>
          <div class="col-sm-18">
            <input type="text" class="form-control" id="heal-insert-oriental" autocomplete="off">
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Triệu chứng </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-appear" autocomplete="off"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Xét nghiệm </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-exam" autocomplete="off"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Siêu âm </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-usg" autocomplete="off"> </div> 
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> X-quang </label>
          <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-xray" autocomplete="off"> </div> 
        </div>
        <div class="row">
          <label class="col-sm-6"> Thuốc điều trị  </label>
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
          <div style="width: 100%; height: 150px; margin: 4px; padding: 4px; overflow-y: scroll;" id="heal-drug-list">

          </div>
        </div>
        <div class="text-center">
          <button class="stat btn btn-info status0" id="heal-healed-button" status="0"> Đã điều trị </button>
          <button class="stat btn btn-warning status1" id="heal-healing-button" status="1"> Đang điều trị </button>
          <button class="stat btn btn-danger status2" id="heal-dead-button" status="2"> Đã tèo </button><br>
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
  <select class="form-control" id="limit">
    <option value="10">10</option>
    <option value="20">20</option>
    <option value="50">50</option>
    <option value="100">100</option>
  </select>
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
      <button class="btn btn-info" onclick="filter()">
        <span class="glyphicon glyphicon-filter"></span>
      </button>
      <button class="btn btn-success" onclick="insert()">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>
  </div>
</div>

<div id="content">
  {content}
</div>
<script>
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
  var cometime = $("#cometime")
  var calltime = $("#calltime")
  var limit = $("#limit")
  var content = $('#content')

  var customerSuggest = $("#customer-suggest")

  var type = $(".type")
  var insult = $(".insult")
  var sa = $(".sa")
  var stat = $(".stat")

  var editData = {}
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

  function parseButton() {
    stat.removeClass('active')
    stat.each((index, item) => {
      item.classList.remove(BUTTON_DATA[index])
    })
    $('.status' + g_status).addClass(BUTTON_DATA[g_status])
    $('.status' + g_status).addClass('active')
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
    g_filterPet = index
    healPetFilter.val(dbdata[g_customerid]['pet'][g_filterPet]['name'])
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
    g_filterPet = 0
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
      g_filterCustomer = index
      healCustomerFilter.val(dbdata[index]['name'])
    }
  }

  function filter() {
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: page, limit: limit.val(), cometime: cometime.val(), calltime: calltime.val(), customer: g_filterCustomer, pet: g_filterPet},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
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

          parseButton()

          var temp = data['customer']
          temp['pet'] = [data['pet']]
          dbdata = [temp]
          
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
          healSystemSuggest.hide()
          healInsertButton.hide()
          healEditButton.show()
          healInsert.modal('show')
          parsePet(0, 0)
        }, () => {})
      }
    )
  }

  function editSubmit() {
    var system = gatherSystem()
    $.post(
      strHref,
      {action: 'edit', id: g_id, petid: g_petid, status: g_status, age: healInsertAge.val(), weight: healInsertWeight.val(), species: healInsertSpecies.val(), system: system, oriental: healInsertOriental.val(), appear: healInsertAppear.val(), exam: healInsertExam.val(), usg: healInsertUsg.val(), xray: healInsertXray.val(), drug: drugList, page: page, limit: limit.val(), cometime: cometime.val(), calltime: calltime.val(), customer: g_filterCustomer, pet: g_filterPet},
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
      {action: 'remove', id: g_id, page: page, limit: limit.val(), cometime: cometime.val(), calltime: calltime.val(), customer: g_filterCustomer, pet: g_filterPet},
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

    $.post(
      strHref,
      {action: 'insert', petid: g_petid, status: g_status, age: healInsertAge.val(), weight: healInsertWeight.val(), species: healInsertSpecies.val(), system: system, oriental: healInsertOriental.val(), appear: healInsertAppear.val(), exam: healInsertExam.val(), usg: healInsertUsg.val(), xray: healInsertXray.val(), drug: drugList, page: page, limit: limit.val(), cometime: cometime.val(), calltime: calltime.val(), customer: g_filterCustomer, pet: g_filterPet},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          healInsert.modal('hide')
        }, () => {})
      }
    )
  }
  
</script>
<!-- END: main -->
