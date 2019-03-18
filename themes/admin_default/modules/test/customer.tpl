<!-- BEGIN: main -->
<form id="vac_panel">
	<div class="row">
		<div class="form-group col-md-12">
			<label>{lang.customer}</label>
			<input class="form-control vac_val" style="display: block;" type="text" name="customer" id="customer" value="{customer2}">
		</div>
		<div class="form-group col-md-12">
			<label>{lang.phone}</label>
			<input class="form-control vac_val" style="display: block;" type="number" maxlength="15" name="phone" id="phone" value="{phone2}">
		</div>
	</div>
	<div class="form-group">
		<label>{lang.address}</label>
		<input class="form-control vac_val" style="display: block; height: 40px;" type="text" name="address" id="address" value="{address2}">
	</div>
	<div class="form-group text-center">
			<input class="btn btn-info" type="button" id="vac_button_panel" value="{lang.add}" onclick="vac_add_customer(event)">
			<input class="btn btn-info" type="button" id="update" onclick="vac_update_customer(event)" value="{lang.update}">
	</div>
</form>
<form method="GET">
	<input type="hidden" name="nv" value="{nv}">
	<input type="hidden" name="op" value="{op}">
	<div class="row">
		<div class="form-group col-md-12">
			<label>
				{lang.sort}
			</label>
			<select class="form-control" name="sort">
				<!-- BEGIN: fs_option -->
				<option value="{fs_value}" {fs_select}>
					{fs_name}
				</option>
				<!-- END: fs_option -->
			</select>
		</div>
		<div class="form-group col-md-12">
			<label>
				{lang.count}
			</label>
			<select class="form-control" name="filter">
				<!-- BEGIN: ff_option -->
				<option value="{ff_value}" {ff_select}>
					{ff_name}
				</option>
				<!-- END: ff_option -->
			</select>
		</div>
	</div>
	<div class="form-group">
		<input class="form-control" placeholder="Nhập từ khóa" type="text" name="key" value="{keyword}">
	</div>
	<div class="form-group text-center">
		<button class="btn btn-info">
			{lang.search}
		</button>
	</div>
</form>
<div id="vac_notify" style="color: orange; background: gray; width: fit-content; display: none;"> Chọn hành động </div>
<p>
  {filter_count}
</p>
<div class="vng_body" style="height: 426px;overflow-y: scroll;">
	<table class="table table-border table-striped table-hover">
		<thead>
			<tr>
				<th>
					{lang.customer}
				</th>				
				<th>
					{lang.phone}
				</th>				
				<th>
					{lang.address}
				</th>				
				<th>
					
				</th>
			</tr>
		</thead>
		<tbody id="vac_body">
			<!-- BEGIN: customer -->		
			<tr id="customer_{index}">
				<td>
					<a href="{detail_link}" id="customer_name_{index}">
						{customer}
					</a>
				</td>
				<td id="customer_phone_{index}">
					{phone}
				</td>				
				<td id="customer_address_{index}">
					{address}
				</td>
				<td>
					<button class="btn btn-info" onclick="vac_remove_customer({index})">
						{lang.remove}
					</button>
					<button class="btn btn-info" onclick="vac_get_update_customer({index}, '{customer}', '{phone}', '{address}')">
						{lang.update}
					</button>
				</td>
			</tr>
			<!-- END: customer -->
		</tbody>
	</table>
</div>
<div>
	{nav_link}
</div>
<script>
var g_customer = {id};
function vac_get_update_customer(id, customer, phone, address) {
	g_customer = id;

	document.getElementById("customer").value = customer;
	document.getElementById("phone").value = phone;
	document.getElementById("address").value = address;
	document.getElementById("update").setAttribute("onclick", "vac_update_customer("+ id +")");
}

function vac_update_customer(event) {
	var msg = "";
	if(g_customer) {
		var url = "index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=customer";
		var data = document.getElementsByClassName("vac_val");
		var post_data = ["action=update", "id=" + g_customer];
		var length = data.length;
		for (let index = 0; index < length; index++) {
			post_data.push(data[index].getAttribute("name") + "=" + data[index].value);
		};
		fetch(url, post_data).then(response => {	
			if(response) {
				window.location.reload()
			}
			else {
				msg = "Chưa cập nhật được";
			}
			showMsg(msg);
		})
	}
}

function vac_remove_customer(id) {
	if(confirm("Bạn có muốn xóa khách hàng này không?")) {
		var url = "index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=customer";
		post_data = ["action=remove", "id=" + id];
		fetch(url, post_data).then(response => {
			var msg = "";
			if(response) {
				window.location.reload();
			}
			else {
				msg = "Chưa xoá được";
			}
			showMsg(msg);
		})			
	}
}

function vac_add_customer(e) {
	e.preventDefault();
	var url = "index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=customer";
	var data = document.getElementsByClassName("vac_val");
	var post_data = ["action=add"];
	var length = data.length;
	for (let index = 0; index < length; index++) {
		post_data.push(data[index].getAttribute("name") + "=" + data[index].value);
	};
	fetch(url, post_data).then(response => {
		// clear form
		// add to panel
		
		console.log(response);
		
		var msg = "Lưu thành công";
		if(response) {
			// window.location.reload();
		}
		else {
			var msg = "Chưa lưu được";
		}
		showMsg(msg);
	})
	
	return false;
}

</script>
<!-- END: main -->
