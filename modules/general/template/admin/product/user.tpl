<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<link rel="stylesheet" href="/modules/core/css/style.css">

<div id="msgshow"></div>

{modal}

<ul class="nav nav-tabs">
  <li> <a href="{link}"> Quản lý mặt hàng </a> </li>
  <li> <a href="{link}&sub=tag"> Quản lý tag </a> </li>
  <li class="active"> <a href="#"> Quản lý người dùng </a> </li>
</ul>

<div class="form-group row-x">
  <div class="col-6">
    <div class="relative">
      <input type="text" class="form-control" id="insert-user" placeholder="Nhập chọn người dùng">
      <div class="suggest" id="insert-user-suggest"></div>
    </div>
  </div>
  <div class="col-6"></div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
  var global = {
    tag: []
  }

  $(document).ready(() => {
    vremind.install('#insert-user', '#insert-user-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', {action: 'get-user', keyword: input}).then(data => {
          resolve(data['html'])
        })
      })
    }, 300, 300)
  })

  function insertUser(id) {
    vhttp.checkelse('', {action: 'insert', id: id}).then(data => {
      $('#content').html(data['html'])
    })
  }

  function changePermit(id, type) {
    vhttp.checkelse('', {action: 'change-permit', id: id, type: type}).then(data => {
      $('#content').html(data['html'])
      $('#insert-user-suggest').html(data['html2'])
    })
  }

  function getTagPermit(id) {
    vhttp.checkelse('', {action: 'get-tag-permit', id: id}).then(data => {
      global['tag'] = data['tag']
      $('#tag-modal').modal('show')
    })
  }

  function parseTag() {
    html = ''
    global['tag'].forEach((item, index) => {
      html += `
          <button class="btn btn-info btn-xs" onclick="removeTag(`+ index + `)">
            `+ item + `
          </button>`
    });
    $("#product-tag-list").html(html)
  }

  function removeTag(id) {
    global['tag'] = global['tag'].filter((item, index) => {
      return index !== id
    })
    parseTag()
  }
</script>
<!-- END: main -->