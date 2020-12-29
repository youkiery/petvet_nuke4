<!-- BEGIN: main -->
<div class="modal" id="employ-insert-modal" role="dialog">
  <div class="modal-dialog modal-fade">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thêm nhân viên
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>
        <div class="form-group">
          <form onsubmit="return employInsert(event)">
            <div class="input-group">
              <input type="text" class="form-control" id="employ-insert-name">
              <div class="input-group-btn">
                <button class="btn btn-success">
                  thêm
                </button>
              </div>
            </div>
          </form>
        </div>

        <div id="employ-insert-content">
          {employ_insert_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="salary-up-modal" role="dialog">
  <div class="modal-dialog modal-fade">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Nâng lương
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <form onsubmit="return salaryUp(event)">
          <div class="form-group">
            <label> Ngày nâng lương </label>
            <div class="input-group">
              <input type="text" class="form-control date" id="salary-up-time" value="{time}">
              <div class="input-group-addon"></div>
            </div>
          </div>
          <div class="form-group">
            <label> Hình thức khen thưởng </label>
            <input type="text" class="form-control" id="salary-up-formal">
          </div>
          <div class="form-group">
            <label> File </label>
            <input type="text" class="form-control" id="salary-up-file">
          </div>
          <div class="form-group">
            <label> Ghi chú </label>
            <textarea class="form-control" id="salary-up-note" rows="4"></textarea>
          </div>

          <button class="btn btn-info btn-block">
            Nâng lương
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="promo-up-modal" role="dialog">
  <div class="modal-dialog modal-fade">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Bổ nhiệm
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <form onsubmit="return promoUp(event)">
          <div class="form-group">
            <label> Ngày nâng lương </label>
            <div class="input-group">
              <input type="text" class="form-control date" id="promo-up-time" value="{time}">
              <div class="input-group-addon"></div>
            </div>
          </div>
          <div class="form-group">
            <label> File </label>
            <input type="text" class="form-control" id="promo-up-file">
          </div>
          <div class="form-group">
            <label> Ghi chú </label>
            <textarea class="form-control" id="promo-up-note" rows="4"></textarea>
          </div>

          <button class="btn btn-info btn-block">
            Bổ nhiệm
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="history-modal" role="dialog">
  <div class="modal-dialog modal-fade modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Bổ nhiệm
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <div id="history-content"> </div>
      </div> 
    </div>
  </div>
</div>


<!-- END: main -->