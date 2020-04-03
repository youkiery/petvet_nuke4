<!-- BEGIN: main -->
<div id="customer_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          {lang.spa_custom_title}
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <form onsubmit="return customer_submit(event)">
          <div class="row">
            <div class="form-group col-md-12">
              <label>{lang.customer}</label>
              <input type="text" class="form-control" id="customer_name">
            </div>
            <div class="form-group col-md-12">
              <label>{lang.phone}</label>
              <input type="text" class="form-control" id="customer_phone">
            </div>
          </div>
          <div class="form-group">
            <label>{lang.address}</label>
            <input type="text" class="form-control" id="customer_address">
          </div>
          <button class="btn btn-info">
            {lang.submit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          {lang.spa_insert}
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <div class="insert">
          <div class="form-group">
            <label>{lang.customer} <span class="small_icon" data-toggle="modal" data-target="#customer_modal"> +
              </span></label>
            <div class="relative">
              <input class="form-control" id="customer" type="text" name="customer" autocomplete="off">
              <div class="suggest" id="customer-suggest"></div>
            </div>
          </div>
  
          <div class="form-group row">
            <div class="col-md-12">
              <b>
                {lang.customer_name}:
              </b>
              <span id="customer_name_info"> </span>
            </div>
            <div class="col-md-12">
              <b>
                {lang.customer_number}:
              </b>
              <span id="customer_phone_info"> </span>
            </div>
          </div>
          <div class="row form-group">
            Hình ảnh
            <label class="btn btn-info" for="file">
              <input id="file" type="file" style="display: none" onchange="onselected(this)">
              <span class="glyphicon glyphicon-upload"></span>
            </label>
            <img id="blah" width="64px" height="64px">
          </div>
        </div>

        <div class="edit">
          <div class="form-group">
            <b>Khách hàng:</b> <span id="detail_customer"></span>
          </div>
          <div class="form-group">
            <b> Số điện thoại: </b> <span id="detail_phone"></span>
          </div>
          <div class="form-group">
            <b> Thời gian nhận: </b> <span id="time"></span>
          </div>
          <div class="form-group text-center">
            <img id="image" style="max-width: 256px; max-height: 256px;" />
          </div>
        </div>

        <div class="form-group">
          <label>{lang.spa_doctor}</label>
          <select class="form-control" id="doctor">
            <option value="0"> Chưa chọn </option>
            <!-- BEGIN: doctor -->
            <option value="{doctor_value}">{doctor_name}</option>
            <!-- END: doctor -->
          </select>
        </div>

        <div class="form-group">
          <!-- BEGIN: box -->
          <div style="float: left; width: 49%;">
            <label>
              <input type="checkbox" type="text" class="box" id="{id}"> {name}
            </label>
          </div>
          <!-- END: box -->
        </div>

        <div style="clear: both;"></div>

        <div class="form-group">
          <label>
            {lang.note}
          </label>
          <input type="text" class="form-control" id="c_note">
        </div>
        <div class="text-center">
          <button class="btn btn-info insert" onclick="insertSubmit()">
            Thêm phiếu
          </button>
          <button class="btn btn-info edit" onclick="editSubmit()">
            Chỉnh sửa thông tin
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
