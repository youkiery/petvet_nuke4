<!-- BEGIN: main -->
<table class="table">
  <thead>
    <tr>
      <th colspan="6">
        Danh sách nhắc tiêm phòng chưa nhắc
      </th>
    </tr>
    <tr>
      <th> STT </th>
      <th> Tên khách </th>
      <th> Số điện thoại </th>
      <th> Ngày nhắc </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {customer} </td>
      <td> {phone} </td>
      <td> {calltime} </td>
      <td class="confirm">
					<button class="btn left" onclick="lower({id})">
						&lt;
					</button>
					<button class="btn right" style="float: right;" onclick="upper({id})">
						&gt;
					</button>
          <span id="confirm_{index}" style="color: {color};">
            {confirm}
          </span>
					<!-- BEGIN: recall -->
						<button class="btn btn-info" id="recall_{index}" onclick="recall({id})">
							Tái chủng
						</button>
					<!-- END: recall -->
				</td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->