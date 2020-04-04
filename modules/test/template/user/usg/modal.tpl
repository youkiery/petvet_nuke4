<!-- BEGIN: main -->
<div id="update-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    Cập nhật phiếu siêu âm
                    <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
                </div>

                <div class="rows">
                    <div class="form-group col-4">
                        <label>{lang.usgcome}</label>
                        <input type="text" class="form-control date" id="usgtime">
                    </div>
                    <div class="form-group col-4">
                        <label>{lang.usgcall}</label>
                        <input type="text" class="form-control date" id="expecttime">
                    </div>
                    <div class="form-group col-4">
                        <label>{lang.exbirth}</label>
                        <input class="form-control" id="expectnumber2" type="number">
                    </div>
                </div>

                <div class="rows">
                    <div class="form-group col-4">
                        <label>{lang.birthday}</label>
                        <input type="text" class="form-control date" id="birthtime">
                    </div>
                    <div class="form-group col-4">
                        <label>{lang.birth}</label>
                        <input class="form-control" id="birthnumber" type="number">
                    </div>
                    <div class="form-group col-4">
                        <label> Ngày tái chủng </label>
                        <input class="form-control date" id="vaccinetime">
                    </div>
                </div>

                <div class="form-group">
                    <label> Bác sĩ </label>
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
                    <button class="btn btn-info" id="btn_usg_update" onclick="update_usg()">
                        {lang.submit}
                    </button>
                </div>
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
                        <div class="form-group col-md-6">
                            <label>{lang.petname}</label>
                            <select class="form-control" id="pet_info" style="text-transform: capitalize;"
                                name="petname"></select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>{lang.usgcome}</label>
                            <div class="input-group" data-provide="datepicker">
                                <input type="text" class="form-control date" id="ngaysieuam">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label>{lang.usgcall}</label>
                            <div class="input-group" data-provide="datepicker">
                                <input type="text" class="form-control date" id="calltime" value="{expecttime}">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label> Số con dự đoán </label>
                            <input type="text" class="form-control date" id="expectnumber" value="0">
                        </div>
                    </div>
                    <!-- <div class="form-group">
                            <label>{lang.image}</label>
                            <input class="form-control" type="text" name="hinhanh" id="hinhanh">
                            <br>
                        </div> -->
                    <div class="row">
                        <div class="form-group col-6">
                            <label>{lang.doctor}</label>
                            <select class="form-control" name="doctor" id="doctor">
                                <!-- BEGIN: doctor -->
                                <option value="{doctor_value}">{doctor_name}</option>
                                <!-- END: doctor -->
                            </select>
                        </div>
                        <div class="form-group col-6">
                            <label>{lang.note}</label>
                            <textarea class="form-control" id="ghichu" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <button class="btn btn-info" onclick="usgInsertSubmit()">
                            Thêm phiếu siêu âm
                        </button>
                    </div>
                </div>
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
                    <label> Ngày sinh </label>
                    <input type="text" class="form-control date" id="birth-time" value="{now}">
                </div>

                <div class="form-group">
                    <label> Số lượng con </label>
                    <input type="text" class="form-control" id="birth-number" value="0">
                </div>

                <div class="text-center">
                    <button class="btn btn-success" onclick="birthSubmit()">
                        Xác nhận đã sinh
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="vaccine-modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

                <div class="form-group">
                    <label> Ngày tái chủng </label>
                    <input type="text" class="form-control date" id="vaccine-time">
                </div>

                <div class="form-group">
                    <label> Loại tái chủng </label>
                    <select class="form-control" id="vaccine-disease">
                        <!-- BEGIN: disease -->
                        <option value="{id}">{name}</option>
                        <!-- END: disease -->
                    </select>
                </div>

                <div class="form-group">
                    <label> Bác sĩ </label>
                    <select class="form-control" id="vaccine-doctor">
                        <!-- BEGIN: doctor2 -->
                        <option value="{doctor_value}">{doctor_name}</option>
                        <!-- END: doctor2 -->
                    </select>
                </div>

                <div class="text-center">
                    <button class="btn btn-success" onclick="vaccineSubmit()">
                        Thêm phiếu vaccine
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="reject-modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

                <div class="text-center">
                    <p> Sau khi "bỏ vaccine", phiếu sẽ đưa vào mục hoàn thành, xác nhận? </p>
                    <button class="btn btn-danger" onclick="rejectSubmit()">
                        Bỏ vaccine
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->