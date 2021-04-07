<!-- BEGIN: disease -->
    	<!-- BEGIN: vac_body -->  
    	<tr style="text-transform: capitalize;">
      	<td>
        	{index}
      	</td>    
      	<td>
        	{petname}
      	</td>    
      	<td>
        	{customer}
      	</td>    
      	<td>
        	{phone}
      	</td>    
      	<td>
        	{disease}
				</td>    
      	<td>
        	{cometime}
      	</td>    
      	<td class="calltime">
        	{calltime}
				</td>    
				<td class="confirm">
					<button class="btn left" onclick="confirm_lower({index}, {vacid}, {petid}, {diseaseid})">
						&lt;
					</button>
					<button class="btn right" style="float: right;" onclick="confirm_upper({index}, {vacid}, {petid}, {diseaseid})">
						&gt;
					</button>
          <span id="vac_confirm_{diseaseid}_{index}" style="color: {color};">
            {confirm}
          </span>
					<!-- BEGIN: recall_link -->
						<button class="btn btn-info" id="recall_{index}" data-toggle="modal" data-target="#vaccinedetail" onclick="recall({index}, {vacid}, {petid}, {diseaseid})">
							{lang.recall}
						</button>
					<!-- END: recall_link -->
				</td>
				</td>
			</tr>
			<tr class="note" style="display: {cnote}" id="note_{diseaseid}_{vacid}">
				<td colspan="9" id="note_v{diseaseid}_{vacid}">
					{note}
					<button class="btn btn-info right" onclick="deadend({vacid})">
						{lang.deadend}
					</button>
					<button class="btn btn-info right" onclick="miscustom({vacid})">
						{lang.miscustom}
					</button>
					<img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú" onclick="editNote({vacid}, {diseaseid})">
				</td>
			</tr>
    	<!-- END: vac_body -->
<br>
<!-- END: disease -->
