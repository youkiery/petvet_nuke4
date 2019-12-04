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

{excel_modal}
{category_modal}
{item_modal}

<div class="form-group" style="float: right">
    <button class="btn btn-info" onclick="excel(0)">
        Cập nhật Excel
    </button>
    <button class="btn btn-success" onclick="excel(1)">
        Thêm Excel
    </button>
</div>

<div id="content">
    {content}
</div>

<script>
    var global = {
        page: 1,
        limit: 10,
        item: JSON.parse('{item}'),
        mode: 0,
        selected: null,
    }
    var input_dom_element = document.getElementById("file");

    function handle_ie() {
        var path = input_dom_element.value;
        var data = IE_LoadFile(path);
        var wb = XLSX.read(data, { type: 'binary' });
        process_wb(wb);
    }

    function handle_fr(e) {
        var files = e.target.files, f = files[0];
        var reader = new FileReader();
        var rABS = !!reader.readAsBinaryString;
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
            goPage(1)
            $("#excel-modal").modal('hide')
            $("#item-modal").modal('show')
        };
        if (rABS) reader.readAsBinaryString(f); else reader.readAsArrayBuffer(f);
    }
    var handler = typeof IE_LoadFile !== 'undefined' ? handle_ie : handle_fr;
    if (input_dom_element.attachEvent) input_dom_element.attachEvent('onchange', handler);
    else input_dom_element.addEventListener('change', handler, false);

    // var ExcelToJSON = function () {
    //     this.parseExcel = function (file) {
    //         var reader = new FileReader()
    //         reader.onload = function (e) {
    //             var data = e.target.result
    //             document.getElementById('file').value = null

    //             var workbook = XLSX.read(data, {
    //                 type: 'binary'
    //             })
    //             var object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[workbook.SheetNames[0]])
    //             list = []
    //             if (global['mode']) {
    //                 // insert
    //                 object.forEach((item) => {
    //                     code = item['Mã hàng'].toString()
    //                     if (code.indexOf(global['item']) < 0) list.push(item)
    //                 });
    //             }
    //             else {
    //                 // update
    //                 object.forEach((item) => {
    //                     code = item['Mã hàng'].toString()
    //                     if (code.indexOf(global['item']) >= 0) list.push(item)
    //                 });
    //             }
    //             global['selected'] = list
    //             goPage(1)
    //             $("#excel-modal").modal('hide')
    //             $("#item-modal").modal('show')
    //         }
    //         // reader.onerror = function (ex) { console.log(ex) }
    //         if (file) reader.readAsBinaryString(file)
    //     }
    // }
    // js = new ExcelToJSON()

    function excel(mode) {
        // 0: update, 1: insert
        global['mode'] = mode
        $(".excel-text").hide()
        if (mode) $(".excel-insert").show()
        else $(".excel-update").show()
        $("#excel-modal").modal('show')
    }

    // function tick(e) {
    //     selectFile = e.target.files[0]
    //     js.parseExcel(selectFile)
    // }

    function goPage(page) {
        global['page'] = page
        length = global['selected'].length
        // check limit
        limit = length

        html = ''
        index = 1

        for (i = 0; i < limit; i++) {
            e = global['selected'][i];
            html += `
                <tr>
                    <td> `+ index + ` </td>
                    <td> <input type="checkbox" class="item-checkbox" index="`+ index + `" selected> </td>
                    <td> `+ e['Mã hàng'] + ` </td>
                    <td> `+ e['Nhóm hàng(3 Cấp)'] + ` </td>
                    <td> <input type="text" class="form-control" id="item-number-`+ index + `" value="` + e['Tồn kho'] + `">  </td>
                    <td> <button class="btn btn-danger" onclick="removeIndex(`+ (--index) + `)"> <span class="glyphicon glyphicon-remove"> </span> </button> </td>
                </tr> `
            index+= 2
        }
        html = `
            <table class="table table-bordered">
                <tr>
                    <th> STT </th>
                    <th> <input type="checkbox" id="item-check-all" selected> </th>
                    <th> Mã hàng </th>
                    <th> Loại hàng </th>
                    <th> Số lượng </th>
                    <th>  </th>
                </tr>
                `+ html + `
            <table>`
        $("#item-content").html(html)
        installCheckAll('item')
    }

    function removeIndex(i) {
        global['selected'] = global['selected'].filter((item, index) => {
            return index !== i
        })
        goPage(global['page'])
    }

    function removeAll() {
        list = []
        $(".item-checkbox:checked").each((index, item) => {
            list.push(item.getAttribute('index'))
        })
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