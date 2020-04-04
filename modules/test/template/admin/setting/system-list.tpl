<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <td> Chức năng </td>
        <th>  </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {module} </td>
        <td>
            <button class="btn {type}">
                Cho phép m
            </button>
            <button class="btn btn-danger" onclick="removeEmploy({id})">
                <span class="glyphicon glyphicon-remove"></span>
            </button>
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->