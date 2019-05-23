<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
  <div class="row">
    <div class="col-sm-12">
      <div class="input-group">
        <input type="text" class="form-control" id="form-keyword" placeholder="Từ khóa" autocomplete="off">
        <div class="input-group-btn">
          <button class="btn btn-info" onclick="search()"> <span class="glyphicon glyphicon-search"></span> </button>
        </div>
      </div>
    </div>
    <div class="relative col-sm-12">
      <input type="text" class="form-control" id="form-employ" placeholder="Thêm nhân viên" autocomplete="off">
      <div class="suggest" id="form-employ-suggest"></div>
    </div>
  </div>

<div id="content">
  {content}
</div>

<script>
  var formKeyword = $("#form-keyword")
  var formEmploy = $("#form-employ")
  var formEmploySuggest = $("#form-employ-suggest")
  var content = $("#content")
  var timeout

  formEmploy.keyup(() => {
    clearTimeout(timeout)
    setTimeout(() => {
      $.post(
        strHref,
        {action: 'filterEmploy', key: formEmploy.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            formEmploySuggest.html(data['html'])
          }, () => { defreeze() })
        }
      )
    }, 200);
  })
  
  formEmploy.focus(() => {
    formEmploySuggest.show()
  })
  formEmploy.blur(() => {
    setTimeout(() => {
      formEmploySuggest.hide()
    }, 200);
  })

  function search(userid) {
    freeze()
    $.post(
      strHref,
      {action: 'search', key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { defreeze() })
      }
    )
  }

  function addEmploy(userid) {
    freeze()
    $.post(
      strHref,
      {action: 'addEmploy', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { defreeze() })
      }
    )
  }

  function removeUser(userid) {
    freeze()
    $.post(
      strHref,
      {action: 'removeUser', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { defreeze() })
      }
    )
  }

  function upUser(userid) {
    freeze()
    $.post(
      strHref,
      {action: 'upUser', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { defreeze() })
      }
    )
  }

  function downUser(userid) {
    freeze()
    $.post(
      strHref,
      {action: 'downUser', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => { defreeze() })
      }
    )
  }
</script>
<!-- END: main -->