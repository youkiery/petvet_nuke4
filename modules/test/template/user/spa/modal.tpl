<!-- BEGIN: main -->

<div class="modal fade" id="img" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <img class="img-responsive" id="img-src">
      </div>
    </div>
  </div>
</div>

<div id="customer_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_custom_title}</h4>
      </div>
      <div class="modal-body">
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
          Thêm phiếu SPA
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="insert">
          <div class="form-group">
            <div class="rows">
              <div class="col-6">
                Số điện thoại
                <div class="relative">
                  <input class="form-control" id="phone" type="text" autocomplete="off">
                  <div class="suggest" id="phone-suggest"></div>
                </div>
              </div>
              <div class="col-6">
                Tên khách hàng
                <div class="relative">
                  <input class="form-control" id="customer" type="text" autocomplete="off">
                  <div class="suggest" id="customer-suggest"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label>{lang.spa_weight}</label>
            <select class="form-control" id="weight">
              <!-- BEGIN: weight -->
              <option value="{weight_value}">{weight_name}</option>
              <!-- END: weight -->
            </select>
          </div>
        </div>

        <div class="update">
          <div class="form-group">
            <b> Người nhận: </b>
            <span id="detail_doctor"></span>
          </div>
          <div class="form-group">
            <b> Thời gian nhận: </b>
            <span id="detail_from"></span>
          </div>
          <div class="form-group">
            <b> Cân nặng: </b>
            <span id="detail_weight"></span>
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

        <div class="form-group insert">
          <label>{lang.spa_doctor}</label>
          <select class="form-control" id="doctor">
            <!-- BEGIN: doctor -->
            <option value="{doctor_value}">{doctor_name}</option>
            <!-- END: doctor -->
          </select>
        </div>

        <div id="insert_content">
          {insert_content}
        </div>

        <div class="form-group">
          <div style="width: 30%; display: inline-block;">
            Ghi chú
          </div>
          <div style="width: 69%; display: inline-block;">
            <input type="text" class="form-control" id="note">
          </div>
        </div>

        <div class="text-center insert">
          <button class="btn btn-info" onclick="insertSubmit()">
            {lang.submit}
          </button>
        </div>
        <div class="text-center update">
          <button class="btn btn-info" onclick="update()" id="btn-detail">
            {lang.update}
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->