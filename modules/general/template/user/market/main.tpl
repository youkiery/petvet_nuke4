<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<style>
    .error {
        color: red;
        font-size: 1.2em;
        font-weight: bold;
    }
</style>

{modal}

<div class="form-group row">
    <div class="col-sm-12">
        <form onsubmit="search(event)">
            <div class="input-group">
                <input type="text" class="form-control" id="filter-keyword"
                    placeholder="Tìm kiếm theo tên hàng, địa chỉ">
                <div class="input-group-btn">
                    <button class="btn btn-info"> Tìm kiếm</button>
                </div>
            </div>
        </form>
    </div>
    <div class="col-sm-12">
        <div style="float: right;">
            <button class="btn btn-success" onclick="insert()">
                Thêm mới
            </button>
        </div>
    </div>
</div>

<div class="form-group" style="clear: both;"></div>

<div id="content"> </div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
    var global = {
        index: 0,
        page: 1,
        limit: 100,
        notify: {
            insert: 'insert-error'
        },
        data: {}
    }

    $(document).ready(() => {
        try {
            global['data'] = JSON.parse('{data}')
            goPage(1)
        }
        catch (e) {
            console.log(e);

            errorText('Lỗi rồi, tải lại trang hoặc báo với lập trình viên để sửa lại', 'content', 1000000)
        }
    })

    function checkInsertData() {
        name = $("#insert-name").val()
        price = $("#insert-price").val()
        unit = $("#insert-unit").val()
        address = $("#insert-address").val()
        if (!name.length) {
            errorText('Nhập tên hàng trước khi lưu', 'insert-error')
        }
        else if (!address.length) {
            errorText('Nhập địa chỉ trước khi lưu', 'insert-error')
        }
        else {
            return {
                name: name,
                unit: unit,
                price: price,
                address: address
            }
        }
        return 0
    }

    function clear() {
        $('#filter-keyword').val('')
        goPage(1)
    }

    function search(e) {
        e.preventDefault()
        goPage(1)
    }

    function remove(id) {
        global['index'] = id
        $("#remove-modal").modal('show')
    }

    function removeSubmit() {
        vhttp.checkelse('', { action: 'remove', id: global['data'][global['index']]['id'] }).then(data => {
            global['data'] = global['data'].filter((item, index) => {
                return index != global['index']
            })
            goPage(global['page'])
            $("#remove-modal").modal('hide')
        })
    }

    function insert() {
        $("#insert-btn").show()
        $("#edit-btn").hide()
        $("#insert-modal").modal('show')
    }

    function insertSubmit() {
        sdata = checkInsertData()
        if (sdata) {
            vhttp.checkelse('', { action: 'insert', data: sdata }).then(data => {
                // $("#content").html(data['html'])
                sdata['id'] = data['id']
                global['data'].push(sdata)
                goPage(global['page'])
                $("#insert-modal").modal('hide')
                $("#insert-name").val('')
                $("#insert-price").val('')
                $("#insert-unit").val('')
                $("#insert-address").val('')
            })
        }
    }

    function edit(id) {
        global['id'] = id
        vhttp.checkelse('', { action: 'get-edit', id: global['data'][global['index']]['id'] }).then(data => {
            $("#insert-btn").hide()
            $("#edit-btn").show()
            $("#insert-name").val(data['name'])
            $("#insert-price").val(data['price'])
            $("#insert-unit").val(data['unit'])
            $("#insert-address").val(data['address'])
            $("#insert-modal").modal('show')
        })
    }

    function editSubmit() {
        sdata = checkInsertData()
        if (sdata) {
            vhttp.checkelse('', { action: 'edit', data: sdata, id: global['data'][global['index']]['id'] }).then(data => {
                // $("#content").html(data['html'])
                sdata['id'] = global['data'][global['index']]['id']
                global['data'][global['id']] = sdata
                goPage(global['page'])
                $("#insert-modal").modal('hide')
                $("#insert-name").val('')
                $("#insert-price").val('')
                $("#insert-address").val('')
            })
        }
    }

    function goPage(page) {
        global['page'] = page
        html = ''
        keyword = convert($("#filter-keyword").val())
        if (keyword.length) {
            list = global['data'].filter((item) => {
                return (convert(item['name']).search(keyword) >= 0) || (convert(item['address']).search(keyword) >= 0)
            })
        }
        else list = global['data']

        from = (global['page'] - 1) * global['limit']
        end = from + global['limit']
        index = from + 1

        for (i = from; i < end; i++) {
            data = list[i]

            if (data) {
                html += `
                    <tr>
                        <td> `+ (index++) + ` </td>
                        <td> `+ data['name'] + ` </td>
                        <td> `+ data['unit'] + ` </td>
                        <td> `+ data['price'] + ` </td>
                        <td> `+ data['address'] + ` </td>
                        <td>
                            <button class="btn btn-info btn-sm" onclick="edit(`+ i + `)">
                                Sửa
                            </button>
                            <button class="btn btn-danger btn-sm" onclick="remove(`+ i + `)">
                                Xóa
                            </button>
                        </td>
                    </tr>`
            }
        }
        $("#content").html(`
            `+ (keyword.length ? '<p> Tìm kiếm ' + keyword + ' được ' + list.length + ' kết quả </p>' : '') + `
            <table class="table table-bordered table-hover">
                <tr>
                    <th> STT </th>
                    <th> Tên hàng </th>
                    <th> Đơn vị </th>
                    <th> Giá </th>
                    <th> Địa chỉ </th>
                    <th> </th>
                </tr>
                `+ html + `
            </table>` + generate_nav(list.length, global['page'], global['limit']))
    }

    function generate_nav(number, page, limit) {
        html = ''
        from = 1
        end = number / limit + (number % limit ? 1 : 0)
        for (i = from; i < end; i++) {
            if (page == i) {
                html += `
                    <button class="btn">
                        `+ i + `
                    </button>`
            }
            else {
                html += `
                    <button class="btn btn-default" onclick="goPage(`+ i + `)">
                        `+ i + `
                    </button>`
            }
        }
        return html
    }

    function errorText(text, id, time = 2000) {
        $("#" + id).text(text)
        $("#" + id).show()
        $("#" + id).fadeOut(time)
    }

    function convert(str) {
        str = str.toLowerCase();
        str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
        str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
        str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
        str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
        str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
        str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
        str = str.replace(/đ/g, "d");
        str = str.replace(/ + /g, " ");
        str = str.trim();
        return str;
    }

</script>
<!-- END: main -->