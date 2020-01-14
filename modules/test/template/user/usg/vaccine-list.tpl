<!-- BEGIN: main -->
<div class="form-group">
	<!-- BEGIN: button -->
	<a href="{recall_link}"  class="btn {recall_select}">
		{recall_name}
	</a>
	<!-- END: button -->
</div>

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
				{lang.usgbirth}
			</th>
			<th>
				{lang.usgbirthday}
			</th>
			<th>
				{lang.vacday}
			</th>
			<th>

			</th>
		</tr>
	</thead>
	<!-- BEGIN: list -->
	<tr style="text-transform: capitalize;" class="{bgcolor}" id="{id}">
		<td>
			{index}
		</td>
		<td class="detail">
			{customer}
		</td>
		<td class="detail">
			{phone}
		</td>
		<td class="detail">
			{birth}
		</td>
		<td class="detail">
			{birthday}
		</td>
		<td class="detail">
			{vacday}
		</td>
		<td class="confirm">
			<button class='btn left' onclick="changeVaccineStatus({id}, 0)">
				&lt;
			</button>
			<button class='btn right' onclick="changeVaccineStatus({id}, 1)">
				&gt;
			</button>
			<p id="vac_confirm_{index}" style="color: {color};">
				{confirm}
			</p>
		</td>
	</tr>
	<!-- END: list -->
</table>
<!-- END: main -->