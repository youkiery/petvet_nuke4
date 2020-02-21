<!-- BEGIN: main -->
<div class="form-group">
	<!-- BEGIN: button -->
	<a href="{recall_link}" class="btn {recall_select}">
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
				STT
			</th>
			<th>
				{lang.customer}
			</th>
			<th>
				{lang.phone}
			</th>
			<th>
				Ngày dự sinh
			</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<!-- BEGIN: row -->
		<tr style="text-transform: capitalize;" class="{bgcolor}">
			<td>
				{index}
			</td>
			<td class="customer">
				{customer}
			</td>
			<td class="sieuam">
				{phone}
			</td>
			<td class="dusinh">
				{expecttime}
			</td>
			<td class="confirm">
				<!-- BEGIN: right -->
				<button class="btn left btn-sm" onclick="changeRecall({id}, 0)">
					&lt;
				</button>
				<button class="btn btn-info btn-sm" type="button" onclick='birth({id})'>
					Đã sinh
				</button><br>
				<!-- END: right -->
				<!-- BEGIN: left -->
				<button class="btn right btn-sm" onclick="changeRecall({id}, 1)">
					&gt;
				</button>
				<!-- END: left -->
				<span>
					Dự kiến: {expectnumber}
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
<!-- END: main -->