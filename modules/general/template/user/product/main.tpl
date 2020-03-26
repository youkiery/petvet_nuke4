<!-- BEGIN: main -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css">

<script src="/modules/core/js/vhttp.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/shim.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.full.min.js"></script>

<style>
    .error { color: red; font-size: 1.2em; font-weight: bold; }
    a.btn-default { color: #444 }
</style>

<div id="msgshow"></div>

{modal}

<form class="form-group row">
    <input type="hidden" name="nv" value="{nv}">
    <input type="hidden" name="op" value="{op}">
    <div class="col-sm-6">
        <input type="text" class="form-control" name="keyword" value="{keyword}" placeholder="Tìm kiếm theo tên hàng, mã hàng,...">
    </div>
    <div class="col-sm-6">
        <select class="form-control" name="category">
            <option value="0"> Tất cả </option>
            <!-- BEGIN: category -->
            <option value="{id}" {check}> {name} </option>
            <!-- END: category -->
        </select>
    </div>
    <div class="col-sm-6">
        <select class="form-control" name="limit">
            <option value="10" {check10}> 10 </option>
            <option value="20" {check20}> 20 </option>
            <option value="50" {check50}> 50 </option>
            <option value="100" {check100}> 100 </option>  
            <option value="200" {check200}> 200 </option>
        </select>
    </div>
    <div class="col-sm-6">
        <button class="btn btn-info">
            Tìm kiếm
        </button>
    </div>
</form>

<div class="form-group row">
    <div class="col-sm-12">
        <button class="btn btn-info" onclick="$('#insert-modal').modal('show')">
            Thêm mã
        </button>
        <button class="btn btn-info" onclick="$('#category-modal').modal('show')">
            Sửa loại hàng
        </button>
    </div>
    <div class="col-sm-12">
        <div style="float: right;">
            <button class="btn btn-danger" onclick="removeItem()">
                Xóa mã
            </button>
        </div>
    </div>
</div>

<div id="content">
    {content}
</div>

<script>
    var global = {
        page: 1,
        limit: 100,
        file: {},
        list: JSON.parse('{list}'),
        data: [],
        // allow: ['SHOP', 'SHOP>>Balo, giỏ xách', 'SHOP>>Bình xịt', 'SHOP>>Cát vệ sinh', 'SHOP>>Dầu tắm', 'SHOP>>Đồ chơi', 'SHOP>>Đồ chơi - vật dụng', 'SHOP>>Giỏ-nệm-ổ', 'SHOP>>Khay vệ sinh', 'SHOP>>Nhà, chuồng', 'SHOP>>Thuốc bán', 'SHOP>>Thuốc bán>>thuốc sát trung', 'SHOP>>Tô - chén', 'SHOP>>Vòng-cổ-khớp', 'SHOP>>Xích-dắt-yếm']
        allow: ["SHOP", "SHOP>>Balo, giỏ xách", "SHOP>>Bình xịt", "SHOP>>Cát vệ sinh", "SHOP>>Dầu tắm", "SHOP>>Đồ chơi", "SHOP>>Đồ chơi - vật dụng", "SHOP>>Giỏ-nệm-ổ", "SHOP>>Khay vệ sinh", "SHOP>>Nhà, chuồng", "SHOP>>Thức ăn", "SHOP>>Thuốc bán", "SHOP>>Thuốc bán>>thuốc sát trung", "SHOP>>Tô - chén", "SHOP>>Vòng-cổ-khớp", "SHOP>>Xích-dắt-yếm"]
    }

    $(document).ready(() => {
        $("#insert-box-content").hide()
        installFile('insert')
        installCheckbox('product')
    })

    function installFile(name) {
        global['file'][name] = {
            input: $("#" + name + "-file"),
            selected: null
        }
        global['file'][name]['input'].change((e) => {
            global['file'][name]['selected'] = e
        })
    }

    function process(name) {
        $("#"+ name +"-notify").text('Đang xử lý')

        if (!global['file'][name]['selected']) alert_msg('Chọn file excel trước')
        else processExcel(name)
    }

    function processExcel(name) {
        var reader = new FileReader();
        var rABS = !!reader.readAsBinaryString;
        var file = global['file'][name]['selected'].currentTarget.files[0]
        if (rABS) reader.readAsBinaryString(file);
        else reader.readAsArrayBuffer(file);

        reader.onload = (e) => {
            try {
                var data = e.target.result;
                if (!rABS) data = new Uint8Array(data);
                var wb = XLSX.read(data, { type: rABS ? 'binary' : 'array' });
                var object = XLSX.utils.sheet_to_row_object_array(wb.Sheets[wb.SheetNames[0]])
                console.log(object);
                $("#"+ name +"-notify").hide()
                global['data'] = []
                global['file'][name]['selected'] = null
                
                object.forEach((item, index) => {
                    // global['list']
                    code = item['Mã hàng']
                    category = item['Nhóm hàng(3 Cấp)']
                    if (global['allow'].indexOf(category) >= 0 && !global['list'][code]) {
                        global['data'].push({
                            code: code,
                            name: item['Tên hàng'],
                            number: item['Tồn kho'],
                            image: item['Hình ảnh (url1,url2...)'],
                            price: item['Giá bán']
                        })
                    }
                })
                $("#" + name + "-content").html(goPage(name, 1))
                installCheckbox(name)
                $("#" + name + "-box-content").show()
                $("#" + name + "-box").hide()
            } catch (error) {
                $("#"+ name +"-notify").text('Có lỗi xảy ra')
            }
        }
    }

    function insertSubmit() {
        data = []
        list = []
        $(".check-insert:checked").each((index, item) => {
            val = item.getAttribute('rel')
            data.push(global['data'][val])
            list.push(val)
        })
        
        vhttp.checkelse('', { action: 'insert', data: data }).then(data => {
            // xóa data list trong global[data]
            global['data'] = global['data'].filter((item, index) => {
                return list.indexOf(index.toString()) < 0 // giữ lại những index không có trong list
            })

            goPage2('insert', global['page'])
            installCheckbox('insert')
        })
    }

    function checkSelectedItem() {
        list = []
        $(".check-product:checked").each((index, item) => {
            val = item.getAttribute('rel')
            list.push(val)
        })
        return list
    }

    function removeItem() {
        list = checkSelectedItem()
        
        vhttp.checkelse('', { action: 'remove', list: list }).then(data => {
            $("#content").html(data['html'])
            installCheckbox('product')
        })
    }

    function changeCategory() {
        list = checkSelectedItem()
        vhttp.checkelse('', { action: 'change-category', list: list, category: $("#category-type").val() }).then(data => {
            $("#category-modal").modal('hide')
            $("#content").html(data['html'])
            installCheckbox('product')
        })
    }

    function clear(name) {
        $("#" + name + "-content").hide()
        $("#" + name + "-box").show()
    }

    function goPage(name, page) {
        global['page'] = page
        from = (global['page'] - 1) * global['limit'] + 1
        end = from + global['limit']
        temp = ''
        for (i = from; i < end; i++) {
            item = global['data'][i];
            if (item) {
                temp += `
                <tr>
                    <td> `+ i +` </td>
                    <td> <input type="checkbox" class="check-insert" rel="`+ i +`"> </td>
                    <td> `+ item['code'] +` </td>
                    <td> `+ item['name'] +` </td>
                </tr>`
            }
        }
        nav = ''
        page = global['data'].length / global['limit'] + (global['data'].length % global['limit'] ? 1 : 0)
        for (i = 1; i <= page; i++) {
            if (i == global['page']) {
                nav += `<button class="btn btn-info"> `+ i +` </button>`            
            }
            else {
                nav += `<button class="btn btn-default" onclick="goPage2('`+ name +`', `+ i +`)"> `+ i +` </button>`
            }
        }

        return `
        <table class="table table-bordered table-hover">
            <tr>
                <th> STT </th>
                <th> <input type="checkbox" class="check-insert-all"> </th>
                <th> Mã hàng </th>
                <th> Tên hàng </th>
            </tr>
            `+ temp +`
        </table>` + nav
    }

    function goPage2(name, page) {
        $("#" + name + "-content").html(goPage(name, page))
        installCheckbox(name)
    }

    function installCheckbox(name) {
        $(".check-" + name + "-all").change((e) => {
            $(".check-" + name).prop('checked', e.currentTarget.checked)
        })
    }

    function errorText(id, text) {
        $("#" + id).text(text)
        $("#" + id).show()
        $("#" + id).fadeOut(2000)
    }
</script>
<!-- END: main -->