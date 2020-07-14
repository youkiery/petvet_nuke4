<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div id="msgshow" class="msgshow"></div>

{modal}

<div style="float: right;">
  <button class="btn btn-info">
    Lọc danh sách
  </button>
  <button class="btn btn-info" onclick="addUsg()">
    Thêm phiếu siêu âm
  </button>
</div>

<div style="clear: both;"></div>

<!-- <ul style="list-style-type: circle; padding: 10px;">
  <li>
    <a href="/index.php?nv={nv}&op={op}"> {lang.usg_list} </a>
  </li>
  <li>
    <a href="/index.php?nv={nv}&op={op}&page=list"> {lang.usg_new_list} </a>
    <img src="/themes/default/images/dispatch/new.gif">
  </li>
</ul> -->

<!-- BEGIN: filter -->
<!-- <button class="filter btn {check}" id="chatter_{ipd}" onclick="change_data({ipd})">
  {vsname}
</button> -->
<!-- END: filter -->

<!-- <div class="right">
  <button class="btn btn-info" id="exall">
    Hiện ghi chú
  </button>
</div> -->

<!-- <table class="table table-striped">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>  
      <th>
        {lang.customer}
      </th>  
      <th>
        {lang.phone}
      </th>  
      <th>
        {lang.usgcome}
      </th>  
      <th>
        {lang.usgcall}
      </th>  
      <th>
        {lang.usgconfirm}
      </th>
    </tr>
  </thead>
  <tbody id="disease_display">
    {content}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="9">
        <p style="float: right;" id="nav">
          {nav}
        </p>
      </td>
    </tr>
  </tfoot>
</table> -->

