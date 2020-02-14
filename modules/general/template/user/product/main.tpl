<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">
<link rel="stylesheet" href="/modules/core/css/bootstrap-glyphicons.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/core/js/script.js"></script>
<script src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<!-- BEGIN: brand -->
<!-- BEGIN: box -->
<a class="selectable-box" style="width: 100px; height: 100px; text-align: center; vertical-align: inherit;"
    href="/{module_name}/product/?brand={brand_id}">
    {brand_name}
</a>
<!-- END: box -->
<div class="selectable-box" onclick="newBrand()">
    Thêm chi nhánh mới
</div>
<!-- END: brand -->

<!-- BEGIN: content -->
{modal}

<div class="form-group row">
    <div class="col-sm-12">
        <select class="form-control" id="main-brand">
            <!-- BEGIN: main_brand -->
            <option value="{brand_id}">
                {brand_name}
            </option>
            <!-- END: main_brand -->
        </select>
    </div>
    <div class="col-sm-12">
        <select class="form-control" id="sub-brand">
            <!-- BEGIN: sub_brand -->
            <option value="{brand_id}">
                {brand_name}
            </option>
            <!-- END: sub_brand -->
        </select>
    </div>
</div>
<div class="text-center form-group">
    <button class="btn btn-info">
        Lọc danh sách hàng hết
    </button>
</div>

<div class="form-group">
    <button class="btn btn-info">
        Danh sách hàng hóa
    </button>
    <button class="btn btn-info">
        Danh sách loại hàng
    </button>
</div>

<div id="content">
    {content}
</div>
<!-- END: content -->

<script></script>
<!-- END: main -->