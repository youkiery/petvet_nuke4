<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Tài khoản </th>
        <th> Người dùng </th>
        <th>  </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {username} </td>
        <td> {fullname} </td>
        <td> 
            <button class="btn btn-danger" onclick="removeAllower({id})">
                <span class="glyphicon glyphicon-remove"></span>
            </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->
