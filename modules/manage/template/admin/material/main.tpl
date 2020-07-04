<!-- BEGIN: main -->
<style>
  .relative {
    position: relative;
  }

  .suggest {
    position: absolute;
    width: 100%;
    background: #fff;
    max-height: 400px;
    overflow-y: scroll;
    z-index: 10;
    display: none;    
  }

  .suggest-item {
    border-bottom: 1px solid gray;
    padding: 10px;
  }

  .suggest-item:hover {
    background: lightgreen;
  }
</style>

<div id="msgshow"></div>
{modal}

<div class="form-group relative">
  <input type="text" class="form-control" id="detail-name" placeholder="Nhập tên nhân viên">
  <div class="suggest" id="detail-name-suggest"></div>
</div>

<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-7.js"></script>
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

	function insertEmploy(id) {
		vhttp.checkelse('', { action: 'insert-employ', id: id, name: $("#detail-name").val() }).then((data) => {
			$("#content").html(data['html'])
			$("#detail-name-suggest").html(data['html2'])
		})
	}

	function removeEmploy(id) {
		vhttp.checkelse('', { action: 'remove-employ', id: id }).then((data) => {
			$("#content").html(data['html'])
		})
	}

  function changePermit(id, type) {
		vhttp.checkelse('', { action: 'change-permit', id: id, type: type }).then((data) => {
			$("#content").html(data['html'])
		})
	}
</script>
<!-- END: main -->
