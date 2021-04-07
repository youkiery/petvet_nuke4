<!-- BEGIN: main -->
{modal}

<div class="form-group relative">
  <input type="text" class="form-control" id="detail-name" placeholder="Nhập tên nhân viên">
  <div class="suggest" id="detail-name-suggest"></div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
	$(document).ready(() => {
		vremind.install("#detail-name", "#detail-name-suggest", input => {
			return new Promise(resolve => {
				vhttp.checkelse('', { action: 'get-employ', name: input }).then(data => {
					resolve(data['html'])
				})
			})
		}, 300, 300)
  })
  
  function removeEmploy(id) {
    vhttp.checkelse('', { action: 'remove-employ', id: id }).then((data) => {
      $("#content").html(data['html'])
    })
  }

  function insertEmploy(id) {
		vhttp.checkelse('', { action: 'insert-employ', id: id, name: $("#detail-name").val() }).then((data) => {
			$("#content").html(data['html'])
			$("#detail-name-suggest").html(data['html2'])
		})
	}
</script>
<!-- END: main -->