<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th> STT </th>
			<th> {lang.customer} </th>
			<th> {lang.phone} </th>
			<th> Dự sinh </th>
			<th> Trạng thái </th>
			<th> </th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr>
			<td> {id} </td>
			<td> {customer} </td>
			<td> {phone} </td>
			<td> {expecttime} </td>
			<td> {recall} {vacname} </td>
			<td>
				<button class="btn btn-info btn-xs" onclick="update({id})">
					{lang.update}
				</button>
			</td>
		</tr>
		<!-- END: row -->
	</tbody>
</table>
<div id="nav_link">
	{nav_link}
</div>
<!-- END: main -->
