<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">

<div id="msgshow"></div>

{modal}

<div class="form-group rows">
  <div class="col-4"> </div>
  <div class="col-4 relative">
    <!-- BEGIN: child -->
    <input type="text" class="form-control" id="keyword">
    <div class="suggest" id="keyword-suggest"></div>
    <!-- END: child -->
  </div>
  <div class="col-4 input-group">
    <input type="text" class="form-control" id="title" placeholder="Tiêu đề menu">
    <div class="input-group-btn">
      <button class="btn btn-success" onclick="{func}">
        Thêm menu
      </button>
    </div>
  </div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vremind-5.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/together/src/script.js"></script>
<script>
  global = {
    id: Number('{id}'),
    data: JSON.parse('{data}'),
    name: ''
  }

  $(document).ready(() => {
    if (global['id']) {
      vremind.install('#keyword', '#keyword-suggest', (input) => {
        return new Promise((resolve) => {
          input = convert(input)
          html = ''
          global['data'].forEach(item => {
            str = convert(item)

            if (str.search(input) >= 0) {
              html += `
                <div class="suggest-item" onclick="selectItem('`+ item + `')">
                  `+ item + `
                </div>
              `
            }
          })
          resolve(html)
        })
      }, 300, 300)
    }
  })

  function insertRoot() {
    if (!(title = $("#title").val()).length) alert_msg('Điền tên menu trước khi thêm')
    else {
      vhttp.checkelse('', { action: 'insert-root', title: $("#title").val() }).then(data => {
        $("#title").val('')
        $("#content").html(data['html'])
      })
    }
  }

  function remove(id) {
    vhttp.checkelse('', { action: 'remove', rid: id }).then(data => {
      global['data'] = JSON.parse(data['data'])
      $("#content").html(data['html'])
    })
  }

  function insertChild(id) {
    if (global['data'].indexOf(global['name']) < 0) alert_msg('Chưa chọn menu con')
    else if (!(title = $("#title").val()).length) alert_msg('Điền tên menu trước khi thêm')
    else {
      vhttp.checkelse('', { action: 'insert-child', title: $("#title").val(), name: global['name'] }).then(data => {
        global['name'] = ''
        global['data'] = JSON.parse(data['data'])
        $("#keyword").val('')
        $("#title").val('')
        $("#content").html(data['html'])
      })
    }
  }

  function selectItem(name) {
    global['name'] = name
    $("#keyword").val(name)
  }
</script>
<!-- END: main -->