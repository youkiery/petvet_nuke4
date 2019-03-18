<!-- BEGIN: main -->
<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th>
				{lang.index}
			</th>
			<th>
				{lang.petname}
			</th>
			<th>
				{lang.customer}
			</th>
			<th>
				{lang.phone}
			</th>
			<th>
				{lang.doctor}
			</th>
			<th>
				{lang.usgcome}
			</th>
			<th>
				{lang.usgcall}
			</th>
			<th>
				{lang.exbirth}
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
				<a href="{pet_link}">
					{petname}
				</a>
			</td>
			<td>
				<a href="{customer_link}">
					{customer}
				</a>
			</td>
			<td>
				{phone}
			</td>
			<td>
				{doctor}
			</td>
			<td>
				{cometime}
			</td>
			<td>
				{calltime}
			</td>
			<td>
				{exbirth}
			</td>
			<td>
				{birth}
			</td>
			<td>
				{recall} {vacname}
			</td>
			<td>
				<button class="btn btn-info" onclick="xoasieuam({id})">
					{lang.remove}
				</button>
				<button class="btn btn-info" onclick="update(event, {id})" data-toggle="modal" data-target="#usgupdate">
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
