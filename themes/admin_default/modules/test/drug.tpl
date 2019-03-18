<!-- BEGIN: main -->
<form id="vac" onsubmit="return vac_submit_disease(event)">
	<div id="vac_notify" style="color: orange; background: gray; width: fit-content; display: none;"> Chọn hành động </div>
	<div class="row">
		<div class="form-group col-md-12">
			<input class="form-control" id="{index}" type="button" value="{lang.add}" onclick="vac_disease_add(this)">
		</div>
		<div class="form-group col-md-12">
			<input class="form-control" type="submit" value="{lang.save}">
		</div>
	</div>
	<div id="content">
		{content}
	</div>
</form>
<script>
var id = "{id}";
function vac_disease_add() {
	id ++;
	var form = document.getElementById("content");
	var html = '<div class="row" id="vac_remove_' + id + '"> <div class="col-md-20"> <input style="text-transform:capitalize;" class="form-control" name="d_name[' + id + ']" type="text" /> </div>		<div class="col-md-4"> <input type="button" class="btn btn-info" value="{lang.remove}" onclick="vac_disease_remove(' + id + ')"> </div> </div>';
	form.innerHTML += html;
}

function vac_disease_remove(index) {
	id --
	var e = document.getElementById("vac_remove_" + index);
	e.remove();
}

function vac_submit_disease(e) {
	e.preventDefault()
	var url = "index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=drug";
	var data = document.getElementsByClassName("form-control");
	var post_data = [];
	var length = data.length;
	for (let index = 0; index < length; index++) {
		post_data.push(data[index].getAttribute("name") + "=" + data[index].value);
	};
	fetch(url, post_data).then(response => {
		showMsg(response);
	})

	return false;
}
</script>
<!-- END: main -->
