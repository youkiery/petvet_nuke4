<!-- BEGIN: main -->
<style>
  *, *:before, *:after {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
  }
  #wrapper {
    position: relative;
  }
  .branch {
    position: relative;
    margin-left: 250px;
  }
  .branch:before {
    content: "";
    width: 50px;
    border-top: 2px solid #eee9dc;
    position: absolute;
    left: -100px;
    top: 50%;
    margin-top: 1px;
  }
  .entry {
    position: relative;
    min-height: 60px;
  }
  .entry:before {
    content: "";
    height: 100%;
    border-left: 2px solid #eee9dc;
    position: absolute;
    left: -50px;
  }
  .entry:after {
    content: "";
    width: 50px;
    border-top: 2px solid #eee9dc;
    position: absolute;
    left: -50px;
    top: 50%;
    margin-top: 1px;
  }
  .entry:first-child:before {
    width: 10px;
    height: 50%;
    top: 50%;
    margin-top: 2px;
    border-radius: 10px 0 0 0;
  }
  .entry:first-child:after {
    height: 10px;
    border-radius: 10px 0 0 0;
  }
  .entry:last-child:before {
    width: 10px;
    height: 50%;
    border-radius: 0 0 0 10px;
  }
  .entry:last-child:after {
    height: 10px;
    border-top: none;
    border-bottom: 2px solid #eee9dc;
    border-radius: 0 0 0 10px;
    margin-top: -9px;
  }
  .entry.sole:before {
    display: none;
  }
  .entry.sole:after {
    width: 50px;
    height: 0;
    margin-top: 1px;
    border-radius: 0;
  }
  .label {
    display: block;
    min-width: 150px;
    padding: 5px 10px;
    line-height: 20px;
    text-align: center;
    border: 2px solid #eee9dc;
    border-radius: 5px;
    position: absolute;
    left: 0;
    top: 50%;
    margin-top: -15px;
    color: black;
  }
</style>
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

  <div id="wrapper" style="overflow: scroll"><span class="label"> {name} </span>
    <div class="branch lv1">
      <div class="entry"><span class="label"> Bố <br> {papa} </span>
        <div class="branch lv2">
          <div class="entry"><span class="label"> Ông nội <br> {igrandpa} </span>
          </div>
          <div class="entry"><span class="label"> Bà nội <br> {igrandma} </span>
          </div>
        </div>
      </div>
      <div class="entry"><span class="label"> Mẹ <br> {mama} </span>
        <div class="branch lv2">
          <div class="entry"><span class="label"> Ông ngoại <br> {egrandpa} </span>
          </div>
          <div class="entry"><span class="label"> Bà ngoại <br> {egrandma} </span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- <table class="table table-bordered">
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
</div> -->

<script>
  var avatar = $("#avatar")

  loadImage('{image}', avatar)
  // loadImage('http://localhost/modules/biograph/src/banner.png', avatar)
</script>
<!-- END: main -->
