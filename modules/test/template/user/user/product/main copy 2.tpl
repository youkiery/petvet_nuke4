<!-- BEGIN: main -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css">

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
<div id="content">
    <div class="row">
        <div class="col-sm-12" style="text-align: center; position: relative;">
            <div style="margin: auto;">
                <label class="filebutton">
                    <div
                        style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                        +
                    </div>
    
                    <span>
                        <input type="file" id="file" style="display: none;"
                            accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                    </span>
                </label>
                <br>
                File excel bệnh viện
            </div>
        </div>
        <div class="col-sm-12" style="text-align: center; position: relative;">
            <div style="margin: auto;">
                <label class="filebutton">
                    <div
                        style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                        +
                    </div>
    
                    <span>
                        <input type="file" id="file2" style="display: none;"
                            accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                    </span>
                </label>
                <br>
                File excel kho hàng
            </div>
        </div>
    </div>
    
    
    <div class="text-center">
        <button class="btn btn-info" onclick="process()">
            Lưu dữ liệu
        </button>
    </div>
</div>

<div id="filter" style="display: none;">
    <div class="form-group row">
        <div class="col-sm-6">
            <input type="text" class="form-control" id="filter-keyword" placeholder="Từ khóa...">
        </div>
        <div class="col-sm-12">
            <select class="form-control" id="filter-category"> </select>
        </div>
    </div>
    <div class="form-group row">
        <div class="col-sm-6">
            Bệnh viện
        </div>
        <div class="col-sm-6">
            <select class="form-control" id="filter-number-op">
                <option value="0"> &lt; </option>
                <option value="1"> &lt;= </option>
                <option value="2"> &gt; </option>
                <option value="3"> &gt;= </option>
            </select>
        </div>
        <div class="col-sm-6">
            <input type="text" class="form-control" id="filter-number" value="10" placeholder="Bệnh viện">
        </div>
    </div>
    <div class="form-group row">
        <div class="col-sm-6">
            Kho hàng
        </div>
        <div class="col-sm-6">
            <select class="form-control" id="filter-number-op2">
                <option value="2"> &gt; </option>
                <option value="3"> &gt;= </option>
                <option value="0"> &lt; </option>
                <option value="1"> &lt;= </option>
            </select>
        </div>
        <div class="col-sm-6">
            <input type="text" class="form-control" id="filter-number2" value="0" placeholder="Kho hàng">
        </div>
    </div>
    <div class="form-group row">
        <div class="col-sm-6">
            Tổng số lượng
        </div>
        <div class="col-sm-6">
            <select class="form-control" id="filter-number-op3">
                <option value="2"> &gt; </option>
                <option value="3"> &gt;= </option>
                <option value="0"> &lt; </option>
                <option value="1"> &lt;= </option>
            </select>
        </div>
        <div class="col-sm-6">
            <input type="text" class="form-control" id="filter-number3" value="0" placeholder="Kho hàng">
        </div>
    </div>
    <div class="form-group text-center">
        <button class="btn btn-info" onclick="goPage(1, 1)">
            Lọc danh sách
        </button>
        <button class="btn btn-info" onclick="listModal()">
            Xem danh sách đã chọn
        </button>
    </div>

    <div id="filter-content">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th> STT </th>
                    <th> Mã hàng </th>
                    <th> Tên hàng </th>
                    <th> Loại hàng </th>
                    <th> Bệnh viện </th>
                    <th> Kho hàng </th>
                </tr>
            </thead>
            <tbody id="filter-body">

            </tbody>
        </table>
        <div id="filter-nav"></div>
    </div>
</div>
<!-- END: content -->
<div class="text-center" id="notice" style="font-size: 2em; color: red; "></div>
<div id="notice-archo"></div>

