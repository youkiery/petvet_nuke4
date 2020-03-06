<!-- BEGIN: main -->
<script src="/modules/core/js/vhttp.js"></script>

{modal}

<div class="form-group">
    <label> Chiều in </label>
    <input type="radio" name="scene" value="0" checked> Chiều dọc
    <input type="radio" name="scene" value="1"> Chiều Ngang
</div>
<div class="form-group">
    <label> Căn lề </label>
    <div class="row form-group">
        <label class="col-sm-3">
            Lề trái
        </label>
        <div class="col-sm-9">
            <input class="form-control" type="text" id="margin-left" value="1">
        </div>
    </div>
    <div class="row form-group">
        <label class="col-sm-3">
            Lề phải
        </label>
        <div class="col-sm-9">
            <input class="form-control" type="text" id="margin-right" value="1">
        </div>
    </div>
    <div class="row form-group">
        <label class="col-sm-3">
            Lề trên
        </label>
        <div class="col-sm-9">
            <input class="form-control" type="text" id="margin-top" value="1">
        </div>
    </div>
    <div class="row form-group">
        <label class="col-sm-3">
            Lề dưới
        </label>
        <div class="col-sm-9">
            <input class="form-control" type="text" id="margin-bottom" value="1">
        </div>
    </div>
</div>

<div class="form-group">
    <div id="html">

    </div>
</div>
<div class="form-group text-center">
    <button class="btn btn-info" onclick="print()">
        In phiếu thử
    </button>
</div>

<div class="form-group" id="variable-table"> </div>
<div class="form-group">
    <button class="btn btn-success" onclick="insertVariable()">
        Thêm gợi nhớ
    </button>
</div>

