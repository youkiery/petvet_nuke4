<!-- BEGIN: main -->
<table class="table">
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
				{lang.doctor2}
			</th>
			<th>
				{lang.treat_day}
			</th>
			<th>
				{lang.pet_status}
			</th>
			<th>
				{lang.insult}
			</th>
			<th>
			
			</th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr id="{id}" style="background: {bgcolor}">
			<td class="index" data-toggle="modal" data-target="#treatdetail">
				{stt}
			</td>
			<td class="petname" data-toggle="modal" data-target="#treatdetail">
				{petname}
			</td>
			<td class="customer" data-toggle="modal" data-target="#treatdetail">
				{customer}
			</td>
			<td class="doctor" data-toggle="modal" data-target="#treatdetail">
				{doctor}
			</td>
			<td class="luubenh" data-toggle="modal" data-target="#treatdetail">
				{luubenh}
			</td>
			<td class="tinhtrang" data-toggle="modal" data-target="#treatdetail">
				{tinhtrang}
			</td>
			<td class="ketqua" data-toggle="modal" data-target="#treatdetail">
				{ketqua}
			</td>
			<td>
				<button class="btn btn-info" onclick="delete_treat({id})">
					{lang.remove}
				</button>
				<button class="btn btn-info" onclick="update(event, {id})"  data-toggle="modal" data-target="#treatupdate">
					{lang.update}
				</button>
			</td>
      <td style="display: none;" class="lieutrinh">
        {lieutrinh}
      </td>
		</tr>
		<!-- END: row -->
	</tbody>
</table>
<div id="nav_link">
		{nav_link}
	</div>
<!-- END: main -->
