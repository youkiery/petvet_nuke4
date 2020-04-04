<!-- BEGIN: main -->
<div class="form-group">
	<!-- BEGIN: button -->
	<a href="{recall_link}" class="btn {recall_select}">
		{recall_name}
	</a>
	<!-- END: button -->
</div>
<div style="clear: both;"></div>
<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th class="cell-center"> Khách hàng </th>
			<th class="cell-center"> {lang.phone} </th>
			<th class="cell-center"> Dự sinh </th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr style="text-transform: capitalize;" class="{bgcolor}">
			<td> {customer} </td>
			<td> {phone} </td>
			<td> {expecttime} </td>
			<td rowspan="2" class="confirm">
				<!-- BEGIN: right -->
				<button class="btn left btn-xs" onclick="changeRecall({id}, 0)">
					&lt;
				</button>
				<button class="btn btn-info btn-xs" type="button" onclick='birth({id})'>
					Đã sinh
				</button><br>
				<!-- END: right -->
				<!-- BEGIN: left -->
				<button class="btn right btn-xs" onclick="changeRecall({id}, 1)">
					&gt;
				</button>
				<!-- END: left -->
				<span> <b> Dự kiến: {expectnumber} </b> </span>
			</td>
		</tr>
		<tr class="{bgcolor}" id="note_{id}">
			<td colspan="3" id="note_v{id}">
				{note}
				<!-- BEGIN: note -->
				<img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú"
				onclick="editNote({id})">
				<!-- END: note -->
			</td>
		</tr>
		<!-- END: row -->
	</tbody>
</table>
<!-- END: main -->