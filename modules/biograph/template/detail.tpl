<!-- BEGIN: main -->
<style>
  .igleft {
    position: relative;
    float: left;
    left: 40px;
  }
  .igright {
    position: relative;
    float: right;
    left: 5px;
  }
  *, *:before, *:after {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
  }
  #wrapper {
    position: relative;
  }
  .popover {
    width: 200px;
  }
  .branch {
    position: relative;
    margin-left: 200px;
  }
  .branch:before {
    content: "";
    width: 25px;
    border-top: 2px solid #eee9dc;
    position: absolute;
    left: -50px;
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
    left: -25px;
  }
  .after-hack {
    position: absolute;
    right: 0px;
    z-index: 1;
    width: 22px;
    height: 22px;
    min-width: 0px;
    min-height: 0px;
    padding: 5px 0px 10px 2px;
  }
  .entry:after {
    content: "";
    width: 25px;
    border-top: 2px solid #eee9dc;
    position: absolute;
    left: -25px;
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
    height: 54px;
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

  <div id="wrapper">
    <span class="label"> {name} </span>
    <div class="branch lv1">
      <div class="entry">
        <span class="label"> 
          Bố <br> {papa} 
          <div class="igleft">
            <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px;" data-html="true"  data-toggle="popover" data-content="{igpapa}"><span class="glyphicon glyphicon-info-sign"></span></button>  
          </div>
          <div class="igright">
            <button class="btn btn-sm btn-success after-hack" id="igrandon" onclick="toggleX('igrand')"><span class="glyphicon glyphicon-arrow-right"></span></button>  
            <button class="btn btn-sm btn-warning after-hack" id="igrandoff" style="display: none;" onclick="toggleX('igrand')"><span class="glyphicon glyphicon-arrow-left"></span></button>  
          </div>
        </span>
        <div class="branch lv2" id="igrand" style="display: none;">
          <div class="entry">
            <span class="label"> Ông nội <br> {grandpa} 
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px;" data-html="true"  data-toggle="popover" data-content="{igigrandpa}"><span class="glyphicon glyphicon-info-sign"></span></button>  
              </div>
            </span>
          </div>
          <div class="entry">
            <span class="label">
              Bà nội <br> {igrandma}
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px;" data-html="true"  data-toggle="popover" data-content="{igigrandma}"><span class="glyphicon glyphicon-info-sign"></span></button>  
              </div>
            </span>
          </div>
        </div>
      </div>
      <div class="entry">
        <span class="label">
          Mẹ <br> {mama} 
          <div class="igleft">
            <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px;" data-html="true"  data-toggle="popover" data-content="{igmama}"><span class="glyphicon glyphicon-info-sign"></span></button>  
          </div>
          <div class="igright">
            <button class="btn btn-sm btn-success after-hack" id="egrandon" onclick="toggleX('egrand')"><span class="glyphicon glyphicon-arrow-right"></span></button>  
            <button class="btn btn-sm btn-warning after-hack" id="egrandoff" style="display: none;" onclick="toggleX('egrand')"><span class="glyphicon glyphicon-arrow-left"></span></button>  
          </div>
        </span>
        <div class="branch lv2" id="egrand" style="display: none;">
          <div class="entry">
            <span class="label">
              Ông ngoại <br> {egrandpa}
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px;" data-html="true"  data-toggle="popover" data-content="{igegrandpa}"><span class="glyphicon glyphicon-info-sign"></span></button>  
              </div>
            </span>
          </div>
          <div class="entry">
            <span class="label"> Bà ngoại <br> {egrandma}
              <div class="igleft">
                <button class="btn btn-sm btn-info after-hack ipopover" style="right: 23px;" data-html="true"  data-toggle="popover" data-content="{igegrandma}"><span class="glyphicon glyphicon-info-sign"></span></button>  
              </div>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>

<script>
  var avatar = $("#avatar")

  loadImage('{image}', avatar)
  // loadImage('http://localhost/modules/biograph/src/banner.png', avatar)

  function toggleX(name) {
    var target = $("#" + name)
    if (target.css('display') == 'block') {
      $("#" + name + "on").show()
      $("#" + name + "off").hide()
    }
    else {
      $("#" + name + "on").hide()
      $("#" + name + "off").show()
    }
    target.toggle()
  }

  function splipper(text, part) {
    var pos = text.search(part + '-')
    var overleft = text.slice(pos)
    if (number = overleft.search(' ') >= 0) {
      overleft = overleft.slice(0, number)
    }
    var tick = overleft.lastIndexOf('-')
    var result = overleft.slice(tick + 1, overleft.length)

    return result
  }

  $(document).ready(function(){
    $('[data-toggle="popover"]').popover();

    $('[data-toggle="popover"]').click(function (e) {
      e.stopPropagation();
      var name = e.currentTarget.children[0].className
      // var className = splipper(name, 'glyphicon')
      // if (className == 'open') {
      //   e.currentTarget.children[0].className = 'glyphicon glyphicon-eye-close'
      // }
      // else {
      //   e.currentTarget.children[0].className = 'glyphicon glyphicon-info-sign'
      // }
    });
  });


  $(document).click(function (e) {
      if (($('.popover').has(e.target).length == 0) || $(e.target).is('.close')) {
        $('[data-toggle="popover"]').popover('hide');

        // var name = e.currentTarget.children[0].className
        // var className = splipper(name, 'glyphicon')
        // if (className == 'open') {
        //   e.currentTarget.children[0].className = 'glyphicon glyphicon-eye-close'
        // }
        // else {
        //   e.currentTarget.children[0].className = 'glyphicon glyphicon-info-sign'
        // }

      }
  });
</script>
<!-- END: main -->
