<!-- BEGIN: main -->
<table class="table table-bordered tableFixHead">
  <tr>
    <th> STT </th>
    <th class="text-center" style="width: 10%"> Mã thu phí </th>
    <th class="text-center" style="width: 20%"> Nội Dung Thu </th>
    <th class="text-center" style="width: 10%"> Xác định một serotype </th>
    <th class="text-center" style="width: 10%"> Số lượng mẫu xét nghiệm </th>
    <th class="text-center" style="width: 25%"> Thu giá dịch vụ theo Thông tư 283/2016/TT-BTC ngày 14/11/2016 & Quyết định số 29 & 29a/QĐ -TYV5 ngày 30/12/2016 </th>
    <th class="text-center" style="width: 10%"> Thành tiền </th>
    <th class="text-center" style="width: 10%">  Số và ngày thông báo kết quả xét nghiệm </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <!-- BEGIN: col -->
    <td rowspan="{row}"> {gindex} {data} </td>
    <!-- END: col -->
    <td> <select class="form-control cashcode print-cashcode-{id}" rel="{id}" index="{index}">{select}</select> </td>
    <td> <input type="text" class="form-control print-result-{id}" index="{index}" value="{result}"> </td>
    <td> <input type="text" class="form-control print-serotype-{id}" index="{index}" value="{serotype}"> </td>
    <td> <input type="text" class="form-control number print-number-{id}" rel="{id}" index="{index}" value="{number}"> </td>
    <td> <input type="text" class="form-control price print-price-{id}" rel="{id}" index="{index}" value="{price}"> </td>
    <td> <input type="text" class="form-control print-total-{id}" index="{index}" value="{total}"> </td>
    <!-- BEGIN: col2 -->
    <td rowspan="{row}"> <input type="text" class="form-control" id="datetime-{id}" value="{datetime}"> </td>
    <!-- END: col2 -->
  </tr>
  <!-- BEGIN: row -->
</table>
<!-- END: main -->
