<!-- BEGIN: main -->
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
        index: 0,
        word: [
            {
                name: '',
                value: ''
            }
        ],
        list: {},
        table: {}
    }

    $(document).ready(() => {
        CKEDITOR.replace('html');
        refreshVariable()
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

    function changeType(index) {
        var type = $("#vartype-" + index).val()
        $(".option-" + index).hide()
        if (Number(type)) $("#config-" + index).show()
        else $("#varvalue-" + index).show()
    }
    
    function openConfig(index) {
        var type = $("#vartype-" + index).val()
        global['index'] = index
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
                if (global['list']['number_check']) {
                    $("#checkbox-number").prop('checked', true)
                    $("#list-number").prop('disabled', false)
                }
                if (global['list']['prefix_check']) {
                    $("#checkbox-prefix").prop('checked', true)
                    $("#list-prefix").prop('disabled', false)
                }
                if (global['list']['subfix_check']) {
                    $("#checkbox-subfix").prop('checked', true)
                    $("#list-subfix").prop('disabled', false)
                }
                $("#list-number").val(global['list']['number'])
                $("#list-prefix").val(global['list']['prefix'])
                $("#list-subfix").val(global['list']['subfix'])
                $("#list-modal").modal('show')
        }
    }

    function refreshVariable() {
        html = ''
        global['word'].forEach((item, index) => {
            html += `
                <div class="form-group row">
                    <div class="col-sm-6">
                        <input class="form-control variable" id="varname-`+ index +`" value="`+ item['name'] +`" placeholder="Tên">
                    </div>
                    <div class="col-sm-6">
                        <select class="form-control" id="vartype-`+index+`" onchange="changeType(`+index+`)">
                            <option value="0"> Ký tự </option>
                            <option value="1"> Danh sách </option>
                            <option value="2"> Bảng </option>
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <input class="form-control option-`+ index +`" id="varvalue-`+ index +`" value="`+ item['value'] +`" placeholder="Từ thay thế">
                        <button class="btn btn-info option-`+ index +`" id="config-`+index+`" style="display: none;" onclick="openConfig(`+index+`)">
                            Cấu hình
                        </button>
                    </div>

                    <div type="button" class="close" onclick="removeVariable('`+ index +`')"> &times; </div>
                </div>`
        });
        $("#" + name).html(html)
    }

    function refreshVariable() {
        html = ''
        global['word'].forEach((item, index) => {
            html += `
                <div class="form-group row">
                    <div class="col-sm-6">
                        <input class="form-control variable" id="varname-`+ index +`" value="`+ item['name'] +`" placeholder="Tên">
                    </div>
                    <div class="col-sm-6">
                        <select class="form-control" id="vartype-`+index+`" onchange="changeType(`+index+`)">
                            <option value="0"> Ký tự </option>
                            <option value="1"> Danh sách </option>
                            <option value="2"> Bảng </option>
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <input class="form-control option-`+ index +`" id="varvalue-`+ index +`" value="`+ item['value'] +`" placeholder="Từ thay thế">
                        <button class="btn btn-info option-`+ index +`" id="config-`+index+`" style="display: none;" onclick="openConfig(`+index+`)">
                            Cấu hình
                        </button>
                    </div>

                    <div type="button" class="close" onclick="removeVariable('`+ index +`')"> &times; </div>
                </div>`
        });
        $("#variable-table").html(html)
    }

    function refreshVariable(data) {
        html = ''
        data.forEach((item, index) => {
            html += `
                <div class="form-group row">
                    <div class="col-sm-6">
                        <input class="form-control variable" id="varname-`+ index +`" value="`+ item['name'] +`" placeholder="Tên">
                    </div>
                    <div class="col-sm-6">
                        <select class="form-control" id="vartype-`+index+`" onchange="changeType(`+index+`)">
                            <option value="0"> Ký tự </option>
                            <option value="1"> Danh sách </option>
                            <option value="2"> Bảng </option>
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <input class="form-control option-`+ index +`" id="varvalue-`+ index +`" value="`+ item['value'] +`" placeholder="Từ thay thế">
                        <button class="btn btn-info option-`+ index +`" id="config-`+index+`" style="display: none;" onclick="openConfig(`+index+`)">
                            Cấu hình
                        </button>
                    </div>
                    <div type="button" class="close" onclick="removeVariable('`+ index +`')"> &times; </div>
                </div>`
        });
        return html
    }

    function checkVariable () {
        global['word'] = []
        $(".variable").each((index, item) => {
            key = item.getAttribute('id').replace('varname-', '')
            global['word'].push({
                name: $("#varname-" + index).val(),
                value: $("#varvalue-" + index).val()
            })
        })
    }

    function removeVariable(remove_index) {
        checkVariable()
        global['word'] = global['word'].filter((item, index) => {
            return index != remove_index
        })
        
        if (!global['word'].length) {
            global['word'].push({
                name: '',
                value: ''
            })
        }
        refreshVariable()
    }

    function insertVariable() {
        checkVariable()
        global['word'].push({
            name: '',
            value: ''
        })
        refreshVariable()
    }

    function saveListConfig() {
        global['list'][global['index']] = {
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
</script>
<!-- END: main -->
