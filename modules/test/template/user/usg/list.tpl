<!-- BEGIN: main -->
			<!-- BEGIN: list -->  
			<tr style="text-transform: capitalize;" id="{vacid}">
				<td  data-toggle="modal" data-target="#usgdetail">
					{index}
				</td>    
				<td class="customer" data-toggle="modal" data-target="#usgdetail">
					{customer}
				</td>
				<td class="sieuam" data-toggle="modal" data-target="#usgdetail">
					{phone}
				</td>    
				<td class="sieuam" data-toggle="modal" data-target="#usgdetail">
					{sieuam}
				</td>    
				<td class="dusinh" data-toggle="modal" data-target="#usgdetail">
					{dusinh}
				</td> 
				<td class="confirm">
					<button class="btn left" onclick="confirm_lower({index}, {vacid}, {petid})">
						&lt;
					</button>
					<button class="btn right" onclick="confirm_upper({index}, {vacid}, {petid})">
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
						<button class="btn btn-info" type="button" data-toggle="modal" data-target="#usgrecall" onclick='birth({index}, {vacid}, {petid})' {checked}>{birth}</button>
						<!-- END: birth -->
					</span>
				</td>
			</tr>
			<tr class="note" style="display: {cnote}" id="note_{vacid}">
				<td colspan="9" id="note_v{vacid}">
					{note}
					<button class="btn btn-info right" onclick="deadend({vacid})">
						{lang.deadend}
					</button>
					<button class="btn btn-info right" onclick="miscustom({vacid})">
						{lang.miscustom}
					</button>
					<img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú" onclick="editNote({vacid})">
				</td>
			</tr>
		<!-- END: list -->
<br>
<!-- END: main -->
