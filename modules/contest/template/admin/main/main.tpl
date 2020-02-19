<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/contest/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/core/js/vhttp.js">

</script>
<div id="msgshow"></div>
<style>
  .form-group { clear: both; }
</style>

<div id="content">
  {content}
</div>

<script>
  var global = {
    type: {0: 'btn btn-info', 1: 'btn btn-warning'}
  }
  function activeSubmit(id, type) {
    $("[rel=" + id + "]").prop('disabled', true)
    vhttp.check('', { action: 'active', id: id, type: type}).then((data) => {
      $("[rel=" + id + "]").prop('disabled', false)
      $("[rel=" + id + "]").attr('class', global['type'][type])
    }, () => {
      $("[rel=" + id + "]").prop('disabled', false)
    })
  }
</script>
<!-- END: main -->
