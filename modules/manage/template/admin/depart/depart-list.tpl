<!-- BEGIN: main -->
<table class="table table-bordered">
    <tr>
        <th> STT </th>
        <th> <input type="checkbox" id="depart-check-all"> </th>
        <th> Tên phòng ban </th>
        <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> <input type="checkbox" index="{id}" class="depart-checkbox" id="depart-checkbox-{id}"> </td>
        <td> <input type="text" class="form-control" id="depart-name-{id}" value="{name}"> </td>
        <td>
            <button class="btn btn-info" onclick="departEdit({id})">
                <span class="glyphicon glyphicon-edit"></span>
            </button>
            <button class="btn btn-danger" onclick="departRemove({id})">
                <span class="glyphicon glyphicon-remove"></span>
            </button>
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->