<!-- BEGIN: main -->
	<form method="GET">
		<input type="hidden" name="nv" value="{nv}">
		<input type="hidden" name="op" value="{op}">
		<div class="row">
			<div class="form-group col-md-12">
				<label>
					{lang.sort}
				</label>
				<select class="form-control" name="sort">
					<!-- BEGIN: fs_option -->
					<option value="{fs_value}" {fs_select}>
						{fs_name}
					</option>
					<!-- END: fs_option -->
				</select>
			</div>
			<div class="form-group col-md-12">
				<label>
					{lang.count}
				</label>
				<select class="form-control" name="filter">
					<!-- BEGIN: ff_option -->
					<option value="{ff_value}" {ff_select}>
						{ff_name}
					</option>
					<!-- END: ff_option -->
				</select>
			</div>
		</div>
		<div class="form-group">
			<input class="form-control" placeholder="Nhập từ khóa" type="text" name="key" value="{keyword}">
		</div>
		<div class="form-group text-center">
			<button class="btn btn-info">
				{lang.search}
			</button>
		</div>
	</form>
<p>
    {filter_count}
</p>
<div class="vng_body" style="height: 426px;overflow-y: scroll;">
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
				</tr>
			</thead>
			<tbody id="vac_body">
				<!-- BEGIN: patient -->		
				<tr id="patient_{index}">
					<td id="patient_index_{index}">
						{index}
					</td>				
					<td>
						<a href="{detail_link}"  id="patient_petname_{index}">
							{petname}
						</a>
					</td>				
					<td>
						<a href="{detail_link2}"  id="patient_customer_{index}">
							{customer}
						</a>
					</td>				
					<td id="patient_phone_{index}">
						{phone}
					</td>
				</tr>
				<!-- END: patient -->
			</tbody>
		</table>
	</div>
	<div>
		{nav_link}
	</div>
	<!-- END: main -->