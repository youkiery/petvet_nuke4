function alert_msg(msg) {
  $('#msgshow').html(msg); 
	$('#msgshow').show('slide').delay(2000).hide('slow'); 
}

function request(url, param) {
  return new Promise((resolve) => {
    $.post(url, param).then((response, status) => {
      checkResult(response, status).then((data) => {
        resolve(data)
      }, () => {})
    })
  })
}

function checkResult(response, status) {
  return new Promise((resolve, reject) => {
    if (status === 'success') {
      try {
        data = JSON.parse(response)
        if (data["status"]) {
          if (data["notify"]) {
            alert_msg(data["notify"])
          }
          resolve(data)          
        }
        else {
          if (data["notify"]) {
            alert_msg(data["notify"])
          }
          else {
            alert_msg("Có lỗi xảy ra")
          }
          throw "error"
        }
      }
      catch (e) {
        reject(data)
      }
    }
  })
}

function paintext(string) {
  var str = string.toLowerCase();
  str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g,"a"); 
  str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g,"e"); 
  str = str.replace(/ì|í|ị|ỉ|ĩ/g,"i"); 
  str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g,"o"); 
  str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g,"u"); 
  str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g,"y"); 
  str = str.replace(/đ/g,"d");
  str = str.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'|\"|\&|\#|\[|\]|~|\$|_|`|-|{|}|\||\\/g," ");
  str = str.replace(/ + /g," ");
  str = str.trim(); 
  return str;
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

function loadImage(url, section) {
  var image = new Image()
  var section = document.getElementById(section)
  image.src = url
  image.classList["value"] = ('img-responsive')
  image.onload = function() {
    section.append(image)
    section.classList.remove('thumbnail')
  }
  image.onerror = function () {
    console.log('load image error')
  }
}
