<!-- BEGIN: main -->
<style>
    .error {
        font-weight: bold;
        font-size: 1.2em;
        color: red;
    }
</style>

{modal}

<div class="form-group" style="float: right;">
    <button class="btn btn-info" onclick="insertModal()">
        Thêm mẫu
    </button>
</div>

<div style="clear: both;"></div>

<div class="content">
    {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
    function insertModal() {
        $(".insert-btn").hide()
        $("#insert-btn").show()
        $("#insert-modal").modal('show')
    }

    function insertSubmit() {
        name = $("#insert-name").val()
        if (!name.length) {
            showError('Nhập tên mẫu trước khi thêm')
        }
        else {
            vhttp.checkelse(
                '', {action: 'insert', name: name}
            ).then(data => {
                $("#content").html(data['html'])
            })
        }
    }

    function showError(text) {
        $("#insert-error").text(text)
        $("#insert-error").show()
        $("#insert-error").fadeOut(2000)
    }
</script>
<!-- END: main -->
