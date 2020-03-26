<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div id="msgshow"></div>
<style>
    label {
        width: 100%;
    }

    .error {
        color: red;
        font-size: 1.2em;
        font-weight: bold;
    }
</style>

<div id="modal">
    {modal}
</div>

<div class="form-group input-group">
    <input type="text" class="form-control" id="name" placeholder="Nhập tên phòng ban">
    <div class="input-group-btn">
        <button class="btn btn-success" onclick="insertDepart()">
            Thêm phòng ban
        </button>
    </div>
</div>

<div class="error" id="error"></div>

<div id="content">
    {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
    var global = {
        depart: 0
    }
    function editDepart(id) {
        global['depart'] = id
        vhttp.checkelse('', { action: 'get-depart', id: id }).then((data) => {
            $("#depart-name").val(data['name'])
            $("#depart-content").html(data['html'])
            $("#depart-modal").modal('show')
        })
    }

    function removeDepart(id) {

    }

    function insertDepart() {
        name = $("#name").val()
        if (!name.length) errorText('Nhập tên phòng trước khi thêm')
        else {
            vhttp.checkelse('', { action: 'insert-depart', name: name }).then((data) => {
                $("#content").html(data['html'])
            })
        }
    }

    function employFilter() {
        vhttp.checkelse('', { action: 'employ-filter', name: $("#employ-name").val() }).then((data) => {
            $("#employ-content").html(data['html'])
        })
    }

    function insertEmploy(id) {
        vhttp.checkelse('', { action: 'insert-employ', id: id, name: $("#employ-name").val(), departid: global['depart'] }).then((data) => {
            $("#depart-content").html(data['html'])
            $("#employ-content").html(data['html2'])
        })
    }

    function removeEmploy(id) {
        vhttp.checkelse('', { action: 'remove-employ', id: id, departid: global['depart'] }).then((data) => {
            $("#depart-content").html(data['html'])
        })
    }

    function updateDepartSubmit() {
        vhttp.checkelse('', { action: 'update-depart', departid: global['depart'], name: $("#depart-name").val() }).then((data) => {
            $("#content").html(data['html'])
        })
    }

    function errorText(txt) {
        $("#error").text(txt)
        $("#error").show()
        $("#error").fadeOut(3000)
    }
</script>
<!-- END: main -->