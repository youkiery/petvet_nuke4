<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Tài khoản </th>
        <th> Họ tên </th>
        <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {username} </td>
        <td> {fullname} </td>
        <td>
            <button class="btn btn-danger btn-sm" onclick="removeManager({id})">
                xóa
            </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->
