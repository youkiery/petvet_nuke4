<!-- BEGIN: main -->
<div class="container">
  <a href="/biograph/">
    <img src="/modules/biograph/src/banner.png" style="width: 100px;">
  </a>
  <form style="width: 60%; float: right;">
    <label class="input-group">
      <input type="hidden" name="nv" value="biograph">
      <input type="hidden" name="op" value="list">
      <input type="text" class="form-control" name="keyword" value="{keyword}" id="keyword" placeholder="Nhập tên hoặc mã số">
      <div class="input-group-btn">
        <button class="btn btn-info"> Tìm kiếm </button>
      </div>
    </label>
  </form>
  <div style="clear: both;"></div>

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
    <tr>
      <td> {grand} </td>
      <td> {parent} </td>
      <td> {sibling} </td>
      <td> {child} </td>
    </tr>
  </table>
</div>
<!-- END: main -->
