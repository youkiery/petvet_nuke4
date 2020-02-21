<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th> STT </th>
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
			<td> {index} </td>
			<td> {customer} </td>
			<td> {phone} </td>
			<td> {birthtime} </td>
			<td> {number} </td>
			<td>
				<button class="btn btn-info btn-sm" onclick="vaccineRecall({id})">
					Tiêm vaccine
				</button>
				<button class="btn btn-info btn-sm" onclick="rejectRecall({id})">
					Bỏ tiêm vaccine
				</button>
			</td>
		</tr>
		<!-- END: row -->
	</tbody>
</table>
<!-- END: main -->