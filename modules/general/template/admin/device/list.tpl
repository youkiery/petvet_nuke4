<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Tên phòng ban </th>
        <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {name} </td>
        <td>
            <button class="btn btn-info btn-sm" onclick="editDepart({id})">
                sửa
            </button>    
            <button class="btn btn-danger btn-sm" onclick="removeDepart({id})">
                xóa
            </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->
