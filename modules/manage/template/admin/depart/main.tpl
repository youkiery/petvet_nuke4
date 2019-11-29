<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
    src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script src="/modules/manage/src/script.js"></script>

{remove_modal}
{remove_all_modal}

<div id="msgshow"></div>

<div class="form-group input-group">
    <input type="text" class="form-control" id="insert-name" placeholder="Nhập tên phòng ban...">
    <div class="input-group-btn">
        <button class="btn btn-success" onclick="departInsert()">
            Thêm phòng ban
        </button>
    </div>
</div>

<div id="content">
    {content}
</div>
<button class="btn btn-danger" onclick="departRemoveAll()">
    Xóa các mục đã chọn
</button>
<script>
    var global = {
        id: 0
    }

    $(document).ready(() => {
        installCheckAll('depart')
    })

    function departInsert() {
        $.post(
            '',
            { action: 'insert-depart', name: $("#insert-name").val() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#insert-name").val('')
                    $("#content").html(data['html'])
                })
            }
        )
    }

    function checkDepartData() {
        return { name: $("#insert") }
    }

    function departEdit(id) {
        $.post(
            '',
            { action: 'edit-depart', id: id, name: $("#depart-name-" + id).val() },
            (response, status) => {
                checkResult(response, status).then(data => {
                })
            }
        )
    }

    function departRemove(id) {
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function departRemoveAll() {
        if (!$(".depart-checkbox:checked").length) {
            alert_msg('Chọn 1 mục để xóa')
        }
        else {
            $("#remove-all-modal").modal('show')
        }
    }

    function removeSubmit() {
        $.post(
            '',
            { action: 'remove-depart', id: global['id'] },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                    $("#remove-modal").modal('hide')
                })
            }
        )
    }

    function removeAllSubmit() {
        list = []
        $(".depart-checkbox:checked").each((index, item) => {
            list.push(item.getAttribute('index'))
        })
        $.post(
            '',
            { action: 'remove-all-depart', list: list },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                    $("#remove-all-modal").modal('hide')
                })
            }
        )
    }

    function installCheckAll(name) {
        $("#" + name + "-check-all").change((e) => {
            checked = e.currentTarget.checked
            $("." + name + "-checkbox").each((index, item) => {
                item.checked = checked
            })
        })
    }

</script>
<!-- END: main -->