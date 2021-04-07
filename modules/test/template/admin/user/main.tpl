<!-- BEGIN: main -->
<div class="form-group relative" style="width: 50%;">
  <input type="text" class="form-control" id="user-name" placeholder="Thêm nhân viên">
  <div class="suggest" id="user-name-suggest"></div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-7.js"></script>
<script>

$(document).ready(() => {
  vremind.install('#user-name', '#user-name-suggest', input => {
    return new Promise(resolve => {
      vhttp.checkelse('', {action: 'get', keyword: input}).then(data => {
        resolve(data['html'])
      })
    })
  }, 300, 300)
})

function insertUser(id) {
  vhttp.checkelse('', {action: 'insert', id: id, keyword: $('#user-name').val()}).then(data => {
    $('#content').html(data['html'])
    $('#user-name-suggest').html(data['html2'])
  })
}

function removeUser(id) {
  vhttp.checkelse('', {action: 'remove', id: id, keyword: $('#user-name').val()}).then(data => {
    $('#content').html(data['html'])
    $('#user-name-suggest').html(data['html2'])
  })
}

function change(id, type, value) {
  vhttp.checkelse('', {action: 'change', id: id, type: type, value: value}).then(data => {
    $('#content').html(data['html'])
  })
}
</script>
<!-- END: main -->