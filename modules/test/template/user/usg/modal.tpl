<!-- BEGIN: main -->
<div id="customer-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal">&times;</div> <br>

                <div class="form-group">
                    <label> Tên khách hàng </label>
                    <input type="text" class="form-control" id="insert-customer-name">
                </div>
                <div class="form-group">
                    <label> Số điện thoại </label>
                    <input type="text" class="form-control" id="insert-customer-phone">
                </div>
                <div class="form-group">
                    <label> Địa chỉ </label>
                    <textarea class="form-control" id="insert-customer-address" rows="4"></textarea>
                </div>
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-success" onclick="insertCustomerSubmit()"> Thêm khách hàng
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="pet-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal">&times;</div> <br>
                <label> Tên thú cưng </label>
                <input type="text" class="form-control" id="insert-pet-name">
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-success" onclick="insertPetSubmit()"> Thêm thú cưng </button>
            </div>
        </div>
    </div>
</div>

<div id="insert-modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal">&times;</div> <br>
                <div style="float: right;">
                    <div class="vac_icon customer_icon" onclick="addCustomer()">
                        <img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng">
                    </div>
                    <div class="vac_icon pet_icon" tooltip="Thêm thú cưng" onclick="addPet()">
                        <img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng">
                    </div>
                </div>

                <div class="form-detail">
                    <h2>
                        {lang.usg_title}
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
                        <div class="form-group col-md-8">
                            <label>{lang.address}</label>
                            <input class="form-control" id="customer_address" type="text" name="address">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-5">
                            <label>{lang.petname}</label>
                            <select class="form-control" id="pet_info" style="text-transform: capitalize;"
                                name="petname"></select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>{lang.usgcome}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control date" id="ngaysieuam" value="{now}" readonly>
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label>{lang.usgcall}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control date" id="calltime" value="{dusinh}" readonly>
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label>{lang.usgexbirth}</label>
                            <input type="number" class="form-control" id="exbirth" value="0">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11">
                            <label>{lang.doctor}</label>
                            <select class="form-control" name="doctor" id="doctor" style="width: 90%;">
                                <!-- BEGIN: doctor -->
                                <option value="{doctor_value}">{doctor_name}</option>
                                <!-- END: doctor -->
                            </select>
                        </div>
                        <div class="form-group col-md-11">
                            <label>{lang.note}</label>
                            <textarea class="form-control" id="ghichu" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <input class="btn btn-success" type="submit" value="{lang.submit}">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="miscustom" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div>
                    {lang.miscustom_prequest}
                </div>
            </div>
            <div class="modal-body">
                <form onsubmit="return change_custom(event)">
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label> {lang.customer} </label>
                            <input type="text" class="form-control" id="vaccustom">
                        </div>
                        <div class="form-group col-md-12">
                            <label> {lang.phone} </label>
                            <input type="text" class="form-control" id="vacphone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label> {lang.address} </label>
                        <input type="text" class="form-control" id="vacaddress">
                    </div>
                    <button class="btn btn-info">
                        {lang.g_edit}
                    </button>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-info" data-dismiss="modal" onclick="miscustom_submit()">
                    {lang.submit}
                </button>
                <button class="btn btn-info" data-dismiss="modal">
                    {lang.cancel}
                </button>
            </div>
        </div>
    </div>
</div>

<div id="deadend" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div>
                    {lang.deadend_prequest}
                </div>
            </div>
            <div class="modal-footer">
                <button data-dismiss="modal" onclick="deadend_submit()">
                    {lang.submit}
                </button>
                <button data-dismiss="modal">
                    {lang.cancel}
                </button>
            </div>
        </div>
    </div>
</div>

<div id="usgrecall" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">{lang.usgrecallmodal}</h4>
            </div>
            <div class="modal-body">
                <form onsubmit="return onbirth(event)">
                    <div class="form-group">
                        <div>
                            <label>{lang.usgnumber}</label>
                            <input class="form-control" type="number" id="birthnumber">
                        </div>
                    </div>
                    <div class="form-group">
                        <div>
                            <label>{lang.usgbirthday}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="birthday" value="{now}" readonly>
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div>
                            <label>{lang.usgdoctor}</label>
                            <select class="form-control" id="doctor_select">
                                <!-- BEGIN: doctor -->
                                <option value="{doctorid}">
                                    {doctorname}
                                </option>
                                <!-- END: doctor -->
                            </select>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <button class="btn btn-info" id="btn_save_birth">
                            {lang.save}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="usgdetail" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div id="thumb-box">
                    <img id="thumb" src="{image}">
                </div>
                <div id="info">
                    <p>
                        {lang.petname}:
                        <span id="petname"></span>
                    </p>
                    <p>
                        {lang.customer}:
                        <span id="customer"></span>
                    </p>
                    <p>
                        {lang.phone}:
                        <span id="phone"></span>
                    </p>
                    <p>
                        {lang.usgcome}:
                        <span id="sieuam"></span>
                    </p>
                    <p>
                        {lang.usgcall}:
                        <span id="dusinh"></span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->