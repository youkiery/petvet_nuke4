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
        <td> <input type="text" class="form-control" id="depart-name-{id}" value="{name}"> </td>
        <td>
            <button class="btn btn-info btn-xs" onclick="editDepart({id})">
                cập nhật
            </button>    
            <button class="btn btn-info btn-xs" onclick="detailDepart({id})">
                chi tiết
            </button>    
            <button class="btn btn-danger btn-xs" onclick="removeDepart({id})">
                xóa
            </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->
