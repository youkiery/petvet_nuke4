<!-- BEGIN: main -->
<div class="modal" id="category-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Danh mục hàng hóa </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <input class="form-control" type="text" id="category-name" placeholder="Nhập tên danh mục">
                        <div class="input-group-btn">
                            <button class="btn btn-success" onclick="categoryInsertSubmit()">
                                Thêm
                            </button>
                        </div>
                    </div>
                </div>

                <div id="category-content">
                    {category_content}
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="item-modal" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Thêm hàng hóa hàng hóa </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="form-group">
                    Mã hàng
                    <input type="text" class="form-control" id="item-code">
                </div>

                <div class="form-group">
                    Tên hàng
                    <div class="relative">
                        <input type="text" class="form-control" id="item-name">
                        <div class="suggest" id="item-name-suggest"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label>
                        Danh mục
                        <select class="form-control" id="item-category">
                            {category_option}
                        </select>
                    </label>
                </div>

                <div class="form-group" id="item-content"> </div>
                <div class="form-group">
                    <button class="btn btn-success" onclick="addItem()">
                        <span class="glyphicon glyphicon-plus"></span>
                    </button>
                </div>

                <div class="text-center">
                    <button class="btn btn-success" id="item-insert-btn" onclick="itemInsertSubmit()">
                        Thêm hàng hóa
                    </button>
                    <button class="btn btn-info" id="item-edit-btn" onclick="itemEditSubmit()">
                        Chỉnh sửa thông tin
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="remove-modal" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b> Xóa hàng hóa </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="text-center">
                    <p> Sau khi xác nhận, mặt hàng sẽ mất vĩnh viễn, bạn có chắc chắn không? </p>
                    <button class="btn btn-danger" onclick="itemRemoveSubmit()">
                        Xác nhận xóa
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- END: main -->