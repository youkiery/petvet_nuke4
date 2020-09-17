var vnumber = {
  formatter: new Intl.NumberFormat('vi-VI', {
    style: 'currency',
    currency: 'VND'
  }),
  install: (id, min = null, max = null) => {
    var prv = ''
    var input = $("#" + id)
    input.keyup(() => {
      value = input.val().replace(/\,/g, "")

      if (isFinite(value)) {
        // là số
        if (isFinite(min) && value < min) value = min
        if (isFinite(max) && value > max) value = max
        prv = vnumber.formatter.format(value).replace(/ ₫/g, "").replace(/\./g, ",")
        input.val(prv)
      }
    })
  }
}