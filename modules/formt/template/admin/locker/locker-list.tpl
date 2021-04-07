<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
    <tr>
        <th> STT </th>
        <th> Số văn bản </th>
        <th> Số ĐKXN </th>
        <th> Số phiếu </th>
        <th> Tên đơn vị </th>
        <th> Số mẫu </th>
        <th> Loài động vật </th>
        <th> </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> {code} </td>
        <td> {xcode} </td>
        <td> {mcode} </td>
        <td> {sender} </td>
        <td> {number} </td>
        <td> {sample} </td>
        <td>
            <!-- BEGIN: yes -->
            <button class="btn btn-warning btn-sm" onclick="lockSubmit({id}, 0)">
                <span class="glyphicon glyphicon-lock"></span>
            </button>
            <!-- END: yes -->
            <!-- BEGIN: no -->
            <button class="btn btn-info btn-sm" onclick="lockSubmit({id}, 1)">
                <span class="glyphicon glyphicon-lock"></span>
            </button>
            <!-- END: no -->
        </td>
    </tr>
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->