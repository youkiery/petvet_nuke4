<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/{module_file}/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/{module_file}/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
    src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div id="msgshow"></div>
<style>
    label { width: 100%; }
</style>

<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Nhóm </th>
        <th> Không quyền </th>
        <th> Quyền xem </th>
        <th> Quyền sửa, xóa </th>
    </tr>
    <!-- BEGIN: row -->
    <tr class="config-row" id="{id}">
        <td> {index} </td>
        <td> {group} </td>
        <td> <input type="radio" name="{id}" id="none_{id}" {none_check}> </td>
        <td> <input type="radio" name="{id}" id="view_{id}" {view_check}> </td>
        <td> <input type="radio" name="{id}" id="edit_{id}" {edit_check}> </td>
    </tr>
    <!-- END: row -->
</table>

<div class="form-group text-center">
    <button class="btn btn-info" onclick="save()">
        Lưu thay đổi
    </button>
</div>

<script>
    function save() {
        sdata = {}
        $(".config-row").each((index, item) => {
            id = item.getAttribute('id')
            value = 0
            if ($("#view_" + id).prop('checked')) {
                value = 1
            }
            else if ($("#edit_" + id).prop('checked')) {
                value = 2
            }
            sdata[id] = value
        })
        $.post(
            '',
            { action: 'save', data: sdata },
            (response, status) => {
                checkResult(response, status).then(data => {
                    window.location.reload()
                })
            }
        )
    }
</script>
<!-- END: main -->
