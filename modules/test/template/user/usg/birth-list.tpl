<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th> Khách hàng </th>
			<th> Số điện thoại </th>
			<th> Ngày sinh </th>
			<th> Số con </th>
			<!-- BEGIN: manager -->
			<th></th>
			<!-- END: manager -->
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr style="text-transform: capitalize;" class="{bgcolor}">
			<td> {customer} </td>
			<td> {phone} </td>
			<td> {birthtime} </td>
			<td> {number} </td>
			<!-- BEGIN: manager2 -->
			<td>
				<button class="btn btn-info btn-xs" onclick="vaccineRecall({id})">
					Tái chủng
				</button>
				<button class="btn btn-info btn-xs" onclick="rejectRecall({id})">
					Bỏ qua
				</button>
			</td>
			<!-- END: manager2 -->
		</tr>
		<!-- END: row -->
	</tbody>
</table>
<!-- END: main -->