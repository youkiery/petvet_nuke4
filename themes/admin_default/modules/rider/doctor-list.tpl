<!-- BEGIN: main -->
<table class="table">
    <thead>
      <tr>
        <th>
          STT
        </th>
        <th>
          Tên tài khoản
        </th>
        <th>
          Tên bác sĩ
        </th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <!-- BEGIN: row -->
      <tr>
        <td>
          {index}        
        </td>
        <td>
          {username}
        </td>
        <td>
          {name}
        </td>
        <td>
          <!-- BEGIN: insert -->
          <button class="btn btn-success" onclick="insert({id})">
            Thêm
          </button>
          <!-- END: insert -->
          <!-- BEGIN: remove -->
          <button class="btn btn-danger" onclick="remove({id})">
            Bỏ
          </button>
          <!-- END: remove -->
        </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
  <!-- END: main -->