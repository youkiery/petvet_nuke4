<!-- BEGIN: main -->
<form class="vac_form" method="GET">
	<input type="hidden" name="nv" value="{nv}">
	<p>
		Từ khóa:
		<input class="form-control" type="text" name="key" value="{keyword}">
	</p>

  <select id="f_sort" name="sort" class="form-control">
    <!-- BEGIN: fs_time -->
    <option value="{sort_value}" {fs_select}>
      {sort_name}
    </option>
    <!-- END: fs_time -->
  </select>
  <select id="f_moment" name="time" class="form-control">
    <!-- BEGIN: fo_time -->
    <option value="{time_amount}" {fo_select}>
      {time_name}
    </option>
    <!-- END: fo_time -->
  </select>
  <input type="submit" class="btn btn-info" value="{lang.save}">
</form>
{table}
<script>
  var link = "/adminpet/index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=main&act=post";
</script>
<!-- END: main -->