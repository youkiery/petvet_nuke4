<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">

<div class="msgshow"></div>
<!-- <div id="modal-insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p class="text-center"> <b> Cấp giấy, chip thú cưng </b> </p>

        <div class="relative">
          <input class="form-control" id="insert-owner" type="text" autocomplete="off"
            placeholder="tìm kiếm khách hàng">
          <div class="suggest" id="insert-owner-suggest"></div>
        </div>

        <div class="relative">
          <input class="form-control" id="insert-pet" type="text" autocomplete="off"
            placeholder="tìm kiếm khách hàng">
          <div class="suggest" id="insert-pet-suggest"></div>
        </div>

        <label> 
          Ngày cấp
          <input type="text" class="form-control" id="insert-time">
        </label>

        <label> 
          Số tiền
          <input type="number" value="0" class="form-control" id="insert-price">
        </label>

        <div class="text-center">
          <button class="btn btn-success" onclick="insertSubmit()">
            Thêm
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<button class="btn btn-success" style="float: right;" onclick="insert()">
  <span class="glyphicon glyphicon-plus"></span>
</button>
<div style="clear: both;"></div> -->

<div id="content">
  {content}
</div>
<script>
  var content = $("#content")
  var global = {
    owner: 0,
    type: 0
  }

  $().ready(() => {
    installRemindOwner('insert-owner')
    installRemindPet('insert-pet')

    $("#insert-time").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });

  })

  function insert() {
    $("#modal-insert").modal('show')
  }

  function pickOwner(name, id) {
    $("#insert-owner").val(name)
    global['owner'] = id
  }

  function pickPet(name, id) {
    $("#insert-pet").val(name)
    global['pet'] = id
  }

  function installRemindOwner(section) {
    var timeout
    var input = $("#" + section)
    var suggest = $("#" + section + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
          strHref,
          { action: 'parent', keyword: key },
          (response, status) => {
            checkResult(response, status).then(data => {
              suggest.html(data['html'])
            }, () => { })
          }
        )

        suggest.html(html)
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

  function installRemindPet(section) {
    var timeout
    var input = $("#" + section)
    var suggest = $("#" + section + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''

        $.post(
          strHref,
          { action: 'pet', keyword: key, userid: global['owner'] },
          (response, status) => {
            checkResult(response, status).then(data => {
              suggest.html(data['html'])
            }, () => { })
          }
        )

        suggest.html(html)
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

</script>
<!-- END: main -->
