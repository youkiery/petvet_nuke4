<!-- BEGIN: main -->
<div class="container">
  <div class="row">
    <div class="img-responsive col-sm-4">
      <img src="{image}">
    </div>
    <div class="col-sm-8">
      <p> Tên: {name} </p>
      <p> Ngày sinh: {dob} </p>
      <p> Giống: {species} </p>
      <p> Loài: {breed} </p>
      <p> Giới tính: {sex} </p>
      <p> Màu sắc: {color} </p>
      <p> microchip: {microchip} </p>
    </div>
  </div>

  <table class="table table-bordered">
    <tr>
      <th colspan="4" class="text-center">
        Gia phả
      </th>
    </tr>
    <tr>
      <th class="text-center">
        Ông/Bà
      </th>
      <th class="text-center">
        Bố/Mẹ
      </th>
      <th class="text-center">
        Anh/Chị/Em
      </th>
      <th class="text-center">
        Con
      </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td> {grand} </td>
      <td> {parent} </td>
      <td> {sibling} </td>
      <td> {child} </td>
    </tr>
    <!-- END: row -->
  </table>
</div>
<!-- END: main -->
