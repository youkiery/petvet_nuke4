<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>
				{lang.index}
			</th>
			<th>
				{lang.customer}
			</th>
			<th>
				{lang.phone}
			</th>
			<th>
				{lang.usgcall}
			</th>
			<th>
				{lang.birth}
			</th>
			<th>
				{lang.vaccine}
			</th>
			<th>
			
			</th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr id="ss_{id}">
			<td>
				{stt}
			</td>
			<td>
				{customer}
			</td>
			<td>
				{phone}
			</td>
			<td>
				{calltime}
			</td>
			<td>
				{birth}
			</td>
			<td>
				{recall} {vacname}
			</td>
			<td>
				<!-- <button class="btn btn-danger btn-xs" onclick="removeUsg({id})">
					{lang.remove}
				</button> -->
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
