<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

{member_modal}
{remove_member_modal}
{edit_member_modal}

<div id="msgshow"></div>
<div class="form-group">
  <button class="btn btn-info" onclick="insertMember()">
    Thêm thành viên
  </button>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    id: 0,
    member: JSON.parse('{member}')
  }

  $(document).ready(() => {
    memberFilter()
  })

  function insertDepart() {
    name = $("#depart-name").val()
    if (!name.length) {
      alert_msg('Nhập tên phòng ban trước khi thêm')
    }
    else {
      $.post(
        '',
        { action: 'insert-depart', name: name },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#depart-name").val('')
            $("#depart-content-tail").before(`
            <div class="checkbox">
              <label> <input type="checkbox" name="member-depart" index="`+ data['inserted']['id'] +`" id="member-depart-`+ data['inserted']['id'] +`"> `+ data['inserted']['name'] +` </label>
            </div>`)
          }, () => {})
        }
      )
    }
  }

  function editMember(id) {
    $.post(
      '',
      { action: 'get-member', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          global['id'] = id
          $("[name=member-depart]").each((index, item) => {
            item.checked = false
          })
          data['data']['depart'].forEach(departid => {
            $("#member-depart-" + departid)[0].checked = true
          });
          $("#member-device-" + data['data']['device'])[0].checked = true
          $("#member-material-" + data['data']['material'])[0].checked = true
          $("#edit-member-modal").modal('show')
        }, () => {})
      }
    )
  }

  function checkAllowance() {
    depart = []
    $("[name=member-depart]").each((index, item) => {
      if (item.checked) depart.push(item.getAttribute('index'))
    })
    return {
      depart: depart,
      device: $("[name=device]:checked").val(),
      material: $("[name=material]:checked").val()
    }
  }

  function editMemberSubmit() {
    $.post(
      '',
      { action: 'edit-member', data: checkAllowance(), id: global['id'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $("#edit-member-modal").modal('hide')
        }, () => {})
      }
    )
  }

  function removeMember(id) {
    global['id'] = id
    $("#remove-member-modal").modal('show')
  }

  function removeMemberSubmit() {
    $.post(
      '',
      { action: 'remove-member', id: global['id'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $("#remove-member-modal").modal('hide')
        }, () => {})
      }
    )
  }

  function insertMember() {
    $("#member-modal").modal('show')
  }

  function memberFilter() {
    $("#member-keyword").keyup((e) => {
      keyword = convert(e.currentTarget.value)

      html = ''
      global['member'].forEach(item => {
        if (item['title'].search(keyword) >= 0) {
          html += `
            <div style="overflow: auto;">
              <span> `+ item['name'] +` </span>
              <button class="btn btn-info" style="float: right;" onclick="selectMember(`+ item['id'] +`)">
                Thêm vào danh sách
              </button>
            </div><hr>`
        }
      })
      
      $("#member-content").html(html)
    })    
  }

  function selectMember(id) {
    $.post(
      '',
      { action: 'select-member', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
