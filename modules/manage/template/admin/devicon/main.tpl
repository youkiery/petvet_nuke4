<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<script src="/modules/manage/src/script.js"></script>

<div id="msgshow"></div>
{remove_modal}
{member_modal}
{member_edit_modal}
{member_remove_modal}

<div class="form-group">
    <button class="btn btn-info" onclick="insertMember()">
        Thêm nhân viên mới
    </button>
</div>

<div id="content">
    {content}
</div>

<script>
    var global = {
        id: 0,
        memberpage: 1,
        page: 1,
        level: [
            'Không có phận sự',
            'Nhân viên chỉ nhìn',
            'Được phép chỉnh sửa',
            'Toàn quyền'
        ]
    }

    function removeMember(id) {
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function removeSubmit() {
        $.post(
            '',
            { action: 'remove-member', id: global['id'], filter: checkFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                    $("#remove-modal").modal('hide')
                })
            }
        )
    }

    function editMember(id) {
        global['id'] = id
        $.post(
            '',
            { action: 'get-member', id: id },
            (response, status) => {
                checkResult(response, status).then(data => {
                    html = ''
                    global['level'].forEach((item, index) => {
                        checked = ''
                        if (data['member']['level'] == index) checked = 'selected'
                        html += `
                            <option value="`+index+`" `+ checked +`>
                                `+ item +`
                            </option>`
                    })
                    $("#member-level").html(html)
                    $("[name=member-depart]").prop('checked', false)
                    data['member']['depart'].forEach(item => {
                        $(".member-depart-" + item).prop('checked', true)
                    })
                    $("#member-edit-modal").modal('show')
                })
            }
        )
    }

    function checkFilter() {
        return {
            page: global['page'],
            limit: 10
        }
    }

    function checkEditData() {
        depart = []
        $("[name='member-depart']:checked").each((index, item) => {
            depart.push(item.value)
        })
        return {
            level: $("#member-level").val(),
            depart: depart
        }
    }

    function editMemberSubmit() {
        $.post(
            '',
            { action: 'edit-member', id: global['id'], data: checkEditData(), filter: checkFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                    $("#member-edit-modal").modal('hide')
                })
            }
        )
    }

    function insertMemberSubmit(id) {
        $.post(
            '',
            { action: 'insert-member', id: id, filter: checkFilter(), memfilter: checkMemberFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#member-content").html(data['html'])
                    $("#content").html(data['html2'])
                })
            }
        )
    }

    function goMemPage(page) {
        global['memberpage'] = page
        $.post(
            '',
            { action: 'member-filter', memfilter: checkMemberFilter() },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#member-content").html(data['html'])
                })
            }
        )
    }

    function goPage(page) {
        global['page'] = page
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

    function insertMember() {
        $("#member-modal").modal('show')
    }

    function checkMemberFilter() {
        return {
            page: global['memberpage'],
            limit: 10,
            keyword: $("#member-keyword").val()
        }
    }
</script>
<!-- END: main -->