<script src="/assets/js/ckeditor/ckeditor.js"></script>
<script>
    var global = {
        id: 0,
        index: 0,
        select_index: 0,
        data: {
            0: {
                type: 0,
                name: '',
                value: ''
            }
        }
    }

    parser = {
        0: (data, index) => {
            return `
            <div class="col-sm-6">
                <input class="form-control" id="var-`+ index +`" value="`+ data['name'] +`" placeholder="Tên">
            </div>`
        },
        1: (data, index) => {
            return `
            <div class="col-sm-6">
                <input class="form-control" id="var-`+ index +`" value="`+ data['name'] +`" placeholder="Tên">
            </div>`
        },
        2: (data, index) => {
            return `
            <div class="col-sm-6">
                <input class="form-control" id="var-`+ index +`" value="`+ data['name'] +`" placeholder="Tên">
            </div>`
        }
    }

    function changeType(index) {
        var type = $("#type-" + index).val()
        $(".option-" + index).hide()
        if (Number(type)) $("#config-" + index).show()
        else $("#val-" + index).show()
    }

    function generateDataType(type, index) {
        return `
        <div class="col-sm-6">
            <select class="form-control" id="type-`+ index +`" onchange="changeType(`+ index +`)">
                <option value="0"`+ (type == 0 ? 'selected' : '') +`> Ký tự </option>
                <option value="1"`+ (type == 1 ? 'selected' : '') +`> Danh sách </option>
                <option value="2"`+ (type == 2 ? 'selected' : '') +`> Bảng </option>
            </select>
        </div>`
    }

    function generateData(data, name = '') {
        html = ''
        for (const key in data) {
            if (data.hasOwnProperty(key)) {
                const item = data[key];
                display = ['', 'style="display: none;"']
                if (Number(item['type'])) {
                    display = ['style="display: none;"', '']
                }
                temp = parser[item['type']](item, key)
                temp += generateDataType(item['type'], key)
                html += `
                <div class="form-group row variable" id="`+key+`" type="`+ item['type'] +`">
                    `+ temp +`
                    <div class="col-sm-4">
                        <input class="form-control option-`+ key +`" `+display[0]+` id="val-`+ key +`" value="`+ item['value'] +`" placeholder="Từ thay thế">
                        <button class="btn btn-info option-`+ key +`" `+display[1]+` id="config-`+key+`" onclick="openConfig(`+key+`)">
                            Cấu hình
                        </button>
                    </div>
                    <div type="button" class="close" onclick="removeVariable('`+ key +`')"> &times; </div>
                </div>`
            }
        }
        
        return html
    }

    function insertVariable() {
        checkVariable()
        global['index'] ++
        global['data'][global['index']] = {
            type: 0,
            name: '',
            value: ''
        }
        $("#variable-table").html(generateData(global['data']))
    }

    function removeVariable(remove_index) {
        checkVariable()
        delete global['data'][remove_index]
        if (!Object.keys(global['data']).length) {
            insertVariable()
        }
    }

    function checkVariable() {
        $(".variable").each((index, item) => {
            key = item.getAttribute('id')
            global['data'][key]['value'] = $("#val-" + key).val()
            global['data'][key]['type'] = $("#type-" + key).val()
        })
    }

    $(document).ready(() => {
        CKEDITOR.replace('html');
        $("#variable-table").html(generateData(global['data']))
        $(".list").change((e) => {
            item = e.currentTarget
            name = item.getAttribute('name')
            if (item.checked) $("#list-" + name).prop('disabled', false) 
            else $("#list-" + name).prop('disabled', true) 
        })
    })

    function checkStyle() {
        scene = 'portrait'
        if (Number($("[name=scene]:checked").val())) {
            scene = 'landscape'
        }
        return '<style>@page { size: A4 ' + scene + '; margin: ' + $("#margin-top").val() + 'cm '+ $("#margin-right").val() +'cm '+ $("#margin-bottom").val() +'cm '+ $("#margin-left").val() +'cm; }</style>'
    }
    
    function openConfig(index) {
        var type = $("#type-" + index).val()
        global['select_index'] = index
        switch (type) {
            case "2":
                // Bảng
                $("#table-modal").modal('show')
                break;
            default:
                // Danh sách
                // lấy thông tin từ index
                // hiển thị
                $('.list').prop('checked', false)
                $('.list-input').prop('disabled', true)
                config = global['data'][index]['config']
                if (config['check_number']) {
                    $("#checkbox-number").prop('checked', true)
                    $("#list-number").prop('disabled', false)
                }
                if (config['check_prefix']) {
                    $("#checkbox-prefix").prop('checked', true)
                    $("#list-prefix").prop('disabled', false)
                }
                if (config['check_subfix']) {
                    $("#checkbox-subfix").prop('checked', true)
                    $("#list-subfix").prop('disabled', false)
                }
                number = Number(config['number'])
                number = number ? number : 0
                $("#list-number").val(number)
                $("#list-prefix").val(config['prefix'])
                $("#list-subfix").val(config['subfix'])
                $("#list-modal").modal('show')
        }
    }

    function saveListConfig() {
        global['data'][global['select_index']]['config'] = {
            number: $("#list-number").val(),
            check_number: $("#checkbox-number").prop('checked') ? 1 : 0,
            prefix: $("#list-prefix").val(),
            check_prefix: $("#checkbox-prefix").prop('checked') ? 1 : 0,
            subfix: $("#list-subfix").val(),
            check_subfix: $("#checkbox-subfix").prop('checked') ? 1 : 0,
        }
        $("#list-modal").modal('hide')
    }

    function replaceWord(html) {
        checkVariable()
        global['word'].forEach((item) => {
            html = html.replace(new RegExp(item['name'], "g"), item['value'])
        });
        return html
    }

    function replaceList(html) {
        checkVariable()
        global['word'].forEach((item) => {
            html = html.replace(new RegExp(item['name'], "g"), item['value'])
        });
        return html
    }

    function print() {
        style = checkStyle()
        html = replaceWord(CKEDITOR.instances.html.getData())

        var winPrint = window.open('', '_blank', 'left=0,top=0,width=800,height=600');
        winPrint.focus()
        winPrint.document.write(style + html);
        setTimeout(() => {
          winPrint.print()
          winPrint.close()
        }, 300)
    }

    function saveConfig() {
        vhttp.checkelse('save', {id: global['id'], style: checkStyle(), html: CKEDITOR.instances.html.getData()}).then(data => {
            // thông báo đã lưu
        })            
    }
</script>
<!-- END: main -->
