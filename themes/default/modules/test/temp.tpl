<!-- BEGIN: main -->
<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th, td {
    padding: 5px;
  }
  .price {
    color: red;
  }
</style>
<table border="1">
  <tr>
    <th>
      STT
    </th>
    <th>
      Tên
    </th>
    <th>
      Giá đại lý
    </th>
    <th>
      Giá bán lẻ đề xuất
    </th>
    <th>
      Hình ảnh
    </th>
  </tr>
  <!-- BEGIN: loop -->
  <tr>
    <td>
      {index}
    </td>
    <td>
      {name}
    </td>
    <td class="price">
      {sale}đ
    </td>
    <td class="price">
      {price}đ
    </td>
    <td style="width: 256px; height: 256px">
      <img src="{image}" width="256px" height="256px"></img>
    </td>
  </tr>
  <!-- END: loop -->
</table>
<!-- END: main -->

