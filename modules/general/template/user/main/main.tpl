<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>

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

    var ExcelToJSON = function () {
        this.parseExcel = function (file) {
            var reader = new FileReader()
            reader.onload = function (e) {
                var data = e.target.result
                document.getElementById('file').value = null
                
                var workbook = XLSX.read(data, {
                    type: 'binary'
                })
                var object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[workbook.SheetNames[0]])
                list = []
                if (global['mode']) {
                    // insert
                    object.forEach((item) => {
                        code = item['Mã hàng'].toString()
                        if (code.indexOf(global['item']) < 0) list.push(item)
                    });
                }
                else {
                    // update
                    object.forEach((item) => {
                        code = item['Mã hàng'].toString()
                        if (code.indexOf(global['item']) >= 0) list.push(item)
                    });
                }
                global['selected'] = list
                goPage(1)
                $("#excel-modal").modal('hide')
                $("#item-modal").modal('show')
            }
            // reader.onerror = function (ex) { console.log(ex) }
            if (file) reader.readAsBinaryString(file)
        }
    }
    js = new ExcelToJSON()

    function excel(mode) {
        // 0: update, 1: insert
        global['mode'] = mode
        $(".excel-text").hide()
        if (mode) $(".excel-insert").show()
        else $(".excel-update").show()
        $("#excel-modal").modal('show')
    }

    function tick(e) {
        selectFile = e.target.files[0]
        js.parseExcel(selectFile)
    }

    function goPage(page) {
        global['page'] = page
        length = global['selected'].length

        // from = 
        for (let index = 0; index < array.length; index++) {
            const element = array[index];
            
        }
    }
</script>
<!-- END: main -->