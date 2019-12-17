<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/{module_file}/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div id="msgshow"></div>

{insert_modal}
{import_modal}
{remove_modal}

<div style="float: right">
    <button class="btn btn-success" onclick="bloodInsertModal()">
        Thêm Mẫu xét nghiệm
    </button>
    <button class="btn btn-success" onclick="importInsertModal()">
        Nhập hóa chất
    </button>
</div>

<div style="clear: both;"></div>

<label> <input type="checkbox" class="page-type" value="0" checked> Phiếu xét nghiệm </label>
<label> <input type="checkbox" class="page-type" value="1" checked> Phiếu nhập </label>

<div class="text-center form-group">
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
        limit: 10,
        today: '{today}',
        type: 0,
        id: 0
    }

    function bloodInsertModal() {
        $("#blood-insert-button").show()
        $("#blood-edit-button").hide()
        loadBloodDefault()
        $("#insert-modal").modal('show')
    }
    function importInsertModal() {
        $("#import-insert-button").show()
        $("#import-edit-button").hide()
        loadImportDefault()
        $("#import-modal").modal('show')
    }
    function edit(type, id) {
        $.post(
            '',
            { action: 'edit', id: id, type: type },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    if (type) {
                        $("#import-time").val(data['time'])
                        $("#import-number").val(data['number'])
                        $("#import-price").val(data['price'])
                        $("#import-note").val(data['note'])
                        $("#import-insert-button").hide()
                        $("#import-edit-button").show()
                        $("#import-modal").modal('show')
                    }
                    else {
                        $("#insert-time").val(data['time'])
                        $("#insert-number").val(data['number'])
                        $("#insert-start").val(data['start'])
                        $("#insert-end").val(data['end'])
                        $("#blood-insert-button").hide()
                        $("#blood-edit-button").show()
                        $("#insert-modal").modal('show')
                    }
                    $("#content").html(data['html'])
                })
            }
        )
    }

    function goPage(page) {
        global['page'] = page
        $.post(
            '',
            { action: 'filter', filter: checkFilter() },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    $("#content").html(data['html'])
                })
            }
        )
    }

    function checkFilter() {
        type = (() => {
            list = []
            $('.page-type:checked').each((index, item) => { list.push(item.value) })
            return list
        })()
        return {
            page: global['page'],
            limit: global['limit'],
            type: type
        }
    }

    function checkBloodData() {
        return {
            time: $("#insert-time").val(),
            number: $("#insert-number").val(),
            start: $("#insert-start").val(),
            end: $("#insert-end").val(),
            doctor: $("#insert-doctor").val()
        }
    }

    function loadBloodDefault() {
        $("#insert-time").val(global['today'])
        $("#insert-number").val(1)
    }

    function insertBlood() {
        insertData = checkBloodData()
        if (insertData['number'] <= 0) {
            alert_msg('Số lượng mẫu phải lớn hơn 0')
        }
        else if (insertData['start'] <= insertData['end']) {
            alert_msg('Số cuối phải nhỏ hơn số đầu')
        }
        else {
            $.post(
                '',
                { action: 'insert-blood', data: insertData, filter: checkFilter() },
                (reponse, status) => {
                    checkResult(reponse, status).then(data => {
                        $("#content").html(data['html'])
                        $("#insert-start").val(insertData['end'])
                        $("#insert-end").val(insertData['end'] - 1)
                        loadBloodDefault()
                        $("#insert-modal").modal('hide')
                    })
                }
            )
        }
    }

    function editBlood() {
        insertData = checkBloodData()
        if (insertData['number'] <= 0) {
            alert_msg('Số lượng mẫu phải lớn hơn 0')
        }
        else if (insertData['start'] <= insertData['end']) {
            alert_msg('Số cuối phải nhỏ hơn số đầu')
        }
        else {
            $.post(
                '',
                { action: 'edit-blood', data: insertData, filter: checkFilter() },
                (reponse, status) => {
                    checkResult(reponse, status).then(data => {
                        $("#content").html(data['html'])
                        $("#insert-start").val(insertData['end'])
                        $("#insert-end").val(insertData['end'] - 1)
                        loadBloodDefault()
                        $("#insert-modal").modal('hide')
                    })
                }
            )
        }
    }

    function checkImportData() {
        return {
            time: $("#import-time").val(),
            number: $("#import-number").val(),
            price: $("#import-price ").val(),
            note: $("#import-note").val()
        }
    }

    function loadImportDefault() {
        $("#import-time").val(global['today'])
        $("#import-number").val(0)
        $("#import-price").val(0)
        $("#import-note").val('')
    }

    function insertImport() {
        insertData = checkImportData()
        if (insertData['number'] <= 0) {
            alert_msg('Số lượng mẫu phải lớn hơn 0')
        }
        else {
            $.post(
                '',
                { action: 'insert-import', data: insertData, filter: checkFilter() },
                (reponse, status) => {
                    checkResult(reponse, status).then(data => {
                        $("#content").html(data['html'])
                        loadImportDefault()
                        $("#insert-start").val(data['number'])
                        $("#insert-end").val(data['number'] - 1)
                        $("#import-modal").modal('hide')
                    })
                }
            )
        }
    }

    function editImport() {
        insertData = checkImportData()
        if (insertData['number'] <= 0) {
            alert_msg('Số lượng mẫu phải lớn hơn 0')
        }
        else {
            $.post(
                '',
                { action: 'edit-import', data: insertData, filter: checkFilter() },
                (reponse, status) => {
                    checkResult(reponse, status).then(data => {
                        $("#content").html(data['html'])
                        loadImportDefault()
                        $("#insert-start").val(data['number'])
                        $("#insert-end").val(data['number'] - 1)
                        $("#import-modal").modal('hide')
                    })
                }
            )
        }
    }

    function remove(typeid, id) {
        global['type'] = typeid
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function removeSubmit() {
        $.post(
            '',
            { action: 'remove', type: global['type'], id: global['id'], filter: checkFilter() },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    $("#content").html(data['html'])
                    $("#remove-modal").modal('hide')
                })
            }
        )
    }
</script>
<!-- END: main -->