<!-- BEGIN: main -->
<style>
  img.img-responsive {
    margin: auto;
    width: 100%;
  }

  footer p {
    line-height: 0.9em;
  }

  .navbar-inverse {
    background-color: #4a2;
    border-color: #aaa;
  }

  @media screen and (min-width: 768px) {
    .navbar {
      min-height: 75px;
    }

    .nav-title-big {
      display: inline;
    }

    .jumbotron {
      padding-top: 75px;
    }
  }

  @media screen and (max-width: 769px) {
    .jumbotron {
      padding-top: 80px;
    }

    .nav-title-big {
      width: 80%;
      margin-top: 13px;
    }
  }
</style>

{modal}

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
        aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <div class="text-center nav-title-big">
        <img src="/assets/images/2.png" style="width: 300px; margin-bottom: 5px; float: left;">
      </div>
    </div>

    <div id="navbar" class="navbar-collapse collapse">
      <div class="navbar-form navbar-right">
        <button type="submit" class="btn btn-success">Đăng nhập</button>
      </div>
    </div>
  </div>
</nav>

<div class="jumbotron" style="background: url('/uploads/quan-ly-khoa-hoc/{img}');">
  <div class="container">
    <h1 style="text-shadow: black 1px 1px 0px; color: orange; " onclick="openMain()"> {title} </h1>
    <p style="text-shadow: black 1px 1px 0px; color: orange; " onclick="openMain()"> {content} </p>
    <p><a class="btn btn-primary btn-lg" href="#" role="button"> Đăng ký </a></p>
  </div>
</div>

<div class="container">
  <!-- Example row of columns -->
  <div class="text-center">
    <h2>
      CÁC KHÓA HỌC
    </h2>
  </div>
  <hr>

  {court_block}

  <hr>

  <div class="text-center" style="clear: both;">
    <h2>
      CẦN TRỢ GIÚP?
    </h2>
  </div>

  <hr>

  {help_block}

  <div style="clear: both;"></div>

  <footer style="border-top: 5px solid gray; padding: 10px 10px 5px 10px; background: darkgreen; color: white;">
    <p> SIÊU THỊ - BỆNH VIỆN THÚ CƯNG THANH XUÂN </p>
    <p> Địa chỉ: 14 Lê Đại Hành, Buôn Ma Thuột</p>
    <p> Số điện thoại: 02626.290.609 </p>
    <p> Website: <a href="http://petcoffee.com" style="color: white; text-decoration: underline;">
        http://petcoffee.com </a> </p>
    <p> Facebook: </p>
    <p>
      - <a href="https://facebook.com/benhvienthucungthanhxuan" style="color: white; text-decoration: underline;">
        benhvienthucungthanhxuan </a>
    </p>
    <p>
      - <a href="https://facebook.com/petcoffee.com.vn" style="color: white; text-decoration: underline;">
        petcoffee.com.vn </a> </p>
    <p> Email: petcoffee.com@gmail.com </p>
  </footer>
</div>

<script>
  var data = {
    'main': {
      title: `{title}`,
      subtitle: `{content}`,
      content: `{main_content}`,
    },
    1: {
      0: {
        title: `{10a}`,
        subtitle: `{10b}`,
        content: `{10c}`,
      },
      1: {
        title: `{11a}`,
        subtitle: `{11b}`,
        content: `{11c}`,
      },
      2: {
        title: `{12a}`,
        subtitle: `{12b}`,
        content: `{12c}`,
      },
      3: {
        title: `{13a}`,
        subtitle: `{13b}`,
        content: `{13c}`,
      },
    }
  }

  function openMain() {
    $("#info-title").html(data['main']['title'])
    $("#info-subtitle").html(data['main']['subtitle'])
    $("#info-content").html(data['main']['content'])
    $("#info-modal").modal('show')
  }

  function openRow(id, type) {
    $("#info-title").html(data[type][id]['title'])
    $("#info-subtitle").html(data[type][id]['subtitle'])
    $("#info-content").html(data[type][id]['content'])
    $("#info-modal").modal('show')
  }
</script>
<!-- END: main -->