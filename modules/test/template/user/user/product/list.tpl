<!-- BEGIN: main -->
<table class="table table-bordered">
    <tr>
        <th> <input type="checkbox" class="check-product-all"> </th>
        <!-- <th> Mã hàng </th> -->
        <th> Tên hàng </th>
        <th> Vị trí </th>
        <th> Giới hạn </th>
        <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> <input type="checkbox" class="check-product" rel="{id}"> </td>
        <!-- <td> {code} </td> -->
        <td> {name} </td>
        <td> {pos} </td>
        <td> {low} </td>
        <td> 
          <button class="btn btn-info btn-xs" onclick="editProduct({id})">
            sửa
          </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->
