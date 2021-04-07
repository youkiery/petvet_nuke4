<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

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

<div id="modal">
	{modal}
</div>

<!-- <div class="form-group input-group">
    <input type="text" class="form-control" id="name" placeholder="Nhập tên phòng ban">
    <div class="input-group-btn">
        <button class="btn btn-success" onclick="insertDepart()">
            Thêm phòng ban
        </button>
    </div>
</div> -->

<div class="form-group" style="float: right;">
	<button class="btn btn-info" onclick="managerList()">
		Quản lý
	</button>
	<button class="btn btn-info" onclick="departList()">
		Phòng, tầng
	</button>
	<button class="btn btn-success" onclick="deviceInsert()">
		Thêm thiết bị
	</button>
</div>

<div style="clear: both;"></div>

<div class="form-group">
	<div class="input-group">
		<input type="text" class="form-control" id="config" placeholder="Số ngày báo cáo" value="{config}">
		<div class="input-group-btn">
			<button class="btn btn-info" onclick="saveConfig()">
				Lưu cấu hình
			</button>
		</div>
	</div>
</div>

<div class="error" id="error"></div>

<div id="content">
	{content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
	var global = {
		id: 0,
		page: {
			'main': 1
		},
		selected: {
			filter: {},
			device: {}
		},
		filter: {
			selected: {}
		},
		list: JSON.parse('{depart}'),
		today: '{today}',
		remind: JSON.parse('{remind}'),
		remindv2: JSON.parse('{remindv2}'),
		depart: 0,
		prefix: ''
	}
	installDepart = (input) => {
		return new Promise(resolve => {
			html = ''
			count = 0

			global['list'].forEach((depart, index) => {
				if (count < 30 && depart['name'].search(input) >= 0) {
					count++
					html += `
							<div class="suggest-item" onclick="selectDepart('`+ global['prefix'] + `', ` + index + `)">
								`+ depart['name'] + `
							</div>`
				}
			})
			if (!html.length) {
				html = 'Không có kết quả'
			}
			resolve(html)
		})
	}

	$(document).ready(() => {
		vremind.install("#device-depart-input", "#device-depart-suggest", installDepart, 300, 300)
		vremind.install("#detail-name", "#detail-name-suggest", input => {
			return new Promise(resolve => {
				vhttp.checkelse('', { action: 'get-employ', name: input }).then(data => {
					resolve(data['html'])
				})
			})
		}, 300, 300)
		vremind.install("#manager-name", "#manager-name-suggest", input => {
			return new Promise(resolve => {
				vhttp.checkelse('', { action: 'get-manager', name: input }).then(data => {
					resolve(data['html'])
				})
			})
		}, 300, 300)
	})

	function editDepart(id) {
		vhttp.checkelse('', { action: 'edit-depart', name: $("#depart-name-" + id).val(), id: id }).then((data) => {
			global['list'] = data['json']
			// do nothing
		})
	}

	function insertDepart() {
		name = $("#device-depart-input").val()
		if (!name.length) errorText('Nhập tên phòng trước khi thêm', 'depart')
		else {
			vhttp.checkelse('', { action: 'insert-depart', name: name }).then((data) => {
        console.log(data);
        if (data['notify']) errorText(data['notify'], 'depart')
        else {
          
          global['list'] = data['json']
          global['selectd']['device'][global['list'].length - 1] = 1
          html = '<span class="btn btn-info btn-xs" onclick="deselectDepart(\'' + prefix + '\', ' + key + ')"> ' + global['list'][key]['name'] + ' </span>'
      		$("#device-depart").html($("#" + prefix + "-depart").html() + html)
        }
			})
		}
	}

	function employFilter() {
		vhttp.checkelse('', { action: 'employ-filter', name: $("#employ-name").val() }).then((data) => {
			$("#employ-content").html(data['html'])
		})
	}

	function insertEmploy(id) {
		vhttp.checkelse('', { action: 'insert-employ', id: id, name: $("#detail-name").val(), departid: global['depart'] }).then((data) => {
			$("#detail-content").html(data['html'])
			$("#detail-name-suggest").html(data['html2'])
		})
	}

	function insertManager(id) {
		vhttp.checkelse('', { action: 'insert-manager', id: id, name: $("#manager-name").val() }).then((data) => {
			$("#manager-content").html(data['html'])
			$("#manager-name-suggest").html(data['html2'])
		})
	}

	function removeManager(id) {
		vhttp.checkelse('', { action: 'remove-manager', id: id, name: $("#manager-name").val() }).then((data) => {
			$("#manager-content").html(data['html'])
			$("#manager-name-suggest").html(data['html2'])
		})
	}

	function removeEmploy(id) {
		vhttp.checkelse('', { action: 'remove-employ', id: id, departid: global['depart'] }).then((data) => {
			$("#detail-content").html(data['html'])
		})
	}

	function updateDepartSubmit() {
		vhttp.checkelse('', { action: 'update-depart', departid: global['depart'], name: $("#depart-name").val() }).then((data) => {
			$("#content").html(data['html'])
		})
	}

	function errorText(txt, label = '') {
    selector = 'error'
    if (label) selector = label + '-' + selector
		$("#" + selector).text(txt)
		$("#" + selector).show()
		$("#" + selector).fadeOut(3000)
	}

	function deviceInsert() {
		$("#device-name").val('')
		$("#device-unit").val('')
		$("#device-number").val('')
		$("#device-year").val('')
		$("#device-intro").val('')
		$("#device-source").val('')
		$("#device-status").val('')
		$("#device-description").val('')
		$("#device-import-time").val(global['today'])
		$("#device-insert").show()
		$("#device-edit").hide()
		global['selected']['device'] = {}
		global['prefix'] = 'device'
		$("#device-depart").html('')
		$('#device-modal').modal('show')
	}

	function deviceInsertSubmit() {
		data = checkDeviceData()
		if (!data['name']) alert_msg(data)
		else {
			vhttp.checkelse('', { action: 'insert-device', data: data }).then(data => {
				$("#content").html(data['html'])
				$("#device-name").val('')
				$("#device-unit").val('')
				$("#device-number").val('')
				$("#device-year").val('')
				$("#device-intro").val('')
				$("#device-source").val('')
				$("#device-status").val('')
				$("#device-description").val('')
				global['depart']['selected'] = {}
				$("#device-depart").html('')
				$('#device-modal').modal('hide')
			})
		}
	}

	function checkDeviceData() {
		list = []
		for (const key in global['selected']['device']) {
			if (global['selected']['device'].hasOwnProperty(key)) {
				list.push(global['list'][key]['id'])
			}
		}
		name = $("#device-name").val()

		if (!name.length) {
			return 'Điền tên thiết bị'
		}

		return {
			name: name,
			unit: $("#device-unit").val(),
			number: $("#device-number").val(),
			year: $("#device-year").val(),
			intro: $("#device-intro").val(),
			source: $("#device-source").val(),
			status: $("#device-status").val(),
			depart: list,
			description: $("#device-description").val(),
			import: $("#device-import-time").val()
		}
	}

	function loadDefault() {
		$("#device-name").val()
		$("#device-unit").val(global['remind']['unit'])
		$("#device-number").val(global['remind']['number'])
		$("#device-year").val(global['remind']['year'])
		$("#device-intro").val(global['remind']['intro'])
		$("#device-source").val(global['remind']['source'])
		$("#device-status").val(global['remind']['status'])
		$("#device-import-time").val(global['today'])
		$("#device-import-description").val('')
	}

	function selectDepart(prefix, index) {
		global['selected'][prefix][index] = 1
		$("#" + prefix + "-depart-input").val('')
		val = []
		for (const key in global['selected'][prefix]) {
			if (global['selected'][prefix].hasOwnProperty(key)) {
				val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart(\'' + prefix + '\', ' + key + ')"> ' + global['list'][key]['name'] + ' </span>')
			}
		}

		$("#" + prefix + "-depart").html(val.join(', '))
	}

	function deselectDepart(prefix, index) {
		delete global['selected'][prefix][index]
		val = []
		for (const key in global['selected'][prefix]) {
			if (global['selected'][prefix].hasOwnProperty(key)) {
				val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart(\'' + prefix + '\', ' + key + ')"> ' + global['list'][key]['name'] + ' </span>')
			}
		}

		$("#" + prefix + "-depart").html(val.join(', '))
	}

	function deviceEditSubmit() {
		data = checkDeviceData()
		if (!data['name']) alert_msg(data)
		else {
			vhttp.checkelse('', { action: 'edit-device', data: data, id: global['id'] }).then(data => {
				$("#content").html(data['html'])
				$('#device-modal').modal('hide')
			})
		}
	}

	function deviceEdit(id) {
		vhttp.checkelse('', { action: 'get-device', id: id }).then(data => {
			$("#content").html(data['html'])
			$("#device-name").val(data['device']['name'])
			$("#device-unit").val(data['device']['unit'])
			$("#device-number").val(data['device']['number'])
			$("#device-year").val(data['device']['year'])
			$("#device-intro").val(data['device']['intro'])
			$("#device-source").val(data['device']['source'])
			$("#device-status").val(data['device']['status'])
			$("#device-description").val(data['device']['description'])
			$("#device-import-time").val(data['device']['import'])
			$("#device-insert").hide()
			$("#device-edit").show()
			global['selected']['depart'] = {}
			data['device']['depart'].forEach(depart => {
				global['list'].forEach((item, index) => {
					if (item['id'] == depart) {
						selectDepart('device', index)
					}
				})
			})
			global['id'] = id
			global['prefix'] = 'device'
			$('#device-modal').modal('show')
		})
	}

	function departList() {
		$("#depart-modal").modal('show')
	}

	function managerList() {
		$("#manager-modal").modal('show')
	}

	function itemDetail(id) {
		vhttp.checkelse('', { action: 'get-detail', id: id }).then(data => {
			global['depart'] = id
			$("#detail-content").html(data['html'])
			$("#detail-modal").modal('show')
		})
	}

	function removeDepart(id) {
		vhttp.checkelse('', { action: 'remove-depart', id: id }).then(data => {
			global['list'] = data['json']
			$("#depart-content").html(data['html'])
		})
	}

	function insertDepartSubmit() {
		vhttp.checkelse('', { action: 'insert-depart2', name: $("#depart-name").val() }).then(data => {
			global['list'] = data['json']
			$("#depart-content").html(data['html'])
		})
	}

	function saveConfig() {
		vhttp.checkelse('', { action: 'save-config', value: $("#config").val() }).then(data => {
			// do nothing
		})
	}

	function deviceRemove(id) {
		global['id'] = id
		$("#remove-modal").modal('show')
	}

	function removeDeviceSubmit() {
		vhttp.checkelse('', { action: 'remove-device', id: global['id'] }).then(data => {
			$("#content").html(data['html'])
			$("#remove-modal").modal('hide')
		})
	}
</script>
<!-- END: main -->