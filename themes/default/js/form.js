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
  var month = date.getMonth() + 1
  var year = date.getFullYear()
  if (day < 10) {
    day = "0" + day
  }
  if (month < 10) {
    month = "0" + month
  }
  return day + "/" + month + "/" + year
}
