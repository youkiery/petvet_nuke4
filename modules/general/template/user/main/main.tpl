<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
    src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/shim.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.full.min.js"></script>

<div id="msgshow"></div>

{filter_modal}
{remove_modal}
{lowitem_modal}
{excel_modal}
{category_modal}
{item_modal}

<div class="form-group" style="float: left">
    <button class="btn btn-info" onclick="lowitem()">
        Danh sách hàng hết
    </button>
    <button class="btn btn-info" onclick="filter()">
        Lọc danh sách
    </button>
</div>

<div class="form-group" style="float: right">
    <button class="btn btn-info" onclick="excel(0)">
        Cập nhật Excel
    </button>
    <button class="btn btn-success" onclick="excel(1)">
        Thêm Excel
    </button>
</div>

<div style="clear: both;"> </div>

<div class="form-group">
    <button class="btn btn-danger submit" style="position: sticky; top: 10px; left: 10px;" onclick="removeAll()">
        Xóa mục chọn
    </button>
</div>

<div id="content">
    {content}
</div>

<script>
    var global = {
        id: 0,
        filter_low: {
            limit: 10,
            keyword: '',
            category: []
        },
        filter_main: {
            page: 1,
            limit: 10,
            keyword: '',
            category: []
        },
        filter_item: {
            page: 1,
            limit: 10,
        },
        item: JSON.parse('{item}'),
        mode: 0,
        selected: null,
    }
    var input_dom_element = document.getElementById("file");

    $(document).ready(() => {
        installCheckAll('filter')
        installCheckAll('item')
        installCheckAll('lowitem')
    })

    function handle_ie() {
        var path = input_dom_element.value;
        var data = IE_LoadFile(path);
        var wb = XLSX.read(data, { type: 'binary' });
    }

    function handle_fr(e) {
        var files = e.target.files, f = files[0];
        var reader = new FileReader();
        var rABS = !!reader.readAsBinaryString;
        input_dom_element.value = null
        reader.onload = function (e) {
            var data = e.target.result;
            if (!rABS) data = new Uint8Array(data);
            var wb = XLSX.read(data, { type: rABS ? 'binary' : 'array' });
            var object = XLSX.utils.sheet_to_row_object_array(wb.Sheets[wb.SheetNames[0]])

            list = []
            if (global['mode']) {
                // insert
                object.forEach((item) => {
                    code = item['Mã hàng'].toString()
                    res = global['item'].indexOf(code)
                    if (res < 0) list.push(item)
                });
            }
            else {
                // update
                object.forEach((item) => {
                    code = item['Mã hàng'].toString()
                    res = global['item'].indexOf(code)
                    if (res >= 0) list.push(item)
                });
            }
            global['selected'] = list
            goPageItem(1)
            $("#excel-modal").modal('hide')
            $("#item-modal").modal('show')
        };
        if (rABS) reader.readAsBinaryString(f); else reader.readAsArrayBuffer(f);
    }
    var handler = typeof IE_LoadFile !== 'undefined' ? handle_ie : handle_fr;
    if (input_dom_element.attachEvent) input_dom_element.attachEvent('onchange', handler);
    else input_dom_element.addEventListener('change', handler, false);

    function lowitem() {
        $("#lowitem-modal").modal('show')
    }

    function filter() {
        $("#filter-modal").modal('show')
    }

    function excel(mode) {
        // 0: update, 1: insert
        global['mode'] = mode
        $(".excel-text").hide()
        if (mode) $("#text-insert").show()
        else $("#text-update").show()
        $("#excel-modal").modal('show')
    }

    // function tick(e) {
    //     selectFile = e.target.files[0]
    //     js.parseExcel(selectFile)
    // }

    function goPageItem(page) {
        global['filter_item']['page'] = page
        global['filter_item']['limit'] = $("#item-filter").val()

        length = global['selected'].length
        start = global['filter_item']['limit'] * (global['filter_item']['page'] - 1)
        limit = global['filter_item']['limit'] * global['filter_item']['page']
        limit = (length < limit) ? length : limit
        page = Math.floor(length / global['filter_item']['limit']) + ((length % global['filter_item']['limit']) ? 1 : 0)

        if (!(length % global['filter_item']['limit']) && !(limit - start) && global['filter_item']['page'] > 1) {
            goPageItem(global['filter_item']['page'] - 1)
        }
        else {
            html = ''
            nav = ''
            index = start + 1

            for (i = 1; i <= page; i++) {
                if (i == global['filter_item']['page']) nav += '<button class="btn">' + i + '</button>'
                else nav += '<button class="btn btn-info submit" onclick="goPageItem(' + i + ')">' + i + '</button>'
            }

            for (i = start; i < limit; i++) {
                e = global['selected'][i];
                html += `
                <tr>
                    <td> `+ index + ` </td>
                    <td> <input type="checkbox" class="row-checkbox" index="`+ (--index) + `" selected> </td>
                    <td> `+ e['Mã hàng'] + ` </td>
                    <td> `+ e['Nhóm hàng(3 Cấp)'] + ` </td>
                    <td> <input type="text" class="form-control" id="row-number-`+ index + `" value="` + e['Tồn kho'] + `">  </td>
                    <td> <button class="btn btn-danger submit" onclick="removeIndex(`+ index + `)"> <span class="glyphicon glyphicon-remove"> </span> </button> </td>
                </tr> `
                index += 2
            }
            html = `
            <table class="table table-bordered">
                <tr>
                    <th> STT </th>
                    <th> <input type="checkbox" id="row-check-all" selected> </th>
                    <th> Mã hàng </th>
                    <th> Loại hàng </th>
                    <th> Số lượng </th>
                    <th>  </th>
                </tr>
                `+ html + `
            </table>
            <div class="form-group">
                `+ nav + `
            </div>
            `
            $("#item-content").html(html)
            installCheckAll('row')
        }
    }

    function removeIndex(i) {
        global['selected'] = global['selected'].filter((item, index) => {
            return index !== i
        })
        goPageItem(global['filter_item']['page'])
    }

    function removeAll() {
        list = []
        $(".item-checkbox:checked").each((index, item) => {
            list.push(item.getAttribute('index'))
        })
        if (!list.length) alert_msg('Chọn 1 mục trước khi xóa')
        else {
            $.post(
                '',
                { action: 'remove-all-item', list: list, filter: global['filter_main'] },
                (response, status) => {
                    checkResult(response, status).then(data => {
                        $("#content").html(data['html'])
                        installCheckAll('item')
                    }, () => { })
                }
            )
        }
    }

    function removeAllItem() {
        list = []
        $(".item-checkbox:checked").each((index, item) => {
            list.push(item.getAttribute('index'))
        })

        if (!list.length) {
            alert_msg('Chọn 1 mục trước khi xóa')
        }
        else {
            global['selected'] = global['selected'].filter((item, index) => {
                index = index.toString()
                res = list.indexOf(index)
                return res < 0
            })
            goPageItem(global['filter_item']['page'])
        }

    }

    function submitAll() {
        list = []
        data = []
        $(".row-checkbox:checked").each((index, item) => {
            id = item.getAttribute('index')
            list.push(id)
            temp = global['selected'][id]
            console.log(temp, id);
            data.push({
                code: temp['Mã hàng'],
                name: temp['Tên hàng hóa'],
                number: temp['Tồn kho'],
                category: temp['Nhóm hàng(3 Cấp)']
            })
        })

        if (!list.length) {
            alert_msg('Chọn 1 mục trước khi xác nhận')
        }
        else if (global['mode']) {
            $(".submit").prop('disabled', true)
            $.post(
                '',
                { action: 'insert-all', data: data, filter: global['filter_main'] },
                (response, status) => {
                    checkResult(response, status).then(data => {
                        global['selected'] = global['selected'].filter((item, index) => {
                            index = index.toString()
                            res = list.indexOf(index)
                            return res < 0
                        })
                        goPageItem(global['filter_item']['page'])
                        $("#content").html(data['html'])
                        installCheckAll('item')
                        $(".submit").prop('disabled', false)
                    }, () => {
                        $(".submit").prop('disabled', false)
                    })
                }
            )
        }
        else {
            $(".submit").prop('disabled', true)
            $.post(
                '',
                { action: 'update-all', data: data, filter: global['filter_main'] },
                (response, status) => {
                    checkResult(response, status).then(data => {
                        global['selected'] = global['selected'].filter((item, index) => {
                            index = index.toString()
                            res = list.indexOf(index)
                            return res < 0
                        })
                        goPageItem(global['filter_item']['page'])
                        $("#content").html(data['html'])
                        installCheckAll('item')
                        $(".submit").prop('disabled', false)
                    }, () => {
                        $(".submit").prop('disabled', false)
                    })
                }
            )
        }
    }

    function installCheckAll(name) {
        $("#" + name + "-check-all").change((e) => {
            checked = e.currentTarget.checked
            $("." + name + "-checkbox").each((index, item) => {
                item.checked = checked
            })
        })
    }

    function lowitemFilter() {
        var filter = {
            limit: $("#lowitem-filter").val()
        }

        $.post(
            '',
            { action: 'lowitem-filter', filter: filter },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#lowitem-content").html(data['html'])
                })
            }
        )
    }

    function filterLowitem() {
        list = []
        $(".lowitem-checkbox:checked").each((index, item) => {
            list.push(item.getAttribute('index'))
        })
        global['filter_low']['category'] = list
        global['filter_low']['limit'] = $("#lowitem-limit").val()
        global['filter_low']['keyword'] = $("#lowitem-keyword").val()
        
        $.post(
            '',
            { action: 'filter-low', filter: global['filter_low'] },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#lowitem-content").html(data['html'])
                })
            }
        )
    }

    function goPage(page) {
        list = []
        $(".lowitem-checkbox:checked").each((index, item) => {
            list.push(item.getAttribute('index'))
        })
        global['filter_main']['category'] = list
        global['filter_main']['page'] = page
        global['filter_main']['limit'] = $("#filter-limit").val()
        global['filter_main']['keyword'] = $("#filter-keyword").val()
        $.post(
            '',
            { action: 'filter', filter: global['filter_main'] },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#filter-modal").modal('hide')
                    $("#content").html(data['html'])
                    installCheckAll('item')
                })
            }
        )
    }

    function checkItemData(id) {
        return {
            name: $("#item-name-" + id).val(),
            number: $("#item-number-" + id).val(),
            bound: $("#item-bound-" + id).val(),
        }
    }

    function updateItem(id) {
        $.post(
            '',
            { action: 'update-item', data: checkItemData(id), id: id, filter: global['filter_main'] },
            (response, status) => {
                checkResult(response, status).then(data => {
                    // do nothing
                })
            }
        )
    }

    function removeItem(id) {
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function removeItemSubmit() {
        $.post(
            '',
            { action: 'remove-item', id: global['id'], filter: global['filter_main'] },
            (response, status) => {
                checkResult(response, status).then(data => {
                    $("#content").html(data['html'])
                    installCheckAll('item')
                    $("#remove-modal").modal('hide')
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