<!-- BEGIN: main -->
<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <b> X-Quang </b>
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="insert">
          <div style="float: right;">
            <div
              style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')"
              class="vac_icon" onclick="addCustomer()">
              <img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng">
            </div>
            <div
              style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')"
              class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
              <img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng">
            </div>
          </div>
          <br>
          <br>
          <div class="rows">
            <div class="col-4">
              {lang.customer}
              <div class="relative">
                <input class="form-control" id="customer_name" type="text" name="customer">
                <div id="customer_name_suggest" class="suggest"></div>
              </div>
            </div>
            <div class="col-4">
              {lang.phone}
              <div class="relative">
                <input class="form-control" id="customer_phone" type="number" name="phone">
                <div id="customer_phone_suggest" class="suggest"></div>
              </div>

            </div>
            <div class="col-4">
              {lang.address}
              <input class="form-control" id="customer_address" type="text" name="address">
            </div>
          </div>

          <div class="rows">
            <div class="col-6">
              <label>{lang.petname}</label>
              <select class="form-control" id="pet_info" style="text-transform: capitalize;" name="petname"></select>
            </div>
            <div class="col-6">
              <label>{lang.treatcome}</label>
              <input type="text" class="form-control date" id="cometime" value="{now}">
            </div>
          </div>
        </div>
        <div class="edit">
          <div class="rows">
            <div class="col-6">
              <p> {lang.petname}: <span id="edit-pet"></span> </p>
              <p> {lang.treatcome}: <span id="edit-cometime"></span> </p>
            </div>
            <div class="col-6">
              <p> {lang.customer}: <span id="edit-customer"></span> </p>
              <p> {lang.phone}: <span id="edit-phone"></span> </p>
            </div>
          </div>
          <div>
            <span id="treat-list"></span>
            <button class="insult btn btn-success btn-xs" onclick="insertTreat()">
              +
            </button>
          </div>
        </div>
        <div class="rows">
          <div class="col-6">
            <label>{lang.temperate} </label>
            <input class="insult form-control" type="text" id="temperate">
          </div>
          <div class="col-6">
            <label>{lang.eye} </label>
            <input class="insult form-control" type="text" id="eye">
          </div>
        </div>
        <div class="rows">
          <div class="col-12">
            <label>{lang.other} </label>
            <input class="insult form-control" type="text" id="other">
          </div>
        </div>
        <div class="rows">
          <div class="col-12">
            <label>{lang.treating} </label>
            <input class="insult form-control" type="text" id="treating">
          </div>
        </div>
        <div class="rows">
          <div class="col-6">
            <label>{lang.doctor2} </label>
            <select class="insult form-control" name="doctor" id="doctor">
              <!-- BEGIN: doctor -->
              <option value="{doctor_value}">{doctor_name}</option>
              <!-- END: doctor -->
            </select>
          </div>
          <div class="col-6">
            <label>{lang.pet_status}</label>
            <select class="insult form-control" name="tinhtrang" id="condition">
              <!-- BEGIN: status -->
              <option value="{status_value}">{status_name}</option>
              <!-- END: status -->
            </select>
          </div>
        </div>

        <div class="box-list">
          <span id="image-list"></span>
          <label class="box" id="image"> + </label>
        </div>

        <div style="clear: both;"></div>

        <div class="text-center">
          <div class="insert">
            <input class="btn btn-info" type="submit" value="{lang.submit}" onclick="insertXraySubmit()">
          </div>
          <div class="edit">
            <button class="insult btn btn-info" onclick="editSubmit(0)"> Lưu phiếu điều trị </button>
            <button class="insult btn btn-info" onclick="editSubmit(1)"> Điều trị xong </button>
            <button class="insult btn btn-danger" onclick="editSubmit(2)"> Đã chết </button>
            <!-- <button class="btn btn-info" onclick="summary()"> Tổng kết </button> -->
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- <div id="edit-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div id="info">
        </div>
        <div class="treating">
          <span id="treating" style="float: right;"></span>
          <div class="input-group">
            <input type="text" class="form-control date" id="timetreating" value="{now}" readonly>
            <div class="input-group-btn">
              <button class="submitbutton btn btn-info" onclick="insertTreat()">
                {lang.add}
              </button>
            </div>
          </div>
          <div id="dstreating"> </div>
          <div id="treating">
            <form onsubmit="return luutreating(event)" id="qltreating">
              <div style="font-size:0px;">
                <input class="form-control" type="text" id="temperate" placeholder="{lang.temperate}">
                <input class="form-control" type="text" id="eye" placeholder="{lang.eye}">
                <input class="form-control" type="text" id="other" placeholder="{lang.other}">
                <input class="form-control" type="text" id="treating2" placeholder="{lang.treating}">
              </div>
              <div>
                <label for="doctorx">{lang.doctor}</label>
                <select class="form-control" name="doctorx" id="doctorx">
                  <option value="{doctorid}"> {doctorname} </option>
                </select>
              </div>
              <div>
                <label for="status">{lang.status}</label>
                <select class="form-control" name="status" id="status2">
                  <option value="{status_value}"> {status_name} </option>
                </select>
              </div>
              <div>
                <label for="xetnhiem">{lang.examine}</label>
                <select class="form-control" name="examine" id="examine">
                  <option value="0"> {lang.non} </option>
                  <option value="1"> {lang.have} </option>
                </select>
              </div>
              <button class="submitbutton btn btn-info">
                {lang.submit}
              </button>
              <input type="button" class="btn btn-info" onclick="ketthuc(1)" value="{lang.treated}">
              <input type="button" class="btn btn-info" onclick="ketthuc(2)" value="{lang.dead}">
              <input type="button" class="btn btn-info" onclick="tongket(1)" value="{lang.summary}" data-toggle="modal"
                data-target="#treatinsult">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div> -->
<!-- END: main -->