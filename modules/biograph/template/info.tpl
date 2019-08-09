<!-- BEGIN: main -->
<style>
  label {
    width: 100%;
  }
</style>
<div class="container" style="margin-top: 20px;">
  <a href="/biograph/">
    <img src="/modules/biograph/src/banner.png" style="width: 100px;">
  </a>
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
<script>
  var avatar = $("#avatar")

  loadImage('{image}', avatar)
</script>
<!-- END: main -->
