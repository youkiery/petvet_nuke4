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