<script>
    var global = {
        page: 1,
        limit: 50,
        list: [],
        mode: 0,
        item: [],
        data: {},
        filter_item: {
            page: 1,
            limit: 10,
        },
        selected: [],
        process: 0,
        allow: ['SHOP>>Đồ chơi', 'SHOP>>Đồ chơi - vật dụng', 'SHOP>>Vòng-cổ-khớp', 'SHOP>>Xích-dắt-yếm']
        // allow: ['SHOP', 'SHOP>>Balo, giỏ xách', 'SHOP>>Bình xịt', 'SHOP>>Cát vệ sinh', 'SHOP>>Dầu tắm', 'SHOP>>Đồ chơi', 'SHOP>>Đồ chơi - vật dụng', 'SHOP>>Giỏ-nệm-ổ', 'SHOP>>Khay vệ sinh', 'SHOP>>Nhà, chuồng', 'SHOP>>Thuốc bán', 'SHOP>>Thuốc bán>>thuốc sát trung', 'SHOP>>Tô - chén', 'SHOP>>Vòng-cổ-khớp', 'SHOP>>Xích-dắt-yếm']
    }
    var file = $("#file")
    var file2 = $("#file2")
    var textFile = null,
    makeTextFile = function (text) {
       var data = new Blob([text], {type: 'text/plain'});

       // If we are replacing a previously generated file we need to
       // manually revoke the object URL to avoid memory leaks.
       if (textFile !== null) {
         window.URL.revokeObjectURL(textFile);
       }

       textFile = window.URL.createObjectURL(data);
        var a = document.createElement("a");
        a.href = textFile;
        a.download = 'danh sách hàng hóa.html';
        a.click();
    };

    file.change((e) => {
        global['selected'][0] = e
    })
    file2.change((e) => {
        global['selected'][1] = e
    })

    function process() {
        $("#notice").text('Đang xử lý')
        if (!global['selected'][0]) notify('Chọn bệnh viện trước') // Chọn excel bệnh viện;
        else if (!global['selected'][1]) notify('Chọn kho hàng trước') // Chọn excel kho hàng;
        else {
            var files = [
                global['selected'][0].target.files[0],
                global['selected'][1].target.files[0]
            ]
            // file.val('')
            // file2.val('')
            // global['selected'][0] = null
            // global['selected'][1] = null
            global['process'] = 0
            processExcel(files[0], 0)
            processExcel(files[1], 1)
        }
    }

    function processExcel(fileData, index) {
        var reader = new FileReader();
        var rABS = !!reader.readAsBinaryString;
        reader.onload = (e) => {
            try {
                var data = e.target.result;
                if (!rABS) data = new Uint8Array(data);
                var wb = XLSX.read(data, { type: rABS ? 'binary' : 'array' });
                var object = XLSX.utils.sheet_to_row_object_array(wb.Sheets[wb.SheetNames[0]])
                object.forEach((item, index) => {
                    if (global['allow'].indexOf(item['Nhóm hàng(3 Cấp)']) >= 0) {
                        if (global['data'][item['Mã hàng']]) global['data'][item['Mã hàng']]['number2'] = item['Tồn kho']
                        else global['data'][item['Mã hàng']] = {
                            category: item['Nhóm hàng(3 Cấp)'],
                            name: item['Tên hàng'],
                            number: item['Tồn kho'],
                            image: item['Hình ảnh (url1,url2...)']
                        }
                    }
                })
                global['process']++
                if (global['process'] == 2) {
                    // Hoàn thành 2 cái
                    // tìm cách sử dụng data
                    console.log('OK');
                    submitAll()
                }
            } catch (error) {
                notify('Có lỗi xảy ra')
            }
        };
        if (rABS) reader.readAsBinaryString(fileData);
        else reader.readAsArrayBuffer(fileData);
    }

    function submitAll() {
        notify('Đã lưu')
        // ẩn mục chọn dữ liệu
        $("#content").hide()
        // hiển thị lọc danh sách
        $("#filter").show()
        // đưa danh sách loại hàng vào mục chọn
        html = '<option value="-1">Tất cả loại hàng</option>'
        global.allow.forEach((item, index) => {
            html += '<option value="'+ index +'"> '+ item +' </option>'
        })
        $("#filter-category").html(html)
        goPage(1)
        // danh sách cho phép đưa các mục vào danh sách
        // chuyển danh sách thành bảng gồm hình ảnh, chữ viết
    }

    function parseOpera(op, number, total) {
        result = false
        opx = ''
        switch (op) {
            case 0:
                result = number < total
                opx = '<'
                break;
            case 1:
                result =  number <= total
                opx = '<='
                break;
            case 2:
                result =  number > total
                opx = '>'
                break;
            case 3:
                result =  number >= total
                opx = '>='
                break;
        }
        return result
    }

    function goPage(page, reset = 0) {
        if (reset) global['list'] = {}
        global['page'] = page
        html = ''
        nav = ''
        category = $("#filter-category").val()
        op = Number($("#filter-number-op").val())
        op2 = Number($("#filter-number-op2").val())
        op3 = Number($("#filter-number-op3").val())
        number = Number($("#filter-number").val())
        number2 = Number($("#filter-number2").val())
        number3 = Number($("#filter-number3").val())

        list = []
        for (const key in global['data']) {
            if (global['data'].hasOwnProperty(key)) {
                const item = global['data'][key];
                
                if ((category < 0 || global['allow'][category] == item['category']) && parseOpera(op, item['number'], number) && parseOpera(op2, item['number2'], number2) && parseOpera(op3, item['number'] + item['number2'], number3)) {
                    list.push({
                        code: key,
                        data: item
                    })
                }
            }
        }

        from = (page - 1) * global['limit']
        end = page * global['limit'] - 1
        length = list.length 
        page_number = Math.floor(length / global['limit']) + (length % global['limit'] ? 1 : 0)

        for (let i = 1; i <= page_number; i++) {
            if (i == global['page']) 
            nav += `
                <button class="btn btn-sm" onclick="goPage(`+ i +`)">
                    `+ i +`
                </button>
            `
            else nav += `
                <button class="btn btn-info btn-sm" onclick="goPage(`+ i +`)">
                    `+ i +`
                </button>
            `
        }
        
        for (let i = from; i <= end; i++) {
            const item = list[i];
            if (item) {
                type = 'btn-info'
                if (global['list'][i]) type = 'btn-warning'
                html += `
                    <tr>
                        <td> `+ (i + 1) +` </td>
                        <td> `+ (item['code']) +` </td>
                        <td> `+ (item['data']['name']) +` </td>
                        <td> `+ (item['data']['category']) +` </td>
                        <td> `+ (item['data']['number']) +` </td>
                        <td> `+ (item['data']['number2']) +` </td>
                        <td> 
                            <button class="btn `+ type +` btn-sm" onclick="addItem('`+ item['code'] +`', `+ i +`)">
                                Thêm danh sách
                            </button>
                        </td>
                    </tr>
                `
            }
        }
        $("#filter-body").html(html)
        $("#filter-nav").html(nav)
    }

    function addItem(code, index) {
        if (global['list'][index]) {
            // bỏ index khỏi list
            delete global['list'][index]
        }
        else global['list'][index] = code
        goPage(global['page'])
    }

    function listModal() {
        if (Object.keys(global.list).length) {
            html = ''
            index = 1
            for (const key in global.list) {
                if (global.list.hasOwnProperty(key)) {
                    const code = global.list[key];
                    html += `
                    <tr>
                        <td> `+ (index++) +` </td>
                        <td> <img src="`+ global['data'][code]['image'] +`"> </td>
                        <td> `+ global['data'][code]['category'] +` </td>
                        <td> `+ global['data'][code]['name'] +` </td>
                        <td> `+ (global['data'][code]['number'] + global['data'][code]['number2']) +` </td>
                    </tr>`
                }
            }
            html = `
                <table border="1">
                    <thead>
                        <tr>
                            <th> STT </th>
                            <th> Hình ảnh</th>
                            <th> Loại hàng </th>
                            <th> Tên hàng </th>
                            <th> Số lượng </th>
                        <tr>
                    </thead>
                    <tbody>
                        `+ html +`
                    </tbody>
                </table>`
            $("#list-content").html(html)
            $("#list-modal").modal('show')
        }
        else notify('Chưa chọn hàng hóa nào')
    }

    function convertTable() {
        var style = `
            <style>
                table { border-collapse: collapse; width: 100%; }
                td, th { padding: 10px; }
                img { width: 30%; height: 30% }
            </style>`
        makeTextFile(style + $("#list-content").html())
    }

    function notify(text) {
        $('html, body').animate({
            scrollTop: $("#notice-archo").offset().top
        }, 1000);
        $("#notice").text(text)
        $("#notice").show()
        $("#notice").fadeOut(3000)
    }
</script>
<!-- END: main -->