<!-- BEGIN: main -->
<div class="form-group">
	<!-- BEGIN: button -->
	<a href="{recall_link}"  class="btn {recall_select}">
		{recall_name}
	</a>
	<!-- END: button -->
	<div style="float: right;">
		<button class="btn btn-info" onclick="noteToggle()">
			Ẩn/hiện ghi chú
		</button>
	</div>
</div>
<div style="clear: both;"></div>
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
				{lang.usgcome}
			</th>
			<th>
				{lang.usgcall}
			</th>
			<th>
				{lang.usgconfirm}
			</th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr style="text-transform: capitalize;" id="{vacid}">
			<td>
				{index}
			</td>
			<td class="customer">
				{customer}
			</td>
			<td class="sieuam">
				{phone}
			</td>
			<td class="sieuam">
				{sieuam}
			</td>
			<td class="dusinh">
				{dusinh}
			</td>
			<td class="confirm">
				<button class="btn left" onclick="changeStatus({id}, 0)">
					&lt;
				</button>
				<button class="btn right" onclick="changeStatus({id}, 1)">
					&gt;
				</button>

				<span id="vac_confirm_{index}" style="color: {color};">
					{status}
				</span>
				<br>
				<span>
					{lang.usgexpect} {exbirth}
				</span>
				<span id='birth_{index}'>
					<!-- BEGIN: birth -->
					, {lang.usgreal}
					<button class="btn btn-info" type="button" data-toggle="modal" data-target="#usgrecall"
						onclick='birth({index}, {vacid}, {petid})' {checked}>{birth}</button>
					<!-- END: birth -->
				</span>
			</td>
		</tr>
		<tr class="note" style="display: none;" id="note_{id}">
			<td colspan="9" id="note_v{id}">
				{note}
				<img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú"
					onclick="editNote({id})">
			</td>
		</tr>
		<!-- END: row -->
	</tbody>
</table>
{nav_link}
<!-- END: main -->