<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="drug-remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body text-center">
        <p>
          Xác nhận xóa loại thuốc <span id="drug-remove-name"></span>
        </p>
        <button class="btn btn-danger" onclick="removeSubmit()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="drug-edit" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row form-group">
          <label class="col-sm-6"> Mã vạch </label>
          <div class="col-sm-18"> <input class="form-control"type="text" id="drug-edit-code"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Tên thuốc</label>
          <div class="col-sm-8"> <input class="form-control"type="text" id="drug-edit-name"> </div>
          <label class="col-sm-6"> Đơn vị </label>
          <div class="col-sm-4"> <input class="form-control"type="text" id="drug-edit-unit"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Hệ thống tác động </label>
          <div class="col-sm-18 relative">
            <input type="text" class="form-control" id="drug-edit-system" autocomplete="off">
            <div class="suggest" id="drug-system-suggest">
              {system_list}
            </div>
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Liều dùng </label>
          <div class="col-sm-18"> <textarea class="form-control"type="text" id="drug-edit-limit"></textarea> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Công dụng </label>
          <div class="col-sm-18"> <textarea class="form-control"type="text" id="drug-edit-effect"></textarea> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Điều trị bệnh </label>
          <div class="col-sm-8">
            <div class="input-group form-group">
              <div class="relative">
                <input class="form-control" style="float: none;" type="text" id="drug-edit-disease">
                <div class="suggest" id="drug-disease-suggest">
                  {diseaseList}
                </div>
              </div>
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="insertDisease(drugEditDisease)"> <span class="glyphicon glyphicon-plus"></span> </button>
              </div>
            </div>
          </div>
          <div class="col-sm-10" id="drug-disease-suggest-list" style="height: 100px; overflow-y: scroll;"></div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Thường điều trị </label>
          <div class="col-sm-8">
            <div class="input-group form-group">
              <div class="relative">
                <input class="form-control" style="float: none;" type="text" id="drug-edit-effective">
                <div class="suggest" id="drug-effective-suggest">
                    {diseaseList2}
                </div>
              </div>
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="insertDisease(drugEditEffective)"> <span class="glyphicon glyphicon-plus"></span> </button>
              </div>
            </div>
          </div>
          <div class="col-sm-10" id="drug-effective-suggest-list" style="height: 100px; overflow-y: scroll;"></div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Ghi chú </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-edit-note"> </div>
        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="editSubmit()">
            Cập nhật thuốc
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="drug-detail" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <h4 id="drug-detail-name"></h4>
        <hr>
        <span><b>Trị bệnh: </b></span>
        <span id="drug-detail-disease"></span>
        <hr>
        <span><b>Thường trị bệnh: </b></span>
        <span id="drug-detail-effective"></span>
        <hr>
        <span><b>Hệ thống: </b></span>
        <span id="drug-detail-system"></span>
        <hr>
        <span><b>Cách dùng: </b></span>
        <br>
        <span id="drug-detail-effect"></span>
        <hr>
        <span><b>Liều lượng: </b></span>
        <br>
        <span id="drug-detail-limit"></span>
        <hr>
        <span><b>Ghi chú: </b></span>
        <span id="drug-detail-note"></span>
      </div>
    </div>
  </div>
</div>

<div id="drug-insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row form-group">
          <label class="col-sm-6"> Mã vạch </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-code"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Tên thuốc</label> <div class="col-sm-8"> <input class="form-control"type="text" id="drug-insert-name"> </div>
          <label class="col-sm-4"> Đơn vị </label> <div class="col-sm-6"> <input class="form-control"type="text" id="drug-insert-unit"> </div>
        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="insertSubmit()">
            Thêm thuốc
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
  
<!-- BEGIN: manager -->
<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#home"> Thêm thuốc </a></li>
  <li><a data-toggle="tab" href="#menu1"> Tra cứu </a></li>
</ul>
<!-- END: manager -->

