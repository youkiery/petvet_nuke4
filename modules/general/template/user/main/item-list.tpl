<!-- BEGIN: main -->
<table class="table table-bordered">
    <thead>
        <tr>
            <th> STT </th>
            <th> <input type="checkbox" id="item-check-all"> </th>
            <th> Tên hàng </th>
            <th> Nhóm hàng </th>
            <th> Số lượng </th>
            <th> Giới hạn </th>
            <th> </th>
        </tr>
    </thead>
    <tbody>
        <!-- BEGIN: row -->
        <tr>
            <td> {index} </td>
            <td>
                <label class="checkbox-inline">
                    <input type="checkbox" class="item-checkbox" index="{id}">
                </label>
            </td>
            <td> <input type="text" class="form-control" id="item-name-{id}" index="{id}" value="{name}"> </td>
            <td> {category} </td>
            <td> <input type="text" class="form-control" id="item-number-{id}" index="{id}" value="{number}"> </td>
            <td> <input type="text" class="form-control" id="item-bound-{id}" index="{id}" value="{bound}"> </td>
            <td>
                <button class="btn btn-info" onclick="updateItem({id})">
                    <span class="glyphicon glyphicon-edit"></span>
                </button>
                <button class="btn btn-danger" onclick="removeItem({id})">
                    <span class="glyphicon glyphicon-remove"></span>
                </button>
            </td>
        </tr>
        <!-- END: row -->
    </tbody>
</table>
{nav}
<!-- END: main -->