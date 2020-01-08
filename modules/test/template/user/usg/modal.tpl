<!-- BEGIN: main -->
<div id="usgupdate" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/contact_edit.png')"
                    class="vac_icon" onclick="update_customer(g_customerid)">
                    <img src="/themes/default/images/vaccine/trans.png" title="Sửa khách hàng">
                </div>
                <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/pet_edit.png')"
                    class="vac_icon" tooltip="Sửa thú cưng" onclick="update_pet(g_petid, g_pet)">
                    <img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng">
                </div>
            </div>
            <div class="modal-body">
                <form onsubmit="return update_usg(event)" autocomplete="off">
                    <div>
                        {lang.usg_update}
                        <span id="e_notify" style="display: none;"></span>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-8">
                            <label>{lang.usgcome}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="cometime2" value="{now}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-8">
                            <label>{lang.usgcall}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="calltime2" value="{now}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-8">
                            <label>{lang.exbirth}</label>
                            <input class="form-control" id="exbirth" type="number">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label>{lang.birthday}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="birth" value="{now}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-12">
                            <label>{lang.birth}</label>
                            <input class="form-control" id="birthnumber" type="number">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-8">
                            <label>{lang.firstvac}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="firstvac" value="{now}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-8">
                            <label>{lang.vaccine}</label>
                            <select class="form-control" id="vaccine_status"> </select>
                        </div>
                        <div class="form-group col-md-8">
                            <label>{lang.recall}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="recall" value="{now}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>{lang.doctor}</label>
                        <select class="form-control" name="doctor" id="doctor2">
                            <!-- BEGIN: doctor3 -->
                            <option value="{doctor_value}">{doctor_name}</option>
                            <!-- END: doctor3 -->
                        </select>
                    </div>
                    <div class="form-group">
                        <label>{lang.note}</label>
                        <textarea class="form-control" id="note2" rows="3"></textarea>
                    </div>
                    <div class="form-group text-center">
                        <button class="btn btn-info" id="btn_usg_update">
                            {lang.submit}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="filter-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/contact_edit.png')"
                    class="vac_icon" onclick="update_customer(g_customerid)">
                    <img src="/themes/default/images/vaccine/trans.png" title="Sửa khách hàng">
                </div>
                <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/pet_edit.png')"
                    class="vac_icon" tooltip="Sửa thú cưng" onclick="update_pet(g_petid, g_pet)">
                    <img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng">
                </div>
            </div>
            <div class="modal-body">
                <form method="GET">
                    <input type="hidden" name="nv" value="{nv}">
                    <input type="hidden" name="op" value="{op}">
                    <div class="row">
                        <div class="form-group col-md-8">
                            <label>{lang.keyword}</label>
                            <input class="form-control" type="text" name="keyword" id="keyword" value="{keyword}"
                                placeholder="{lang.keyword}">
                        </div>
                        <div class="form-group col-md-8">
                            <label>{lang.startday}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="from" name="from" value="{from}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-8">
                            <label>{lang.endday}</label>
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control" id="to" name="to" value="{to}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label>{lang.sort}</label>
                            <select class="form-control" name="sort" id="sort">
                                <!-- BEGIN: sort -->
                                <option value="{sort_value}" {sort_check}>{sort_name}</option>
                                <!-- END: sort -->
                            </select>
                        </div>
                        <div class="form-group col-md-12">
                            <label>{lang.count}</label>
                            <select class="form-control" name="filter" id="time">
                                <!-- BEGIN: time -->
                                <option value="{time_value}" {time_check}>{time_name}</option>
                                <!-- END: time -->
                            </select>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <button class="btn btn-info">
                            {lang.filter}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="insert-modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button>

                <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')"
                    class="vac_icon" onclick="addCustomer()">
                    <img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng">
                </div>
                <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')"
                    class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
                    <img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng">
                </div>
                <br>
                <form id="add" onsubmit="return themsieuam(event)" autocomplete="off">
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
                            <div class="form-group col-md-10">
                                <label>{lang.address}</label>
                                <input class="form-control" id="customer_address" type="text" name="address">
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-10">
                                <label>{lang.petname}</label>
                                <select class="form-control" id="pet_info" style="text-transform: capitalize;"
                                    name="petname"></select>
                            </div>
                            <div class="form-group col-md-7">
                                <label>{lang.usgcome}</label>
                                <div class="input-group date" data-provide="datepicker">
                                    <input type="text" class="form-control" id="ngaysieuam" value="{now}">
                                    <div class="input-group-addon">
                                        <span class="glyphicon glyphicon-th"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-7">
                                <label>{lang.usgcall}</label>
                                <div class="input-group date" data-provide="datepicker">
                                    <input type="text" class="form-control" id="calltime" value="{now}">
                                    <div class="input-group-addon">
                                        <span class="glyphicon glyphicon-th"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>{lang.image}</label>
                            <input class="form-control" type="text" name="hinhanh" id="hinhanh">
                            <!-- <div class="icon upload" type="button" value="{lang.selimage}" name="selectimg"></div> -->
                            <br>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-12">
                                <label>{lang.doctor}</label>
                                <select class="form-control" name="doctor" id="doctor">
                                    <!-- BEGIN: doctor -->
                                    <option value="{doctor_value}">{doctor_name}</option>
                                    <!-- END: doctor -->
                                </select>
                            </div>
                            <div class="form-group col-md-12">
                                <label>{lang.note}</label>
                                <textarea class="form-control" id="ghichu" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="form-group text-center">
                            <input class="btn btn-info" type="submit" value="{lang.submit}">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="birth-modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

                <div class="form-group">
                    <label> Bác sĩ </label>
                    <select class="form-control" name="doctor" id="birth-doctor">
                        <!-- BEGIN: doctor2 -->
                        <option value="{doctor_value}">{doctor_name}</option>
                        <!-- END: doctor2 -->
                    </select>
                </div>

                <div class="form-group">
                    <label> Loại tái chủng </label>
                    <select class="form-control" name="disease" id="birth-disease">
                        <!-- BEGIN: disease -->
                        <option value="{id}">{name}</option>
                        <!-- END: disease -->
                    </select>
                </div>

                <div class="form-group">
                    <label> Tên thú cưng </label>
                    <input type="text" class="form-control" id="birth-petname">
                </div>

                <div class="form-group">
                    <label> Ngày tái chủng </label>
                    <input type="text" class="form-control date" id="birth-recall">
                </div>

                <div class="text-center">
                    <button class="btn btn-success" onclick="birthRecall()">
                        Thêm phiếu tiêm phòng
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="recall-modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

                <div class="form-group">
                    <label> Số lượng thai </label>
                    <input type="text" class="form-control date" id="recall-birth" value="1">
                </div>

                <div class="form-group">
                    <label> Ngày sinh </label>
                    <input type="text" class="form-control date" id="recall-recall">
                </div>

                <div class="text-center">
                    <button class="btn btn-success" onclick="recallSubmit()">
                        Lưu dữ liệu
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->