<div class="tab-content">
  <!-- BEGIN: manager2 -->
  <div id="home" class="tab-pane {active}">
    <div class="row">
      <div class="col-sm-8">
        <div class="input-group form-group">
          <input class="form-control"type="text" id="drug-search" placeholder="Từ khóa lọc tên thuốc">
          <div class="input-group-btn">
            <button class="btn btn-info" onclick="search()"> <span class="glyphicon glyphicon-search"></span> </button>
          </div>
        </div>
      </div>
      <div class="col-sm-16">
        <div class="right">
          <button class="btn btn-success" onclick="insertDrug()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
      </div>
    </div>

    <br>

    <div id="content1">
      {content1}
    </div>
  </div>
  <!-- END: manager2 -->
  <div id="menu1" class="tab-pane {active2}">
    <h2> Tra cứu </h2>
    <form class="form-inline" onsubmit="filter(event)">
      <div class="input-group form-group">
        <input type="text" class="form-control" id="drug-search-name" placeholder="Tên thuốc">
        <div class="input-group-btn">
          <button class="btn" onclick="clearName()"> <span class="glyphicon glyphicon-remove"></span> </button>
        </div>
      </div>

      <div class="input-group form-group">
        <input type="text" class="form-control" id="drug-search-effect" placeholder="Công dụng">
        <div class="input-group-btn">
          <button class="btn" onclick="clearEffect()"> <span class="glyphicon glyphicon-remove"></span> </button>
        </div>
      </div>

      <div class="input-group form-group dropdown">
        <input class="form-control dropdown-toggle" id="drug-search-system" type="button" data-toggle="dropdown" placeholder="Hệ thống">
        <div class="input-group-btn">
          <button class="btn" onclick="clearSystem()"> <span class="glyphicon glyphicon-remove"></span> </button>
        </div>
        <ul class="dropdown-menu" id="drug-search-system-suggest">
          {system_list2}
        </ul>
      </div>

      <div class="input-group form-group">
        <div class="relative">
          <input type="text" class="form-control" id="drug-search-disease" style="float: none;" placeholder="Bệnh">
          <div class="suggest" id="drug-search-disease-suggest">
            {diseaseList3}
          </div>
        </div>
        <div class="input-group-btn">
          <button class="btn" onclick="clearDisease()"> <span class="glyphicon glyphicon-remove"></span> </button>
        </div>
      </div>

      <button class="btn btn-info"> <span class="glyphicon glyphicon-search"></span> </button>
    </form>
    <div id="content2">
      {content2}
    </div>
  </div>
</div>

