<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/core/js/script.js"></script>
<script src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/shim.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.full.min.js"></script>

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
    <div style="float: right">
        <button class="btn btn-info" onclick="excel(0)">
            Cập nhật Excel
        </button>
        <button class="btn btn-success" onclick="excel(1)">
            Thêm Excel
        </button>
    </div>
</div>


<div id="content">
    {content}
</div>
<!-- END: content -->

<script>
    var global = {
        mode: 0,
        item: [],
        filter_item: {
            page: 1,
            limit: 10,
        },
        selected: null
    }
    var input_dom_element = document.getElementById("file");
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
            try {
                var data = e.target.result;
                if (!rABS) data = new Uint8Array(data);
                var wb = XLSX.read(data, { type: rABS ? 'binary' : 'array' });
                var object = XLSX.utils.sheet_to_row_object_array(wb.Sheets[wb.SheetNames[0]])
                object = convertData(object)

                list = []
                if (global['mode']) {
                    // insert
                    object.forEach((item) => {
                        res = global['item'].indexOf(item['code'])
                        if (res < 0) list.push(item)
                    });
                }
                else {
                    // update
                    object.forEach((item) => {
                        res = global['item'].indexOf(item['code'])
                        if (res >= 0) list.push(item)
                    });
                }
                global['selected'] = list
                goPageItem(1)
                $("#excel-modal").modal('hide')
                $("#item-modal").modal('show')
            } catch (error) {
                console.log(error);
                $("#excel-error").text('Tệp tải lên không hợp lệ')
                $("#excel-error").show()
                $("#excel-error").fadeOut(3000)
            }
        };
        if (rABS) reader.readAsBinaryString(f); else reader.readAsArrayBuffer(f);
    }
    var handler = typeof IE_LoadFile !== 'undefined' ? handle_ie : handle_fr;
    if (input_dom_element.attachEvent) input_dom_element.attachEvent('onchange', handler);
    else input_dom_element.addEventListener('change', handler, false);

    function convertData(data) {
        list = []

        data.forEach(item => {
            list.push({
                code: item['Mã hàng'],
                category: item['Nhóm hàng(3 Cấp)'],
                name: item['Tên hàng'],
                number: item['Tồn kho']
            })
        });
        return list
    }

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
                    <td> <input type="text" class="form-control" id="row-name-`+ index + `" value="` + e['name'] + `">  </td>
                    <td> <input type="text" class="form-control" id="row-number-`+ index + `" value="` + e['number'] + `">  </td>
                    <td> <button class="btn btn-danger submit" onclick="removeIndex(`+ index + `)"> <span class="glyphicon glyphicon-remove"> </span> </button> </td>
                </tr> `
                index += 2
            }
            html = `
            <table class="table table-bordered">
                <tr>
                    <th>  </th>
                    <th> <input type="checkbox" id="row-check-all" selected> </th>
                    <th> Tên hàng </th>
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
                        installCheckAll('row')
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
            data.push(global['selected'][id])
        })

        if (!list.length) {
            alert_msg('Chọn 1 mục trước khi xác nhận')
        }
        else if (global['mode']) {
            $(".submit").prop('disabled', true)
            $.post(
                '',
                { action: 'insert-all', data: data, brand: $("#item-brand").val(), filter: global['filter_main'] },
                (response, status) => {
                    checkResult(response, status).then(data => {
                        global['selected'] = global['selected'].filter((item, index) => {
                            index = index.toString()
                            res = list.indexOf(index)
                            return res < 0
                        })
                        goPageItem(global['filter_item']['page'])
                        $("#content").html(data['html'])
                        installCheckAll('row')
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
                        installCheckAll('row')
                        $(".submit").prop('disabled', false)
                    }, () => {
                        $(".submit").prop('disabled', false)
                    })
                }
            )
        }
    }

    function excel(mode) {
        // 0: update, 1: insert
        global['mode'] = mode
        $(".excel-text").hide()
        if (mode) $("#text-insert").show()
        else $("#text-update").show()
        $("#excel-modal").modal('show')
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