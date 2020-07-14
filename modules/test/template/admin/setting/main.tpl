<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<script type="text/javascript" src="/modules/core/js/vhttp.js"></script>
<div id="msgshow" class="msgshow"></div>

{modal}

<div class="form-group">
	<!-- BEGIN: option -->
	<a href="/admin/index.php?nv={module_name}&op={op}&type={id}" class="btn {type} btn-xs">
		{name}
	</a>
	<!-- END: option -->
	
	<!-- BEGIN: insert -->
	<div style="float: right;">
		<button class="btn btn-success" onclick="employModal()">
			Tìm nhân viên
		</button>
	</div>
	<!-- END: insert -->
</div>

<div id="content">
	{content}
</div>

<script>
	function employModal() {
		$("#employ-name").val('')
		$("#employ-content").html('')
		$("#employ-modal").modal('show')
	}

    function employFilter() {
        vhttp.checkelse('', { action: 'employ-filter', name: $("#employ-name").val() }).then((data) => {
            $("#employ-content").html(data['html'])
        })
    }

	function insertEmploy(id) {
        vhttp.checkelse('', { action: 'insert-employ', id: id, name: $("#employ-name").val() }).then((data) => {
            $("#content").html(data['html'])
            $("#employ-content").html(data['html2'])
        })
    }

	function changeEmploy(id, type) {
        vhttp.checkelse('', { action: 'change-employ', id: id, type: type }).then((data) => {
            $("#content").html(data['html'])
        })
	}

	function removeEmploy(id) {
        vhttp.checkelse('', { action: 'remove-employ', id: id }).then((data) => {
            $("#content").html(data['html'])
        })
	}
</script>
<!-- END: main -->
