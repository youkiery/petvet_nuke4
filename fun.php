<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <button onclick="read()">
    read
  </button>
  <iframe id="doc" src = "/assets/js/ViewerJS/#../" width='700' height='550' allowfullscreen webkitallowfullscreen></iframe>

  <script src="/assets/js/jquery/jquery.min.js?t=1"></script>
  <script>
    var x
    var doc = $("#doc")

    function read() {
      doc.attr("src", "/assets/js/ViewerJS/#../")
      // $.post(
      //   "/form-1.docx",
      //   {},
      //   (response, status) => {
          
      //   }
      // ) 
    }
  </script>
</body>
</html>


