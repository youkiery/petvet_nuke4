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
    label {
        width: 100%;
    }
</style>

{modal}

<div style="float: right;">
    <button class="btn btn-success" onclick="$('#insert-modal').modal('show')">
        Thêm gợi ý
    </button>
</div>

<div style="clear: both;" class="form-group"></div>

<div class="text-center form-group">
    <label>
        <div class="row">
            <span class="col-sm-6">Nhóm</span>        
            <div class="col-sm-12">
                <select class="form-control" id="filter-name">
                    <option value="0"> Tất cả </option>
                    <!-- BEGIN: filter -->
                    <option value="{id}"> {name} </option>
                    <!-- END: filter -->
                </select>
            </div>
        </div>
    </label>
    <button class="btn btn-success" onclick="goPage(1)">
        Lọc danh sách
    </button>
</div>

<div id="content">
    {content}
</div>

<script>
    var global = {
        page: 1,
        id: 0
    }

    function checkFilter() {
        return {
            page: global['page'],
            limit: 10,
            name: $("#filter-name").val()
        }
    }

    function checkInsertData() {
        return {
            name: $("#insert-name").val(),
            value: $("#insert-value").val()
        }
    }

    function active(type, id) {
        $.post(
            '',
            { action: 'active', type: type, id: id, filter: checkFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                })
            }
        )
    }

    function goPage(page) {
        $.post(
            '',
            { action: 'filter', filter: checkFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                })
            }
        )
    }

    function insertRemind() {
        $.post(
            '',
            { action: 'insert-remind', filter: checkFilter(), data: checkInsertData() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#insert-modal").modal('hide')
                    $("#content").html(data['html'])
                })
            }
        )
    }

    function updateRemind(id) {
        $.post(
            '',
            { action: 'update-remind', id: id, value: $("#value-" + id).val() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    // $("#content").html(data['html'])
                })
            }
        )
    }

    function removeRemind(id) {
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function removeRemindSubmit() {
        $.post(
            '',
            { action: 'remove-remind', filter: checkFilter(), id: global['id'] },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#remove-modal").modal('hide')
                    $("#content").html(data['html'])
                })
            }
        )
    }
</script>
<!-- END: main -->