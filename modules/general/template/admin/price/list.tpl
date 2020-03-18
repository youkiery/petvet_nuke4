<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Mã hàng </th>
        <th> Tên hàng </th>
        <th> Loại hàng </th>
        <th>  </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td rowspan="{row}"> {index} </td>
        <td> {code} </td>
        <td> {name} </td>
        <td> {category} </td>
        <td rowspan="{row}" style="vertical-align: inherit;"> 
            <button class="btn btn-info btn-sm" onclick="itemEdit({id})">
                <span class="glyphicon glyphicon-edit"></span>
            </button>    
            <button class="btn btn-danger btn-sm" onclick="itemRemove({id})">
                <span class="glyphicon glyphicon-remove"></span>
            </button>    
        </td>
    </tr>
    <!-- BEGIN: section -->
    <tr>
        <td colspan="3">
            <!-- BEGIN: p1 -->
            Giá sỉ: {price}
            <!-- END: p1 -->
            <!-- BEGIN: p2 -->
            Giá sỉ: {price} số lượng từ {number}
            <!-- END: p2 -->
        </td>
    </tr>
    <!-- END: section -->
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->
