<!-- BEGIN: main -->
<table class="table table-bordered">
    <tr>
        <th> STT </th>
        <th> Thời gian </th>
        <th> Số lượng </th>
        <th> Loại phiếu </th>
        <th class="{show}"> </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {time} </td>
        <td> {number} </td>
        <td> {type} </td>
        <td class="{show}">
            <!-- BEGIN: test -->
            <button class="btn btn-info btn-sm" onclick="edit({typeid}, {id})">
                <span class="glyphicon glyphicon-edit"></span>
            </button>
            <button class="btn btn-danger btn-sm" onclick="remove({typeid}, {id})">
                <span class="glyphicon glyphicon-remove"></span>
            </button>
            <!-- END: test -->
        </td>
    </tr>
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->