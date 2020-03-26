<!-- BEGIN: main -->
<tr>
  <td>
    {customer_name}
  </td>
  <td>
    {customer_number}
  </td>
  <td> {drug} </td>
  <!-- <td>
    {drug_from}
  </td> -->
  <td>
    {drug_end}
  </td>
  <td class="text-center">
    <button class="btn left" onclick="confirm({id}, 'down')">
    	&lt;
    </button>
    <button class="btn right" onclick="confirm({id}, 'up')">
   		&gt;
   	</button>
   	<span id="confirm_{id}" style="color: {color};">
   		{status}
   	</span>
  </td>
</tr>
<tr class="note">
  <td colspan="6">
    <span id="note_{id}">
      {note}
    </span>
    <!-- <button class="btn btn-info right" onclick="miscustom({id})">
      {lang.miscustom}
    </button> -->
    <img class="mini-icon right" src="/themes/default/images/vaccine/note_add.png" alt="thêm ghi chú" onclick="editNote({id})">
  </td>
</tr>
<!-- END: main -->
