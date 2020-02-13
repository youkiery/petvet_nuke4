var vremind = {
    install: (inputSelector, suggestSelector, excuteFunction, inputDelay = 0, suggestDelay = 0) => {
        var input = $(inputSelector)
        var suggest = $(suggestSelector)
        suggest.hide()
        var delay = 0

        input.keyup(() => {
            clearTimeout(delay)
            delay = setTimeout(() => {
                html = excuteFunction(input.val())
                suggest.html(html)
            }, inputDelay);
        })
        input.focus(() => {
            setTimeout(() => {
                suggest.show()
            }, suggestDelay);
        })
        input.blur(() => {
            setTimeout(() => {
                suggest.hide()
            }, suggestDelay);
        })
    }
}
