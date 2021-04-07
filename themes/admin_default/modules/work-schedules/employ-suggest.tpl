<!-- BEGIN: main -->
<table class="table">
  <thead>
    <tr>
      <th>
        {lang.user}
      </th>
      <th>
        {lang.user_main}
      </th>
      <th>
        {lang.delete}
      </th>
      <th>
        {lang.depart_name}
      </th>
    </tr>
  </thead>
  <tbody>
    <tbody>
      <!-- BEGIN: row -->
      <tr>
        <td>
          <label class="radio-inline">
            <input type="radio" name="{id}" class="edit_depart" id="s_{id}" {check1}>
          </label>
        </td>        
        <td>
          <label class="radio-inline">
            <input type="radio" name="{id}" class="edit_depart2" id="a_{id}" {check2}>
          </label>
        </td>
        <td>
          <span class="btn" onclick="diselect({id})">
            x
          </span>
        </td>
        <td>
          {depart}
        </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </tbody>  
</table>

<!-- END: main -->
