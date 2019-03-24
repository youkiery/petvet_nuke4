const rand = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
const rand_length = rand.length + 1

function alert_msg(msg) {
  $('#msgshow').html(msg); 
	$('#msgshow').show('slide').delay(2000).hide('slow'); 
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
        reject()
      }
    }
  })
}

function checkNumber(number) {
  number = Number(number)
  if (number && number > 0) {
    return 1
  } 
  return 0
}

function dateToString(date) {
  var day = date.getDate()
  var month = date.getMonth()
  var year = date.getFullYear()
  if (day < 10) {
    day = "0" + day
  }
  if (month < 10) {
    month = "0" + month
  }
  return day + "/" + month + "/" + year
}

function randomKey() {
  var result = ""
  for (var index = 0; index < 6; index++) {
    result += rand[Math.floor(Math.random() * rand_length)]
  }
  return result
}