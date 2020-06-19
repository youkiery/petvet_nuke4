<!-- BEGIN: main -->
<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b> Thêm X-Quang </b>
          <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        </div>

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
          <h2>
            {lang.treat_title}
            <span id="e_notify" style="display: none;"></span>
          </h2>
          <div class="row">
            <div class="form-group col-md-7">
              <div>
                <label>{lang.customer}</label>
                <div class="relative">
                  <input class="form-control" id="customer_name" type="text" name="customer">
                  <div id="customer_name_suggest" class="suggest"></div>
                </div>
              </div>
            </div>
            <div class="form-group col-md-7">
              <div>
                <label>{lang.phone}</label>
                <div class="relative">
                  <input class="form-control" id="customer_phone" type="number" name="phone">
                  <div id="customer_phone_suggest" class="suggest"></div>
                </div>
              </div>
            </div>
            <div class="form-group col-md-10">
              <label>{lang.address}</label>
              <input class="form-control" id="customer_address" type="text" name="address">
            </div>
          </div>
          <div class="row">
            <div class="form-group col-md-12">
              <label>{lang.petname}</label>
              <select class="form-control" id="pet_info" style="text-transform: capitalize;" name="petname"></select>
            </div>
            <div class="form-group col-md-12">
              <label>{lang.treatcome}</label>
              <input type="text" class="form-control date" id="cometime" value="{now}">
            </div>
          </div>
          <div class="form-group">
            <label>{lang.temperate} </label>
            <input class="form-control" type="text" id="temperate">
          </div>
          <div class="form-group">
            <label>{lang.eye} </label>
            <input class="form-control" type="text" id="eye">
          </div>
          <div class="form-group">
            <label>{lang.other} </label>
            <input class="form-control" type="text" id="other">
          </div>
          <div class="form-group">
            <label>{lang.treating} </label>
            <input class="form-control" type="text" id="treating2">
          </div>
          <div class="row">
            <div class="form-group col-md-12">
              <label>{lang.doctor2} </label>
              <select class="form-control" name="doctor" id="doctor">
                <!-- BEGIN: doctor -->
                <option value="{doctor_value}">{doctor_name}</option>
                <!-- END: doctor -->
              </select>
            </div>
            <div class="form-group col-md-12">
              <label>{lang.pet_status}</label>
              <select class="form-control" name="tinhtrang" id="condition">
                <!-- BEGIN: status -->
                <option value="{status_value}">{status_name}</option>
                <!-- END: status -->
              </select>
            </div>
          </div>
          <div class="form-group text-center">
            <input class="btn btn-info" type="submit" value="{lang.submit}" onclick="insertXraySubmit()">
          </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->