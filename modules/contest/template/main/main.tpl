<!-- BEGIN: main -->
<style>
  .form-group {
    clear: both;
  }
</style>
<div class="container" style="margin-top: 20px;">
  <div id="msgshow"></div>
  <div style="float: right;">
    {FILE "heading.tpl"}
    {confirm_list}
  </div>
  <div style="clear: right;"></div>
  <a href="/">
    <img src="/themes/default/images/banner.png" style="float: left; width: 200px;">
  </a>
  <form style="width: 60%; float: right;">
    <label class="input-group">
      <input type="hidden" name="nv" value="biograph">
      <input type="hidden" name="op" value="list">
      <input type="text" class="form-control" name="keyword" value="{keyword}" id="keyword" placeholder="Nhập tên hoặc mã số">
      <div class="input-group-btn">
        <button class="btn btn-info"> Tìm kiếm </button>
      </div>
    </label>
  </form>
  <div style="clear: both;"></div>

  <div id="content">
    <div style="max-width: 500px; margin: auto; border: 1px solid lightgray; border-radius: 10px; padding: 60px 10px 60px 10px;">
      <div class="form-group">
        <label class="label-control col-4"> Tên người/đơn vị đăng ký </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-name">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Tên thú cưng </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-petname">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Giống loài </label>
        <div class="col-8 relative">
          <input type="text" class="form-control" id="signup-species">
          <div class="suggest" id="signup-species-suggest"></div>
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Địa chỉ </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-address">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Số điện thoại </label>
        <div class="col-8">
          <input type="text" class="form-control" id="signup-mobile">
        </div>
      </div>
      <div class="form-group">
        <label class="label-control col-4"> Hạng mục đăng ký </label>
        <div class="col-8 checkbox">
          <!-- BEGIN: test -->
          <label style="margin-right: 10px;"> <input type="checkbox" name="test" index="{id}"> {name} </label>
          <!-- END: test -->
        </div>
      </div>
      <div class="text-center">
        <button class="btn btn-success" onclick="signupPresubmit()">
          Đăng ký
        </button>
        <br>
        <br>
        <button class="btn btn-info" onclick="confirmList()">
          Danh sách những người đã đăng ký
        </button>

      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal-presignup" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div type="button" class="close" data-dismiss="modal"> &times; </div> <br>
        
        <div class="text-center">
          <p> Xác nhận thông tin đăng ký </p>
          <p> Sau khi xác nhận, thông tin dưới đây sẽ không thể thay đổi </p>
          <button class="btn btn-info" onclick="signupSubmit()">
            Xác nhận đăng ký
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  global = {
    'species': JSON.parse('{species}'),
    'page': 1
  }

  $(document).ready(() => {
    installSuggest('signup', 'species')
  })

  function signupPresubmit() {
    data = checkSignupData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $("#modal-presignup").modal('show')
    }
  }

  function checkSignupData() {
    test = []
    name = $("#signup-name").val()
    petname = $("#signup-petname").val()
    address = $("#signup-address").val()
    mobile = $("#signup-mobile").val()
    species = $("#signup-species").val()
    if (!name.length) return 'Tên người/đơn vị không được để trống'
    if (!petname.length) return 'Tên thú cưng không được để trống'
    if (!species.length) return 'Giống loài không được để trống'
    if (!address.length) return 'Địa chỉ không được để trống'
    if (!mobile.length) return 'Số điện thoại không được để trống'
    $("[name=test]").each((index, item) => {
      indexkey = item.getAttribute('index')
      if (item.checked) test.push(indexkey)
    })
    if (!test.length) return 'Chọn ít nhất 1 phần thi'
    return {
      name: name,
      petname: petname,
      species: species,
      address: address,
      mobile: mobile,
      test: test
    }
  }

  function signupSubmit() {
    data = checkSignupData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $.post(
        '',
        { action: 'signup', data: data },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#modal-presignup").modal('hide')
            $("#signup-name").val('')
            $("#signup-petname").val('')
            $("#signup-species").val('')
            $("#signup-address").val('')
            $("#signup-mobile").val('')
            $("[name=test]").each((index, item) => {
              item.checked = false
            })
          })
        }
      )
    }
  }

  function confirmList() {
    $("#confirm-modal").modal('show')
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      '',
      { action: 'filter', page: global['page'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#confirm-content').html(data['html'])
        })
      }
    )
  }

  function selectKey(name, type, key) {
    input = $("#"+ name +"-"+ type)
    input.val(key)
  }

  function installSuggest(name, type) {
    input = $("#"+ name +"-"+ type)
    suggest = $("#"+ name +"-"+ type + "-suggest")
    
    input.keyup((e) => {
      keyword = e.currentTarget.value.toLowerCase()
      html = ''
      count = 0

      global[type].forEach(item => {
        if (count < 30 && item.toLowerCase().search(keyword) >= 0) {
          count ++
          html += `
            <div class="suggest-item" onclick="selectKey('`+ name +`', '`+ type +`', '`+ item +`')">
              `+ item +`
            </div>`
        }
      })
      
      if (!html.length) {
        html = 'Không có kết quả'
      }
      
      suggest.html(html)
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 300);
    })
  }

</script>
<!-- END: main -->
