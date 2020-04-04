<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th> Khách hàng </th>
			<th> Số điện thoại </th>
			<th> Ngày sinh </th>
			<th> Số con </th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr style="text-transform: capitalize;" class="{bgcolor}">
			<td> {customer} </td>
			<td> {phone} </td>
			<td> {birthtime} </td>
			<td> {number} </td>
			<td>
				<button class="btn btn-info btn-xs" onclick="vaccineRecall({id})">
					Tái chủng
				</button>
				<button class="btn btn-info btn-xs" onclick="rejectRecall({id})">
					Bỏ qua
				</button>
			</td>
		</tr>
		<!-- END: row -->
	</tbody>
</table>
<!-- END: main -->