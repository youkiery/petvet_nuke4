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

  .col-6 {width: calc(50% - 10px);}

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
    display:none;
    position: absolute;
    overflow-y:scroll;
    max-height: 300px;
    width: -webkit-fill-available;
    width: 100%;
  }
  .suggest div:hover {
    background: #afa;
    cursor: pointer;
  }
</style>

{modal}

<div class="form-group">
  <form method="get">
    <!-- BEGIN: promo -->
    <input type="hidden" name="type" value="promo">
    <!-- END: promo -->
    <div class="rows">
      <div class="form-group col-6">
        <label> Họ tên </label>
        <input type="text" class="form-control" name="name" id="filter-name" value="{name}">
      </div>
      <div class="form-group col-6">
        <label> Ghi chú </label>
        <input type="text" class="form-control" name="note" id="filter-note" value="{note}">
      </div>
    </div>

    <button class="btn btn-info btn-block" onclick="filter()">
      Lọc danh sách
    </button>
  </form>
</div>

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
<script>
  var global = {
    id: 0,
    formal: '{formal}'.split('|'),
    employ: '{employ}'.split('|'),
  }

  $(document).ready(() => {
    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });

    vremind.install('#salary-up-name', '#salary-up-name-suggest', (input) => {
      return new Promise(resolve => {
        html = ''
        input = input.toLowerCase()

        global.employ.forEach(item => {
          if (item.search(input) >= 0) html += `
            <div class="suggest-item" onclick="select('salary-up-name', '`+ item +`')">
              `+ item +`
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
            <div class="suggest-item" onclick="select('salary-up-formal', '`+ item +`')">
              `+ item +`
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
            <div class="suggest-item" onclick="select('promo-up-name', '`+ item +`')">
              `+ item +`
            </div>`
        });
        resolve(html)
      })
    }, 500, 300)
  })

  function select(selector, name) {
    console.log(name);
    console.log($('#' + selector));
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
    $('#salary-up-modal').modal('show')
  }

  function salaryUp(e) {
    e.preventDefault()
    vhttp.checkelse('', {
      action: 'salary-up',
      data: {
        name: $('#salary-up-name').val(),
        time: $('#salary-up-time').val(),
        next_time: $('#salary-up-next-time').val(),
        formal: $('#salary-up-formal').val(),
        file: $('#salary-up-file').val(),
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
    return 0
  }
  
  function promoUpModal() {
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
</script>
<!-- END: main -->