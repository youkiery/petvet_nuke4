<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Nhóm </th>
        <th> Giá trị </th>
        <th>  </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {name} </td>
        <td> <input type="text" class="form-control" id="value-{id}" value="{value}"> </td>
        <td> 
            <button class="btn btn-info btn-sm" onclick="updateRemind({id})">
                <span class="glyphicon glyphicon-refresh"></span>
            </button>
            <button class="btn btn-danger btn-sm" onclick="removeRemind({id})">
                <span class="glyphicon glyphicon-remove"></span>
            </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->
