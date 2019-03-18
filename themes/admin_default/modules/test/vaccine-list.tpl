<!-- BEGIN: main -->
<table class="table table-striped table-hover table-border">
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
				{lang.vacdoctor}
			</th>
			<th>
				{lang.disease}
			</th>
			<th>
				{lang.vaccome}
			</th>
			<th>
				{lang.vaccall}
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
				{disease}
			</td>
			<td>
				{cometime}
			</td>
			<td>
				{calltime}
			</td>
			<!-- <td>
				{calltime2}
			</td> -->
			<td>
				<button class="btn btn-info" onclick="xoasieuam({id})">
					{lang.remove}
				</button>
				<button class="btn btn-info" onclick="open_edit(event, {id})" data-toggle="modal" data-target="#vaccineupdate">
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
