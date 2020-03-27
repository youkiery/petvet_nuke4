<!-- BEGIN: main -->
<div id="customer-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

                <div class="form-group row">
                    <div class="col-sm-12">
                        <label> Khách hàng </label>
                        <input type="text" class="form-control" id="customer-name">
                    </div>
                    <div class="col-sm-12">
                        <label> Số điện thoại </label>
                        <input type="text" class="form-control" id="customer-phone">
                    </div>
                </div>

                <div class="form-group">
                    <label> Địa chỉ </label>
                    <textarea type="text" class="form-control" id="customer-address"></textarea>
                </div>

                <div class="text-center">
                    <button class="btn btn-info" onclick="editCustomerSubmit()">
                        Chỉnh sửa thông tin khách hàng
                    </button>
                    <p class="error" id="customer-error"> </p>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="search-all" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <table class="table table-striped table-border">
                    <thead>
                        <tr>
                            <th colspan="9" class="vng_vacbox_title" style="text-align: center">
                                {title}
                            </th>
                        </tr>
                        <tr>
                            <th>
                                {lang.customer}
                            </th>
                            <th>
                                {lang.phone}
                            </th>
                            <th>
                                {lang.disease}
                            </th>
                            <th>
                                {lang.vaccome}
                            </th>
                            <th>
                                {lang.vacconfirm}
                            </th>
                        </tr>
                    </thead>
                    <tbody id="search-all-content">
                        <!-- {content} -->
                    </tbody>
                </table>
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

<div id="detail" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8">
                        {lang.customer}
                    </div>
                    <div class="col-md-16" id="detail_custom"> </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        {lang.phone}
                    </div>
                    <div class="col-md-16" id="detail_phone"> </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        {lang.petname}
                    </div>
                    <div class="col-md-16" id="detail_pet"> </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        {lang.disease}
                    </div>
                    <div class="col-md-16" id="detail_disease"> </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        {lang.doctor}
                    </div>
                    <div class="col-md-16" id="detail_doctor"> </div>
                </div>
            </div>
            <div class="modal-footer">
                <button data-dismiss="modal">
                    {lang.cancel}
                </button>
            </div>
        </div>
    </div>
</div>

<div id="vaccinedetail" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">{lang.confirm_mess}</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label>{lang.recall}</label>
                        <div class="input-group date" data-provide="datepicker">
                            <input type="text" class="form-control" id="confirm_recall" readonly>
                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>{lang.doctor}</label>
                        <select class="form-control" id="doctor_select">
                            <!-- BEGIN: doctor -->
                            <option value="{doctorid}">
                                {doctorname}
                            </option>
                            <!-- END: doctor -->
                        </select>
                    </div>
                    <div class="form-group text-center">
                        <input class="btn btn-info" id="btn_save_vaccine" type="button" onclick="save_form()"
                            value="{lang.save}">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<div id="vaccine-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <h2> Thêm tiêm phòng </h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="rows">
                    <div class="form-group col-3">
                        <label>{lang.customer}</label>
                        <div class="relative">
                            <input class="form-control" id="customer_name" type="text" name="customer">
                            <div id="customer_name_suggest" class="suggest"></div>
                        </div>
                    </div>
                    <div class="form-group col-3">
                        <label>{lang.phone}</label>
                        <div class="relative">
                            <input class="form-control" id="customer_phone" type="number" name="phone">
                            <div id="customer_phone_suggest" class="suggest"></div>
                        </div>
                    </div>
                    <div class="form-group col-6">
                        <label>{lang.address}</label>
                        <input class="form-control" id="customer_address" type="text" name="address">
                    </div>
                </div>
                <div class="rows">
                    <div class="form-group col-6">
                        <label>{lang.petname}</label>
                        <select class="form-control" id="pet_info" style="text-transform: capitalize;"
                            name="petname"></select>
                    </div>
                    <div class="form-group col-6">
                        <label>{lang.disease}</label>
                        <select class="form-control" id="pet_disease" class="vac_select_max"
                            style="text-transform: capitalize;" name="disease">
                            <!-- BEGIN: option -->
                            <option value="{disease_id}">
                                {disease_name}
                            </option>
                            <!-- END: option -->
                        </select>
                    </div>
                    <div class="form-group col-6">
                        <label>{lang.vaccome}</label>
                        <div class="input-group date" data-provide="datepicker">
                            <input type="text" class="form-control" id="pet_cometime" value="{now}" readonly>
                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-6">
                        <label>{lang.vaccall}</label>
                        <div class="input-group date" data-provide="datepicker">
                            <input type="text" class="form-control" id="pet_calltime" value="{calltime}" readonly>
                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="rows">
                    <div class="form-group col-md-12">
                        <label>{lang.vacdoctor}</label>
                        <select class="form-control" id="doctor">
                            <!-- BEGIN: doctor -->
                            <option value="{doctorid}">{doctorname}</option>
                            <!-- END: doctor -->
                        </select>
                    </div>
                    <div class="form-group col-md-12">
                        <label>{lang.note}</label>
                        <textarea class="form-control" id="pet_note" rowss="3" style="width: 98%;"></textarea>
                    </div>
                </div>
                <div class="form-group text-center">
                    <input class="btn btn-info" type="submit" value="{lang.submit}">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->