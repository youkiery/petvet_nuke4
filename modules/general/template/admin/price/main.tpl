<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">

<div id="msgshow"></div>
<style>
    label { width: 100%; }
</style>

{modal}

<form class="form-group row" method="get">
    <div class="col-sm-8">
        <input class="form-control" type="text" name="keyword" value="{keyword}" placeholder="Từ khóa">
    </div>
    <div class="col-sm-8">
        <select class="form-control" name="category">
            <option value="0"> Tất cả </option>
            {category_option}
        </select>
    </div>
    <input type="hidden" name="nv" value="{module_name}">
    <input type="hidden" name="op" value="{op}">
    <button class="btn btn-info">
        <span class="glyphicon glyphicon-search"></span>
    </button>
</form>

<div class="form-group row">
    <button class="btn btn-info" onclick="$('#category-modal').modal('show')">
        Danh mục
    </button>
    <div style="float: right;">
        <button class="btn btn-success" onclick="itemModal()">
            Thêm hàng
        </button>
    </div>
    <div style="clear: both;"></div>
</div>

<div id="content">
    {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vnumber.js"></script>
<script>
    var global = {
        id: 0,
        data: [{number: 0, price: 0}]
    }

    function categoryInsertSubmit() {
        vhttp.checkelse('', { action: 'category-insert', name: $("#category-name").val() }).then(data => {
            $("#category-name").val('')
            $("#category-content").html(data['html'])
        })
    }

    function categoryToggle(id) {
        vhttp.checkelse('', { action: 'category-toggle', id: id }).then(data => {
            $("#category-content").html(data['html'])
        })
    }

    function categoryUpdate(id) {
        vhttp.checkelse('', { action: 'category-update', id: id, name: $("#category-name-" + id).val() }).then(data => {
            // do nothing
        })
    }

    function itemInsertSubmit() {
        sdata = checkItemData()
        if (!sdata['name']) {
            alert_msg(sdata)
        }
        else {
            vhttp.checkelse('', { action: 'item-insert', data: sdata }).then(data => {
                $("#content").html(data['html'])
                $("#item-modal").modal('hide')
            })
        }
    }

    function itemModal() {
        global['data'] = [{number: 0, price: 0}]
        $("#item-insert-btn").show()
        $("#item-edit-btn").hide()
        parseItemSection()
        $('#item-modal').modal('show')
    }

    function addItem() {
        reloadItemSection()
        global['data'].push({
            number: 0,
            price: 0
        })
        parseItemSection()
    }

    function removeItem(index) {
        reloadItemSection()
        global['data'] = global['data'].filter((item, item_index) => {
            return index != item_index
        })
        if (!global['data'].length) global['data'] = [{number: 0, price: 0}]
        parseItemSection()
    }

    function checkItemData() {
        reloadItemSection()
        data = {
            code: $("#item-code").val(),
            name: $("#item-name").val(),
            category: $("#item-category").val(),
            section: global['data']
        }
        if (!data['name'].length) return 'Nhập tên hàng trước'
        else if (!data['category'].length) return 'Thêm danh mục trước'

        try {
            check = {}
            data['section'].forEach(item => {
                if (!check[item['number']]) check[item['number']] = 0
                check[item['number']] ++
                if (check[item['number']] > 1) {
                    throw "same number"
                }
            })
        }
        catch (e) {
            return '2 mặt hàng không được cùng số lượng'
        }
        return data
    }

    function reloadItemSection() {
        global['data'].forEach((item, index) => {
            if ($("#item-price-" + index)) {
                global['data'][index] = {
                    number: $("#item-number-" + index).val(),
                    price: $("#item-price-" + index).val()
                }
            }
        })
    }

    function parseItemSection() {
        html = ''
        global['data'].forEach((item, index) => {
            html += `
            <div class="form-group" id="item-`+ index +`">
                <div> 
                    <b> Phân giá `+ (index + 1) +` </b>
                    <div class="close" type="button" onclick="removeItem(`+ index +`)"> &times; </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <label>
                            Giá sỉ
                            <input class="form-control" id="item-price-`+ index +`" value="`+ item['price'] +`">
                        </label>
                    </div>
                    <div class="col-sm-12">
                        <label>
                            Số lượng
                            <input class="form-control" id="item-number-`+ index +`" value="`+ item['number'] +`">
                        </label>
                    </div>
                </div>
            </div>`
        })
        $("#item-content").html(html)
        global['data'].forEach((item, index) => {
            vnumber.install('item-price-' + index)
        })
    }

    function itemRemove(id) {
        global['id'] = id
        $("#remove-modal").modal('show')
    }

    function itemRemoveSubmit() {
        vhttp.checkelse('', { action: 'item-remove', id: global['id'] }).then(data => {
            $("#content").html(data['html'])
            $("#remove-modal").modal('hide')
        })
    }

    function itemEdit(id) {
        global['id'] = id
        $("#item-insert-btn").hide()
        $("#item-edit-btn").show()
        vhttp.checkelse('', { action: 'item-get', id: id }).then(data => {
            $("#item-code").val(data['data']['code'])
            $("#item-name").val(data['data']['name'])
            $("#item-category").val(data['data']['category'])
            global['data'] = data['data']['section']
            parseItemSection()
            $("#item-modal").modal('show')
        })
    }

    function itemEditSubmit() {
        sdata = checkItemData()
        if (!sdata['name']) {
            alert_msg(sdata)
        }
        else {
            vhttp.checkelse('', { action: 'item-edit', id: global['id'], data: sdata }).then(data => {
                $("#content").html(data['html'])
                $("#item-modal").modal('hide')
            })
        }
    }
</script>
<!-- END: main -->