<script>
	var customer_list = [];
  var customer_data = []
  var g_filter = 0;
  var g_miscustom = -1;
  var g_vacid = -1;
  var g_index = -1
  var g_id = -1
  var g_petid = -1
  var page = "{page}";
  var refresh = 0

  var note = ["Hiện ghi chú", "Ẩn ghi chú"]
  var note_s = 0;
  // $("#exall").click(() => {
  //   if (note_s) {
  //     $(".note").hide()
  //     note_s = 0
  //   }
  //   else {
  //     $(".note").show()
  //     note_s = 1
  //   }
  //   $("#exall").text(note[note_s])
  // })

  $(document).ready(() => {
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
    checkCustomer = () => {
      $.post(
        '',
        { action: 'check'}
      )
    }
    installSuggest('name', 'customer', checkCustomer)
    installSuggest('phone', 'customer', checkPhone)
  })

  function addUsg() {
    $("#insert-modal").modal('show')
  }

  function addCustomer() {
    $("#insert-customer-name").val($("#customer_name").val())
    $("#insert-customer-phone").val($("#customer_phone").val())
    $("#insert-customer-address").val($("#customer_address").val())
    $("#customer-modal").modal('show')
  }
  function addPet() {
    $("#insert-pet-name").val()
    $("#pet-modal").modal('show')
  }

  function checkCustomerInfo() {
    return {
      name: $("#insert-customer-name").val(),
      phone: $("#insert-customer-phone").val(),
      address: $("#insert-customer-address").val()
    }
  }

  function insertCustomerSubmit() {
    sdata = checkCustomerInfo()
    if (!sdata['name'].length) {
      alert_msg("Nhập tên khách hàng trước!");
    }
    if (!sdata['phone'].length) {
      alert_msg("Nhập số điện thoại trước!");
    }
    else {
      $.post(
        '',
        { action: 'insert-customer', data: sdata },
        (response, status) => {
          checkResult(response, status).then(data => {
            switch (data["status"]) {
              case 1:
              alert_msg("Đã thêm khách hàng: " + sdata['name'] + "; Số điện thoại: " + sdata['phone']);
                customer_data = {
                  id: data["id"],
                  customer: sdata['name'],
                  phone: sdata['phone'],
                  pet: []
                }
                g_index = customer_list.length;
                customer_list.push(customer_data);
                customer_name.value = sdata['name'];
                customer_phone.value = sdata['phone'];
                g_customer = data["id"];
                $("#customer-modal").modal('hide')
                reloadPetOption(customer_data["pet"])
                break;
              case 2:
                alert_msg("Số điện thoại "+ sdata['phone'] +" đã được sử dụng");
                break;
            }
          })
        }
      )
    }
  }

  function insertPetSubmit() {
    sdata = {
      name: $("#insert-pet-name").val(),
      id: g_customer
    }
    if (!sdata['id']) {
      alert_msg('Chưa chọn khách hàng')
    }
    else if (!sdata['name']) {
      alert_msg('Nhập tên thú cưng trước')
    }
    else {
      $.post(
        '',
        { action: 'insert-pet', data: sdata },
        (response, status) => {
          checkResult(response, status).then(data => {
            switch (data['status']) {
              case 1:
                customer_data["pet"].push(data["data"]);
                reloadPetOption(customer_data["pet"])
                alert_msg("Đã thêm thú cưng(" + sdata['name'] + ")");
                $("#pet-modal").modal('hide')
              break;
              case 2:
                alert_msg('Nhập tên thú cưng khác')
              break;
            }
          })
        }
      )
    }
  }

  function installSuggest(name, type, func) {
    var timeout
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-" + name + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''
        func().then(list => {
          list.forEach(item => {
            html += '<div class="suggest_item" onclick="selectSuggest(\'' + name + '\', \'' + type + '\', \'' + JSON.stringify(item['data']) + '\')"> ' + item['name'] + '</div>'
          });
        })
        if (!html) html = 'Không tìm thấy kết quả'
        
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

  function selectSuggest(name, type, data) {
    data = JSON.parse(data)
    data.forEach(item => {
      $("." + type + '-' + name + '-' + item['type']).val(name) 
    });
  }

    // function filter2(e) {
    //   e.preventDefault();
    //   $("#disease_display").html("")
    //   var element = $("[name='filter']");
    //   var filter = "";
    //   element.each((i, e) => {
    //     if (e.checked == true) {
    //       filter += e.value;
    //     }
    //   })
    //   if (!filter.length) {
    //     filter = "0";
    //   }

    //   $.post(link + "sieuam", 
    //   {action: "filter", keyword: $("#keyword").val(), filter: filter},
    //   (response, status) => {
    //     var data = JSON.parse(response);
    //     $("#disease_display").html(data["data"]["html"])
    //   })
    // }

    // function change_custom(e) {
    //   e.preventDefault()
    //   var name = $("#vaccustom").val()
    //   var phone = $("#vacphone").val()
    //   var address = $("#vacaddress").val()
    //   var msg = "";

    //   if (!name.length) {
    //     msg = "{lang.no_custom_name}"
    //   }
    //   else if (phone.length < 4 || phone.length > 15) {
    //     msg = "{lang.no_custom_phone}"
    //   }
    //   else {
    //     $.post(
    //       strHref,
    //       { action: "change_custom", name: name, phone: phone, address: address, cid: g_miscustom, id: g_id, page: page, cnote: note_s },
    //       (response, status) => {
    //         var data = JSON.parse(response)
    //         if (data["status"]) {
    //           $("#miscustom").modal("toggle")
    //           $("#disease_display").html(data["list"])
    //         }
    //         alert_msg(data["notify"])
    //       }
    //     )
    //   }
    //   if (msg) {
    //     alert_msg(msg)
    //   }
    // }

    // function miscustom(id) {
    //   g_vacid = id
    //   $.post(
    //     strHref,
    //     { action: "get_miscustom", id: id },
    //     (response, status) => {
    //       var data = JSON.parse(response)
    //       if (data["status"]) {
    //         g_miscustom = data["id"]
    //         $("#miscustom").modal("toggle")
    //         $("#vaccustom").val(data["name"])
    //         $("#vacphone").val(data["phone"])
    //         $("#vacaddress").val(data["address"])
    //       }
    //     }
    //   )
    // }

    // function miscustom_submit() {
    //   $.post(
    //     "index.php?" + query_string,
    //     { action: "miscustom", vacid: g_vacid, id: g_id, page: page, cnote: note_s },
    //     (response, status) => {
    //       var data = JSON.parse(response)
    //       if (data["status"]) {
    //         $("#disease_display").html(data["list"])
    //         // note_s = 0
    //         // $("#exall").text(note[note_s])
    //         alert_msg("{lang.complete}")
    //       }
    //       else {
    //         alert_msg("{lang.error}")
    //       }
    //     }
    //   )
    // }
    // function deadend(id) {
    //   g_vacid = id
    //   $("#deadend").modal("toggle")
    // }
    // function deadend_submit(id) {
    //   $.post(
    //     "index.php?" + query_string,
    //     { action: "deadend", vacid: g_vacid, id: g_id, page: page },
    //     (response, status) => {
    //       var data = JSON.parse(response)
    //       if (data["status"]) {
    //         $("#disease_display").html(data["list"])
    //         alert_msg("{lang.complete}")
    //         // note_s = 0
    //         // $("#exall").text(note[note_s])
    //       }
    //       else {
    //         alert_msg("{lang.error}")
    //       }
    //     }
    //   )
    // }

    // function change_data(id) {
    //   g_filter = id;
    //   $.post(link + "sieuam",
    //     { action: "change_data", keyword: $("#customer_key").val(), filter: g_filter, page: page, cnote: 0 },
    //     (response, status) => {
    //       var data = JSON.parse(response);

    //       $(".filter").removeClass("btn-info")
    //       $("#chatter_" + id).addClass("btn-info")
    //       $("#disease_display").html(data["data"]["html"])
    //       note_s = 0
    //       $("#exall").text(note[note_s])
    //     })
    // }

    // $('#birthday').datepicker({
    //   format: 'dd/mm/yyyy',
    //   changeMonth: true,
    //   changeYear: true
    // });

    // function confirm_lower(index, vacid, petid) {
    //   var e = document.getElementById("vac_confirm_" + index);
    //   e = trim(e.innerText)
    //   if (e == "Đã Sinh") {

    //   }
    //   else {
    //     $.post(
    //       link + "xacnhansieuam",
    //       { act: "down", value: e, id: vacid, filter: g_filter, page: page, cnote: note_s },
    //       (data, status) => {
    //         data = JSON.parse(data);
    //         change_color(e, data, index, vacid, petid);
    //       }
    //     )
    //   }
    // }

    // function confirm_upper(index, vacid, petid) {
    //   var e = document.getElementById("vac_confirm_" + index);
    //   e = trim(e.innerHTML)
    //   if (e == "Đã Gọi") {
    //     birth(index, vacid, petid);
    //     $("#usgrecall").modal("toggle")
    //   }
    //   else {
    //     $.post(
    //       link + "xacnhansieuam",
    //       { act: "up", value: e, id: vacid, filter: g_filter, page: page, cnote: note_s },
    //       (data, status) => {
    //         data = JSON.parse(data);
    //         change_color(e, data, index, vacid, petid);
    //       }
    //     )
    //   }
    // }

    // function change_color(e, response, index, vacid, petid) {
    //   if (response["status"]) {
    //     // e.innerText = response["data"]["value"];
    //     // e.style.color = response["data"]["color"];

    //     $("#disease_display").html(response["data"]["html"]);
    //     alert_msg('{lang.changed}');
    //     // note_s = 0
    //     // $("#exall").text(note[note_s])


    //     // var check = response["data"].hasOwnProperty("birth");
    //     // if (check) {
    //     //   if (response["data"]["color"] == "green") {
    //     //     $("#birth_" + index).html("~> <button class='btn btn-info' type='button' data-toggle='modal' data-target='#usgrecall' onclick='birth(" + index + ", " + vacid + ", " + petid + ")'> " + response["data"]["birth"] + "</button>");
    //     //   }
    //     // } else {
    //     //   $("#birth_" + index).html("");
    //     // }
    //   }
    // }

    // function editNote(index) {
    //   var answer = prompt("Ghi chú: ", trim($("#note_v" + index).text()));
    //   if (answer) {
    //     $.post(
    //       link + "sieuam&act=post",
    //       { action: "editNote", note: answer, id: index },
    //       (data, status) => {
    //         data = JSON.parse(data);
    //         if (data["status"]) {
    //           $("#note_v" + index).text(answer);
    //         }
    //       }
    //     )
    //   }
    // }

    // function viewNote(index) {
    //   $("#note_" + index).toggle(500);
    // }

    // function birth(index, vacid, petid) {
    //   $("#birthnumber").val("")
    //   $("#birthday").val("")
    //   $("#btn_save_birth").attr("disable", true);

    //   $.post(
    //     link + "sieuam",
    //     { action: "getbirth", id: vacid },
    //     (response, status) => {
    //       data = JSON.parse(response);
    //       if (data["status"]) {
    //         $("#birthnumber").val(data["data"]["birth"])
    //         if (data["data"]["birthday"]) {
    //           $("#birthday").val(data["data"]["birthday"])
    //         }
    //         $("#doctor_select").html(data["data"]["doctor"])
    //         $("#btn_save_birth").attr("disable", false);
    //       }
    //     }
    //   )

    //   g_index = index
    //   g_id = vacid
    //   g_petid = petid
    // }

    // function onbirth(event) {
    //   event.preventDefault()
    //   $.post(
    //     link + "sieuam",
    //     { action: "birth", id: g_id, petid: g_petid, birth: $("#birthnumber").val(), birthday: $("#birthday").val(), doctor: $("#doctor_select").val(), filter: g_filter, page: page, cnote: note_s },
    //     (response, status) => {
    //       data = JSON.parse(response);
    //       if (data["status"]) {
    //         $("#usgrecall").modal("toggle");
    //         $("#disease_display").html(data["data"]["html"])
    //         alert_msg("{lang.saved}")
    //         // note_s = 0
    //         // $("#exall").text(note[note_s])
    //         // $("#birth_" + g_index).attr("disabled", "true")
    //         g_index = -1
    //         g_id = -1
    //         g_petid = -1
    //       }
    //     }
    //   )
    // }

    // $("tbody td[class]").click((e) => {
    //   var id = e.currentTarget.parentElement.getAttribute("id");
    //   $.post(link + "sieuam",
    //     { action: "getusgdetail", id: id },
    //     (response, status) => {
    //       // console.log(response);
    //       data = JSON.parse(response);

    //       if (data["status"]) {
    //         var c = document.createElement("canvas")
    //         var ctx = c.getContext("2d");
    //         var img = new Image()
    //         img.src = data["data"]["image"];
    //         img.onload = () => {
    //           c.width = img.width
    //           c.height = img.height
    //           ctx.fillStyle = "#fff"
    //           ctx.fillRect(0, 0, c.width, c.height)
    //           ctx.drawImage(img, 0, 0)
    //           var image_data = c.toDataURL("image/jpg")
    //           $("#thumb").attr("src", image_data);
    //         }

    //         $("#thumb").attr("src", "");
    //         $("#petname").text(data["data"]["petname"]);
    //         $("#customer").text(data["data"]["customer"]);
    //         $("#phone").text(data["data"]["phone"]);
    //         $("#sieuam").text(data["data"]["cometime"]);
    //         $("#dusinh").text(data["data"]["calltime"]);
    //       }
    //       else {
    //         // console.log(data["error"]);
    //       }
    //     })
    // })

    // setInterval(() => {
    //   if (!refresh) {
    //     refresh = 1
    //     $.post(link + "sieuam",
    //       { action: "change_data", keyword: $("#customer_key").val(), filter: g_filter, page: page, cnote: note_s },
    //       (response, status) => {
    //         var data = JSON.parse(response);
    //         $("#disease_display").html(data["data"]["html"])
    //         refresh = 0
    //       })
    //   }
    // }, 10000);
</script>
<!-- END: main -->