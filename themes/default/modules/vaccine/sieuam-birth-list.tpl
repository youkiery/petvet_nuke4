<!-- BEGIN: main -->  
<!-- BEGIN: list -->  
<tr style="text-transform: capitalize;" img="{image}" id="{id}">
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
    {exbirth}
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
    <button class='btn left' onclick="confirm_lower({index}, {id}, {petid})">
      &lt;
    </button>
    <button class='btn right' onclick="confirm_upper({index}, {id}, {petid})">
      &gt;
    </button>
    <p id="vac_confirm_{index}" style="color: {color};">
      {confirm}
    </p>
    <!-- BEGIN: recall_link -->
    <button class='btn btn-info' id="recall_{index}" onclick="recall({index}, {id}, {petid})" data-toggle="modal" data-target="#vaccineusg">
      {lang.recall}
    </button>
    <!-- END: recall_link -->
  </td>    
</tr>
<!-- END: list -->
<!-- END: main -->

