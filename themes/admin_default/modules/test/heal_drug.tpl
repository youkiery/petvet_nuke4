<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="drug-edit" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-body">
          <div class="row form-group">
            <label class="col-sm-6"> Mã vạch </label>
            <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-code"> </div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Tên thuốc</label>
            <div class="col-sm-8"> <input class="form-control"type="text" id="drug-insert-name"> </div>
            <label class="col-sm-6"> Đơn vị </label>
            <div class="col-sm-4"> <input class="form-control"type="text" id="drug-insert-unit"> </div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Hệ thống tác động </label>
            <div class="col-sm-18 relative">
              <input type="text" class="form-control" id="drug-insert-system" autocomplete="off">
              <div class="suggest" id="drug-system-suggest">
                {system_list}
              </div>
            </div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Liều dùng </label>
            <div class="col-sm-18"> <textarea class="form-control"type="text" id="drug-insert-limit"></textarea> </div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Công dụng </label>
            <div class="col-sm-18"> <textarea class="form-control"type="text" id="drug-insert-effect"></textarea> </div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Điều trị bệnh </label>
            <div class="col-sm-8">
              <div class="input-group">
                <div class="relative">
                  <input class="form-control" style="float: none;" type="text" id="drug-insert-disease">
                  <div class="suggest" id="drug-disease-suggest">
                    {diseaseList}
                  </div>
                </div>
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="insertDisease(drugInsertDisease)"> <span class="glyphicon glyphicon-plus"></span> </button>
                </div>
              </div>
            </div>
            <div class="col-sm-10" id="drug-disease-suggest-list" style="height: 100px; overflow-y: scroll;"></div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Thường điều trị </label>
            <div class="col-sm-8">
              <div class="input-group">
                <div class="relative">
                  <input class="form-control" style="float: none;" type="text" id="drug-insert-effective">
                  <div class="suggest" id="drug-effective-suggest">
                      {diseaseList2}
                  </div>
                </div>
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="insertDisease(drugInsertEffective)"> <span class="glyphicon glyphicon-plus"></span> </button>
                </div>
              </div>
            </div>
            <div class="col-sm-10" id="drug-effective-suggest-list" style="height: 100px; overflow-y: scroll;"></div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Ghi chú </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-note"> </div>
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

<div id="drug-insert" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
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
  
<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#home"> Thêm thuốc </a></li>
  <li><a data-toggle="tab" href="#menu1"> Tra cứu </a></li>
</ul>

<div class="tab-content">
  <div id="home" class="tab-pane active">
    <div class="row">
      <div class="col-sm-8">
        <div class="input-group">
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
  <div id="menu1" class="tab-pane">
    <h2> Tra cứu </h2>
    <div class="form-inline">
        <input type="text" class="form-control" id="drug-search-name" placeholder="Tên thuốc">
        <input type="text" class="form-control" id="drug-search-effect" placeholder="Công dụng">
        <span class="relative">
          <input type="text" class="form-control" id="drug-search-system" placeholder="Hệ thống">
          <div class="suggest" id="drug-search-system-suggest">
            {system_list}
          </div>
        </span>
        <div class="form-group relative">
          <input type="text" class="form-control" id="drug-search-disease" placeholder="Bệnh">
          <div class="suggest" id="drug-search-disease-suggest">
            {diseaseList3}
          </div>
        </div>
        <button class="btn btn-info" onclick="filter()"> <span class="glyphicon glyphicon-search"></span> </button>
    </div>
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
  var drugInsertLimit = $("#drug-insert-limit")
  var drugInsertUnit = $("#drug-insert-unit")
  var drugInsertSystem = $("#drug-insert-system")
  var drugSystemSuggest = $("#drug-system-suggest")
  var drugInsertEffect = $("#drug-insert-effect")
  var drugInsertDisease = $("#drug-insert-disease")
  var drugDiseaseSuggest = $("#drug-disease-suggest")
  var drugDiseaseSuggestList = $("#drug-disease-suggest-list")
  var drugEffectiveSuggest = $("#drug-effective-suggest")
  var drugEffectiveSuggestList = $("#drug-effective-suggest-list")
  var drugInsertEffective = $("#drug-insert-effective")
  var drugInsertNote = $("#drug-insert-note")

  var drugSearchName = $("#drug-search-name")
  var drugSearchEffect = $("#drug-search-effect")
  var drugSearchSystem = $("#drug-search-system")
  var drugSearchSystemSuggest = $("#drug-search-system-suggest")
  var drugSearchDisease = $("#drug-search-disease")
  var drugSearchDiseaseSuggest = $("#drug-search-disease-suggest")

  var drugSearch = $("#drug-search")

  var content1 = $("#content1")
  var content2 = $("#content2")

  var sa = $(".sa")
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
    disease: -1
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
    drugInsertSystem.val(system.join(', '))
  })

  drugInsertSystem.click(() => {
    if (g_system = !g_system) {
      drugSystemSuggest.show()
    }
    else {
      drugSystemSuggest.hide()
    }
  })

  drugInsertDisease.keyup((e) => {
    clearTimeout(diseaseTimeout)
    diseaseTimeout = setTimeout(() => {
      var keyword = drugInsertDisease.val().toLowerCase()
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

  drugInsertDisease.focus(() => {
    drugDiseaseSuggest.show()
  })

  drugInsertDisease.blur(() => {
    setTimeout(() => {
      drugDiseaseSuggest.hide()
    }, 100);
  })

  drugInsertEffective.keyup((e) => {
    clearTimeout(effectiveTimeout)
    effectiveTimeout = setTimeout(() => {
      var keyword = drugInsertEffective.val().toLowerCase()
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

  drugInsertEffective.focus(() => {
    drugEffectiveSuggest.show()
  })

  drugInsertEffective.blur(() => {
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
    
    drugInsertCode.val(drugData[index]['code'])
    drugInsertName.val(drugData[index]['name'])
    drugInsertUnit.val(drugData[index]['unit'])
    drugInsertLimit.val(drugData[index]['limits'])
    drugInsertEffect.val(drugData[index]['effect'])

    system = drugData[index]['system'].split(',')
    disease = {}
    diseaseT = drugData[index]['disease'].split(',')
    diseaseT.forEach(item => {
      disease[item] = 1;
    })
    effective = {}
    effectiveT = drugData[index]['effective'].split(',')
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
    drugInsertSystem.val(text.join(', '))

    drugInsertEffective.val()
    drugInsertDisease.val()
    drugInsertNote.val(drugData[index]['note'])
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

  function filter() {
    freeze()
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
    $.post(
      strHref,
      {action: 'edit', id: g_id, code: drugInsertCode.val(), name: drugInsertName.val(), limit: drugInsertLimit.val(), unit: drugInsertUnit.val(), system: system, effect: drugInsertEffect.val(), disease: disease, effective: effective, note: drugInsertNote.val(), keyword: drugSearch.val()},
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
