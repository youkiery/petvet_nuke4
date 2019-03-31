<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>

<div class="row">
  <div class="col-lg-11 user-list" id="doctor-suggest-list">
    {doctor_suggest_list}
  </div>
  <div class="col-lg-2">

  </div>
  <div class="col-lg-11 user-list" id="doctor-list">
    {doctor_list}
  </div>
</div>

<script>
  doctorSuggestList = $("#doctor-suggest-list")
  doctorList = $("#doctor-list")

  function remove(id) {
    $(".btn").attr("disabled", true)
    $.post(
      strHref,
      {action: "doctor-remove", doctorId: id},
      (response, status) => {
        checkResult(response, status).then((data) => {
          doctorSuggestList.html(data["doctorSuggestList"])
          doctorList.html(data["doctorList"])
          $(".btn").attr("disabled", false)
        }, () => {
          $(".btn").attr("disabled", false)
        })
      }
    )
  }

  function insert(id) {
    $(".btn").attr("disabled", true)
    $.post(
      strHref,
      {action: "doctor-insert", doctorId: id},
      (response, status) => {
        checkResult(response, status).then((data) => {
          doctorSuggestList.html(data["doctorSuggestList"])
          doctorList.html(data["doctorList"])
          $(".btn").attr("disabled", false)
        }, () => {
          $(".btn").attr("disabled", false)
        })
      }
    )
  }
</script>
<!-- END: main -->