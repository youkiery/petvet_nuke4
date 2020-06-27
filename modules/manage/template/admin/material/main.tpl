<!-- BEGIN: main -->
{modal}

<div id="msgshow"></div>

<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<script src="/modules/manage/src/script.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script>
  function insertType() {
    vhttp.checkelse('', {action: 'insert-type', name: $('#type-name').val()}).then(data => {
      
    })
  }
</script>
<!-- END: main -->
