<!-- BEGIN: main -->
<div id="msgshow"></div>
{modal}

<div class="form-group" style="float: right;">
    <button class="btn btn-info" onclick="styleModal()">
        Khổ giấy in
    </button>
    <button class="btn btn-info" onclick="variableModal()">
        Trường nhập
    </button>
</div>
<div class="form-group" style="clear: right;">
    <input type="text" class="form-control" id="form-name" value="{name}">
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

<!-- <div class="form-group" id="variable-table"> </div>
<div class="form-group">
    <button class="btn btn-success" onclick="insertVariable()">
        Thêm gợi nhớ
    </button>
</div> -->

<script src="/modules/core/js/vhttp.js"></script>
<script src="/assets/js/ckeditor/ckeditor.js"></script>
<script>
    var global = {
        id: 0,
        index: 0,
        select_index: 0,
        style: JSON.parse('{style}'),
        html: JSON.parse('{html}'),
    }
    var parser = {
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

    $(document).ready(() => {
        CKEDITOR.replace('html');
        $("#variable-content").html(generateData())
        // $(".list").change((e) => {
        //     item = e.currentTarget
        //     name = item.getAttribute('name')
        //     if (item.checked) $("#list-" + name).prop('disabled', false) 
        //     else $("#list-" + name).prop('disabled', true) 
        // })
    })

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

    function generateData() {
        html = ''
        if (!Object.keys(global['html']).length) {
            // trống thì thêm 1 trường nhập
            global['html'][global['index']++] = {
                type: 0,
                name: '',
                value: ''
            }
        }
        for (const key in global['html']) {
            if (global['html'].hasOwnProperty(key)) {
                const item = global['html'][key];
                html += `
                <div class="form-group row" id="`+key+`" type="`+ item['type'] +`">
                    <div class="col-sm-4">
                        `+ item['value'] +`
                    </div>
                    <div class="col-sm-6">
                        <button class="btn btn-info">
                            Sửa trường nhập
                        </button>
                    </div>
                    <div type="button" class="close" onclick="removeVariable('`+ key +`')"> &times; </div>
                </div>`
            }
        } 
        
        return html
    }

    function styleModal() {
        $("[name=scene][value="+ global['style']['orient'] +"]")
        $("#margin-left").val(Number(global['style']['left']) ? Number(global['style']['left']) : 0)
        $("#margin-right").val(Number(global['style']['right']) ? Number(global['style']['right']) : 0)
        $("#margin-top").val(Number(global['style']['top']) ? Number(global['style']['top']) : 0)
        $("#margin-bottom").val(Number(global['style']['bottom']) ? Number(global['style']['bottom']) : 0)
        $("#style-modal").modal('show')
    }

    function variableModal() {
        $("#variable-modal").modal('show')
    }

    function checkStyleData() {
        return {
            orient: $("[name=scene]:checked").val(),
            left: $("#margin-left").val(),
            right: $("#margin-right").val(),
            top: $("#margin-top").val(),
            bottom: $("#margin-bottom").val()
        }
    }

    function saveStyle() {
        style = checkStyleData()
        vhttp.checkelse('', {action: 'save-style', data: style}).then(data => {
            global['style'] = style
            $("#style-modal").modal('hide')
        })
    }

    function insertVariable() {
        checkVariable()
        global['html'][global['index'] ++] = {
            type: 0,
            name: '',
            value: ''
        }
        $("#variable-content").html(generateData())
    }

    function replaceWord(html) {
        // checkVariable()
        // global['word'].forEach((item) => {
        //     html = html.replace(new RegExp(item['name'], "g"), item['value'])
        // });
        return html
    }

    function checkStyle() {
        scene = 'portrait'
        if (Number($("[name=scene]:checked").val())) {
            scene = 'landscape'
        }
        return '<style>@page { size: A4 ' + scene + '; margin: ' + $("#margin-top").val() + 'cm '+ $("#margin-right").val() +'cm '+ $("#margin-bottom").val() +'cm '+ $("#margin-left").val() +'cm; }</style>'
    }

    function checkVariable() {
        // $(".variable").each((index, item) => {
        //     key = item.getAttribute('id')
        //     global['data'][key]['value'] = $("#val-" + key).val()
        //     global['data'][key]['type'] = $("#type-" + key).val()
        // })
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

    // function changeType(index) {
    //     var type = $("#type-" + index).val()
    //     $(".option-" + index).hide()
    //     if (Number(type)) $("#config-" + index).show()
    //     else $("#val-" + index).show()
    // }

    // function generateDataType(type, index) {
    //     return `
    //     <div class="col-sm-6">
    //         <select class="form-control" id="type-`+ index +`" onchange="changeType(`+ index +`)">
    //             <option value="0"`+ (type == 0 ? 'selected' : '') +`> Ký tự </option>
    //             <option value="1"`+ (type == 1 ? 'selected' : '') +`> Danh sách </option>
    //             <option value="2"`+ (type == 2 ? 'selected' : '') +`> Bảng </option>
    //         </select>
    //     </div>`
    // }

    // function generateData(data, name = '') {
    //     html = ''
    //     for (const key in data) {
    //         if (data.hasOwnProperty(key)) {
    //             const item = data[key];
    //             display = ['', 'style="display: none;"']
    //             if (Number(item['type'])) {
    //                 display = ['style="display: none;"', '']
    //             }
    //             temp = parser[item['type']](item, key)
    //             temp += generateDataType(item['type'], key)
    //             html += `
    //             <div class="form-group row variable" id="`+key+`" type="`+ item['type'] +`">
    //                 `+ temp +`
    //                 <div class="col-sm-4">
    //                     <input class="form-control option-`+ key +`" `+display[0]+` id="val-`+ key +`" value="`+ item['value'] +`" placeholder="Từ thay thế">
    //                     <button class="btn btn-info option-`+ key +`" `+display[1]+` id="config-`+key+`" onclick="openConfig(`+key+`)">
    //                         Cấu hình
    //                     </button>
    //                 </div>
    //                 <div type="button" class="close" onclick="removeVariable('`+ key +`')"> &times; </div>
    //             </div>`
    //         }
    //     }
        
    //     return html
    // }

    // function removeVariable(remove_index) {
    //     checkVariable()
    //     delete global['data'][remove_index]
    //     if (!Object.keys(global['data']).length) {
    //         insertVariable()
    //     }
    // }

    // function openConfig(index) {
    //     var type = $("#type-" + index).val()
    //     global['select_index'] = index
    //     switch (type) {
    //         case "2":
    //             // Bảng
    //             $("#table-modal").modal('show')
    //             break;
    //         default:
    //             // Danh sách
    //             // lấy thông tin từ index
    //             // hiển thị
    //             $('.list').prop('checked', false)
    //             $('.list-input').prop('disabled', true)
    //             config = global['data'][index]['config']
    //             if (config['check_number']) {
    //                 $("#checkbox-number").prop('checked', true)
    //                 $("#list-number").prop('disabled', false)
    //             }
    //             if (config['check_prefix']) {
    //                 $("#checkbox-prefix").prop('checked', true)
    //                 $("#list-prefix").prop('disabled', false)
    //             }
    //             if (config['check_subfix']) {
    //                 $("#checkbox-subfix").prop('checked', true)
    //                 $("#list-subfix").prop('disabled', false)
    //             }
    //             number = Number(config['number'])
    //             number = number ? number : 0
    //             $("#list-number").val(number)
    //             $("#list-prefix").val(config['prefix'])
    //             $("#list-subfix").val(config['subfix'])
    //             $("#list-modal").modal('show')
    //     }
    // }

    // function saveListConfig() {
    //     global['data'][global['select_index']]['config'] = {
    //         number: $("#list-number").val(),
    //         check_number: $("#checkbox-number").prop('checked') ? 1 : 0,
    //         prefix: $("#list-prefix").val(),
    //         check_prefix: $("#checkbox-prefix").prop('checked') ? 1 : 0,
    //         subfix: $("#list-subfix").val(),
    //         check_subfix: $("#checkbox-subfix").prop('checked') ? 1 : 0,
    //     }
    //     $("#list-modal").modal('hide')
    // }

    // function replaceList(html) {
    //     checkVariable()
    //     global['word'].forEach((item) => {
    //         html = html.replace(new RegExp(item['name'], "g"), item['value'])
    //     });
    //     return html
    // }

    // function saveConfig() {
    //     vhttp.checkelse('save', {id: global['id'], style: checkStyle(), html: CKEDITOR.instances.html.getData()}).then(data => {
    //         // thông báo đã lưu
    //     })            
    // }
</script>
<!-- END: main -->
