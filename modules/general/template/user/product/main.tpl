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

{modal}

<div class="form-group row">
    <div class="col-sm-6">
        <button class="btn btn-info" onclick="$('#insert-modal').modal('show')">
            Thêm mã
        </button>
    </div>
    <div class="col-sm-12"></div>
    <div class="col-sm-6">
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
        data: []
    }

    $(document).ready(() => {
        $("#insert-box-content").hide()
        installFile('insert')
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

        if (!global['file'][name]['selected']) notify('Chọn file excel trước')
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
                    if (!global['list'][item['Mã hàng']]) {
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
        console.log(list);
        
        vhttp.checkelse('', { action: 'insert', data: data }).then(data => {
            // xóa data list trong global[data]
            global['data'] = global['data'].filter((item, index) => {
                return list.indexOf(index.toString()) < 0 // giữ lại những index không có trong list
            })

            goPage2('insert', global['page'])
            installCheckbox('insert')
        })
    }

    function removeItem() {
        list = []
        $(".product-insert:checked").each((index, item) => {
            val = item.getAttribute('rel')
            data.push(global['data'][val])
        })
        
        vhttp.checkelse('', { action: 'remove', data: data }).then(data => {
            window.location.reload()
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
            temp += `
            <tr>
                <td> `+ i +` </td>
                <td> <input type="checkbox" class="check-insert" rel="`+ i +`"> </td>
                <td> `+ item['code'] +` </td>
                <td> `+ item['name'] +` </td>
            </tr>`
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
            $(".check-insert").prop('checked', e.currentTarget.checked)
        })
    }

    function errorText(id, text) {
        $("#" + id).text(text)
        $("#" + id).show()
        $("#" + id).fadeOut(2000)
    }

</script>
<!-- END: main -->