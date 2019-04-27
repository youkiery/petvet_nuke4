<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="drug-insert" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row form-group">
          <label class="col-sm-6"> Mã vạch </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-code"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Tên thuốc </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-name"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Liều dùng </label> <div class="col-sm-8"> <input class="form-control"type="text" id="drug-insert-limit"> </div>
          <label class="col-sm-4"> Đơn vị </label> <div class="col-sm-6"> <input class="form-control"type="text" id="drug-insert-unit"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Hệ thống tác động </label> <div class="col-sm-18 relative">
            <input type="text" class="form-control" id="drug-insert-system" autocomplete="off">
            <div class="suggest" id="drug-system-suggest">
              <!-- BEGIN: system -->
              <div class="item-suggest sa" id="sa{systemid}"> {system} <input type="checkbox" class="right s" id="s{systemid}"></div>
              <!-- END: system -->
            </div>
          </div>
          
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Công dụng </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-effect"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Điều trị bệnh </label>
          <div class="col-sm-10 relative">
            <input class="form-control"type="text" id="drug-insert-disease">
            <div class="suggest" id="drug-disease-suggest"></div>
              <!-- <div class="input-group">
              <input class="form-control"type="text" id="drug-insert-disease">
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="addDrug()"> <span class="glyphicon glyphicon-plus"></span> </button>
              </div>
            </div> -->
          </div>
          <div class="col-sm-8" id="drug-disease-suggest-list" style="height: 100px; overflow-y: scroll;"></div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Thường điều trị </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-effective"> </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Ghi chú </label> <div class="col-sm-18"> <input class="form-control"type="text" id="drug-insert-note"> </div>
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
    <div id="content2">
      {content2}
    </div>
  </div>
</div>

<script>
  var drugInsert = $("#drug-insert")
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
  var drugInsertEffective = $("#drug-insert-effective")
  var drugInsertNote = $("#drug-insert-note")

  var drugSearch = $("#drug-search")

  var content1 = $("#content1")
  var content2 = $("#content2")

  var sa = $(".sa")
  var g_system = 0

  var disease = {}
  var drugData = JSON.parse('{drug}')
  var systemData = JSON.parse('{system}')
  var diseaseData = JSON.parse('{disease}')

  var diseaseTimeout
  var searchTimeout

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
      html = ''
      diseaseData.forEach((index, disease) => {
        html += '<div class="item_suggest"></div>'
      });
      drugDiseaseSuggest.html(html)
    }, 200);
  })

  drugSearch.keyup(() => {
    clearTimeout(searchTimeout)
    searchTimeout = setTimeout(() => {
      search()
    }, 200);
  })

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
              </td>
              <td>
                <button class="btn btn-info" onclick="edit(` + drug['id'] + `)"><span class="glyphicon glyphicon-edit"></span>
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

  function insert() {
    drugInsert.modal('show')
  }

  function insertSubmit() {
    freeze()
    var system = gatherSystem()
    $.post(
      strHref,
      {action: 'insert', code: drugInsertCode.val(), name: drugInsertName.val(), limit: drugInsertLimit.val(), unit: drugInsertUnit.val(), system: system, effect: drugInsertEffect.val(), disease: drugInsertDisease.val(), effective: drugInsertEffective.val(), note: drugInsertNote.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content1.html(data['html'])
        })
      }
    )
  }
</script>
<!-- END: main -->