<script>
  var drugInsert = $("#drug-insert")
  var drugEdit = $("#drug-edit")
  var drugInsertCode = $("#drug-insert-code")
  var drugInsertName = $("#drug-insert-name")
  var drugInsertUnit = $("#drug-insert-unit")

  var drugEditCode = $("#drug-edit-code")
  var drugEditName = $("#drug-edit-name")
  var drugEditUnit = $("#drug-edit-unit")
  var drugEditLimit = $("#drug-edit-limit")
  var drugEditSystem = $("#drug-edit-system")
  var drugEditEffect = $("#drug-edit-effect")
  var drugEditDisease = $("#drug-edit-disease")
  var drugEditEffective = $("#drug-edit-effective")
  var drugEditNote = $("#drug-edit-note")
  var drugSystemSuggest = $("#drug-system-suggest")
  var drugDiseaseSuggest = $("#drug-disease-suggest")
  var drugDiseaseSuggestList = $("#drug-disease-suggest-list")
  var drugEffectiveSuggest = $("#drug-effective-suggest")
  var drugEffectiveSuggestList = $("#drug-effective-suggest-list")

  var drugSearchName = $("#drug-search-name")
  var drugSearchEffect = $("#drug-search-effect")
  var drugSearchSystem = $("#drug-search-system")
  var drugSearchSystemSuggest = $("#drug-search-system-suggest")
  var drugSearchDisease = $("#drug-search-disease")
  var drugSearchDiseaseSuggest = $("#drug-search-disease-suggest")

  var drugDetail = $("#drug-detail")
  var drugDetailName = $("#drug-detail-name")
  var drugDetailEffect = $("#drug-detail-effect")
  var drugDetailEffective = $("#drug-detail-effective")
  var drugDetailNote = $("#drug-detail-note")
  var drugDetailLimit = $("#drug-detail-limit")
  var drugDetailDisease = $("#drug-detail-disease")
  var drugDetailSystem = $("#drug-detail-system")

  var drugRemove = $("#drug-remove")
  var drugRemoveName = $("#drug-remove-name")

  var drugSearch = $("#drug-search")

  var content1 = $("#content1")
  var content2 = $("#content2")

  var sa = $(".sa")
  var s2 = $(".s2")
  var g_system = 0
  var g_id = 0

  var disease = {}
  var effective = {}
  var g_disease = -1
  var drugData = JSON.parse('{drug}')
  var systemData = JSON.parse('{system}')
  var diseaseData = JSON.parse('{disease}')

  var diseaseTimeout
  var effectiveTimeout
  var searchTimeout
  var searchData = {
    system: 0,
    disease: 0
  }

  function installSuggest(input, suggest, callname, event) {
    var timeout
    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var value = input.val()
        suggest.html(event(value, callname))
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

  filterDisease = (keyword, callname) => {
    html = ''
    for (const key in diseaseData) {
      if (diseaseData.hasOwnProperty(key)) {
        const name = diseaseData[key];
        if (name.toLowerCase().search(keyword) >= 0) {
          html += '<div class="suggest_item" onclick="'+callname+'(' + key + ')">' + name + '</div>'
        }
      }
    }
    return html
  }

  installSuggest(drugSearchDisease, drugSearchDiseaseSuggest, 'putDisease', filterDisease)

  sa.click((e) => {
    var target = e.currentTarget
    var id = (target.children[0].getAttribute('id')).replace('sa', '')
    var check = $('#' + id)
    check.prop("checked", !check.prop("checked"));
    var system = []
    for (const key in sa) {
      if (sa.hasOwnProperty(key)) {
        const element = sa[key];
        var text = element.innerText
        if (text && element.children[0]['checked']) {
          system.push(text)
        }
      }
    }
    drugEditSystem.val(system.join(', '))
  })

  drugEditSystem.click(() => {
    if (g_system = !g_system) {
      drugSystemSuggest.show()
    }
    else {
      drugSystemSuggest.hide()
    }
  })

  drugEditDisease.keyup((e) => {
    clearTimeout(diseaseTimeout)
    diseaseTimeout = setTimeout(() => {
      var keyword = drugEditDisease.val().toLowerCase()
      html = ''
      for (const key in diseaseData) {
        if (diseaseData.hasOwnProperty(key)) {
          const name = diseaseData[key];
          if (name.toLowerCase().search(keyword) >= 0) {
            html += '<div class="suggest_item" onclick="selectDisease(' + key + ')">' + name + '</div>'
          }
        }
      }
      drugDiseaseSuggest.html(html)
    }, 200);
  })

  drugEditDisease.focus(() => {
    drugDiseaseSuggest.show()
  })

  drugEditDisease.blur(() => {
    setTimeout(() => {
      drugDiseaseSuggest.hide()
    }, 100);
  })

  drugEditEffective.keyup((e) => {
    clearTimeout(effectiveTimeout)
    effectiveTimeout = setTimeout(() => {
      var keyword = drugEditEffective.val().toLowerCase()
      html = ''
      for (const key in diseaseData) {
        if (diseaseData.hasOwnProperty(key)) {
          const name = diseaseData[key];
          if (name.toLowerCase().search(keyword) >= 0) {
            html += '<div class="suggest_item" onclick="selectEffective(' + key + ')">' + name + '</div>'
          }
        }
      }
      drugEffectiveSuggest.html(html)
    }, 200);
  })

  drugEditEffective.focus(() => {
    drugEffectiveSuggest.show()
  })

  drugEditEffective.blur(() => {
    setTimeout(() => {
      drugEffectiveSuggest.hide()
    }, 100);
  })


  drugSearch.keyup(() => {
    clearTimeout(searchTimeout)
    searchTimeout = setTimeout(() => {
      search()
    }, 200);
  })

  function putDisease(index) {
    searchData['disease'] = index
    drugSearchDisease.val(diseaseData[index])
  }

  function putSystem(index) {
    searchData['system'] = index
    drugSearchSystem.val(systemData[index]['name'])
  }

  function clearName() {
    drugSearchName.val('')
  }

  function clearEffect() {
    drugSearchEffect.val('')
  }

  function clearSystem() {
    searchData['system'] = 0
    drugSearchSystem.val('')
  }

  function clearDisease() {
    searchData['disease'] = 0
    drugSearchDisease.val('')
  }

  function insertDisease(target) {
    freeze()
    $.post(
      strHref,
      {action: 'insert-disease', name: target.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          diseaseData = data['disease']
        }, () => {})
      }
    )
  }

  function selectDisease(id) {
    disease[id] = 1
    parseDisease(disease, drugDiseaseSuggestList, 'removeDisease')
  }

  function removeDisease(id) {
    delete disease[id]
    parseDisease(disease, drugDiseaseSuggestList, 'removeDisease')
  }

  function selectEffective(id) {
    effective[id] = 1
    parseDisease(effective, drugEffectiveSuggestList, 'removeEffective')
  }

  function removeEffective(id) {
    delete effective[id]
    parseDisease(effective, drugEffectiveSuggestList, 'removeEffective')
  }

  function parseDisease(list, target, param) {
    var html = ''
    for (const key in list) {
      if (list.hasOwnProperty(key) && diseaseData[key]) {
        const name = diseaseData[key];
        
        html += `
          <div style="overflow: auto;"> ` + name + `<button class="btn btn-danger right" onclick="`+ param +`(` + key + `)"> <span class="glyphicon glyphicon-remove"> </div>
        `
      }
    }
    target.html(html)
  }

  function edit(index) {
    g_id = drugData[index]['id']
    
    drugEditCode.val(drugData[index]['code'])
    drugEditName.val(drugData[index]['name'])
    drugEditUnit.val(drugData[index]['unit'])
    drugEditLimit.val(drugData[index]['limits'].replace(/<br>/g, '\n'))
    drugEditEffect.val(drugData[index]['effect'].replace(/<br>/g, '\n'))

    system = drugData[index]['system']
    disease = {}
    diseaseT = drugData[index]['disease']
    diseaseT.forEach(item => {
      disease[item] = 1;
    })
    effective = {}
    effectiveT = drugData[index]['effective']
    effectiveT.forEach(item => {
      effective[item] = 1;
    })
    parseDisease(effective, drugEffectiveSuggestList, 'removeEffective')
    parseDisease(disease, drugDiseaseSuggestList, 'removeDisease')

    var text = []
    $(".s").each((index, item) => {
      item.checked = false
    })

    system.forEach(systemItem => {
      if (Number(systemItem)) {
        text.push(systemData[systemItem]['name'])
        $("#s" + systemItem).prop('checked', true)
      }
    })
    drugEditSystem.val(text.join(', '))

    drugEditEffective.val()
    drugEditDisease.val()
    drugEditNote.val(drugData[index]['note'])
    drugEdit.modal('show')
  }

  function search() {
    var html = ''
    var keyword = drugSearch.val().toLowerCase()
    for (const key in drugData) {
      if (drugData.hasOwnProperty(key)) {
        const drug = drugData[key];
        if (drug['name'].toLowerCase().search(keyword) >= 0) {
          html += `
            <tr>
              <td>
                ` + drug['name'] + `(` + drug['unit'] + `)
                <button class="btn btn-info right" onclick="edit(` + key + `)"><span class="glyphicon glyphicon-edit"></span>
                </button>
              </td>
            </tr>
          `
        }
      }
    }
    html = `<table class="table">` + html + `</table>`
    
    content1.html(html)
  }

  function filter(e) {
    e.preventDefault()
    freeze()
    var name = drugSearchName.val().toLowerCase()
    var effect = drugSearchEffect.val()
    var system = searchData['system'].toString()
    var disease = searchData['disease'].toString()

    var list = {}
    
    for (const key in drugData) {
      if (drugData.hasOwnProperty(key)) {
        const drug = drugData[key];
        list[key] = 1
        if (name && drug['name'].toLowerCase().search(name) < 0) {
          delete list[key]
        }
        else if (effect && drug['effect'].toLowerCase().search(effect) < 0) {
          delete list[key]
        }
        else if (system > 0 && drug['system'].indexOf(system) < 0) {
          delete list[key]
        }
        else if (disease > 0 && drug['disease'].indexOf(disease) < 0) {
          delete list[key]
        }
      }
    }

    content2.html(parseByDisease(list))
    // if (disease > 0) {
    // }
    // else {
    //   content2.html(parseByName(list))
    // }
    defreeze()
  }

  function parseByDisease(list) {
    var html = ''
    var disease = {}
    for (const key in list) {
      if (list.hasOwnProperty(key)) {
        const index = list[key];
        drugData[key]['disease'].forEach(diseaseId => {
          if (!disease[diseaseId]) {
            disease[diseaseId] = []
          } 
          disease[diseaseId].push('<span onclick="showDrug('+key+')">' + drugData[key]['name'] + '</span>')
        });
      }
    }    

    for (const diseaseId in disease) {
      if (disease.hasOwnProperty(diseaseId)) {
        const drugList = disease[diseaseId];
        html += `
          <div class="row">
            <div class="col-sm-12">
              <b> Tên bệnh: </b> `+ diseaseData[diseaseId] +`
            </div>
            <div class="col-sm-12">
              <b> Thuốc: </b> `+ drugList.join(', ') +`
            </div>
          </div>
          <hr>
        `
      }
    }
    return html 
  }

  function showDrug(id) {
    drugDetailName.text(drugData[id]['name'])
    drugDetailEffect.html(drugData[id]['effect'])
    drugDetailDisease.text(paintDisease(drugData[id]['disease']))
    drugDetailEffective.text(paintDisease(drugData[id]['effective']))
    drugDetailLimit.html(drugData[id]['limits'])
    drugDetailNote.text(drugData[id]['note'])
    drugDetailSystem.text(paintSystem(drugData[id]['system']))
    drugDetail.modal('show')
  }

  function paintDisease(list) {
    var temp = []
    list.forEach(item => {
      if (item) {
        temp.push(diseaseData[item])
      }
    })
    return temp.join(', ')
  }

  function paintSystem(list) {
    var temp = []
    list.forEach(item => {
      if (item) {
        temp.push(systemData[item]['name'])
      }
    })
    return temp.join(', ')
  }

  function remove(id) {
    g_id = id
    drugRemoveName.val(drugData[id]['name'])
    drugRemove.modal('show')
  }

  function removeSubmit() {
    freeze()
    $.post(
      strHref,
      {action: 'remove', id: drugData[g_id]['id'], keyword: drugSearch.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content1.html(data['html'])
          drugRemove.modal('hide')
          drugData = data['drug']
        }, () => {})
      }
    )
  }

  function gatherSystem() {
    var system = []
    for (const key in sa) {
      if (sa.hasOwnProperty(key)) {
        const element = sa[key];
        var text = element.innerText
        if (text && (element.children[0].getAttribute('tag') == 1) && element.children[0]['checked']) {
          var id = (element.children[0].getAttribute('id')).replace('s', '')
          system.push(id)
        }
      }
    }
    return system;
  }

  function checkDisease() {
    var temp = {}
    for (const key in disease) {
      if (disease.hasOwnProperty(key)) {
        const value = disease[key];
        
        if (value && key) {
          temp[key] = value
        }
      }
    }
    return temp
  }

  function insertDrug() {
    drugInsert.modal('show')
  }

  function insertSubmit() {
    freeze()
    var system = gatherSystem()
    $.post(
      strHref,
      {action: 'insert', code: drugInsertCode.val(), name: drugInsertName.val(), unit: drugInsertUnit.val(), keyword: drugSearch.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content1.html(data['html'])
          drugInsert.modal('hide')
          drugData = data['drug']
        }, () => {})
      }
    )
  }

  function editSubmit() {
    freeze()
    var system = gatherSystem()
    var disease = checkDisease()

    $.post(
      strHref,
      {action: 'edit', id: g_id, code: drugEditCode.val(), name: drugEditName.val(), limit: drugEditLimit.val(), unit: drugEditUnit.val(), system: system, effect: drugEditEffect.val(), disease: disease, effective: effective, note: drugEditNote.val(), keyword: drugSearch.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content1.html(data['html'])
          drugEdit.modal('hide')
          drugData = data['drug']
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
