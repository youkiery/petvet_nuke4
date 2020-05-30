<!-- BEGIN: main -->
<div id="msgshow"></div>
<style>
	label {
		width: 100%;
	}

	.error {
		color: red;
		font-size: 1.2em;
		font-weight: bold;
	}
</style>

<h2> Hướng dẫn sử dụng {device_name} </h2>

<div id="content"></div>
<div class="text-center">
  <button class="btn btn-info" onclick="saveManual()">
    Lưu thay đổi
  </button>
</div>

<script src="/modules/core/js/ckeditor/ckeditor.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
  $(document).ready(() => {
    CKEDITOR.replace('content')
    CKEDITOR.instances.content.setData('{data}')
  })

  function saveManual() {
    vhttp.checkelse('', {action: 'save-manual', data: CKEDITOR.instances.content.getData()}).then(data => {
      window.location.replace(data['url'])
    })
  }
</script>
<!-- END: main -->