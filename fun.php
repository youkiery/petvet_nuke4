
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <input type="text" class="number" id="number">

  <script src="/modules/core/js/vnumber.js"></script>
  <script src="/modules/core/js/vload.js"></script>
  <script src="/assets/js/jquery/jquery.min.js"></script>
  <script>
    var number = new vload('number')
    number.load()
  </script>
</body>
</html>
