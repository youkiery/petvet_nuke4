<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Tên </th>
        <th>  </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> <input class="form-control" type="text" id="category-name-{id}" value="{name}"> </td>
        <td> 
            <button class="btn btn-info btn-sm" onclick="categoryUpdate({id})">
                <span class="glyphicon glyphicon-edit"></span>
            </button>    
            <button class="btn btn-{active} btn-sm" onclick="categoryToggle({id})">
                <span class="glyphicon glyphicon-star"></span>
            </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
<!-- END: main -->
