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
    <div class="col-sm-4 thumbnail" id="avatar" style="width: 240px; height: 240px;">
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
        Con
      </th>
    </tr>
    <tr>
      <td> Ông nội: {igrandpa} </td>
      <td rowspan="2"> Bố: {papa} </td>
      <td rowspan="4"> {child} </td>
    </tr>
    <tr>
      <td>
        Bà nội: {igrandma}
      </td>
    </tr>
    <tr>
      <td>
        Ông ngoại: {egrandpa}
      </td>
      <td rowspan="2">
        Mẹ: {mama}
      </td>
    </tr>
    <tr>
      <td>
        Bà ngoại: {egrandma}
      </td>
    </tr>
  </table>
</div>

<script>
  var avatar = $("#avatar")

  loadImage('{image}', avatar)
  // loadImage('http://localhost/modules/biograph/src/banner.png', avatar)
</script>
<!-- END: main -->
