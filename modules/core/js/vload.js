function vload (name) {
    this.item = {
        error: null,
        button: null
    }
    this.load = () => {
        if (this.item) {
            this.item.prop('disabled', true)
        }
    }
    this.deload = () => {
        if (this.item) {
            this.item.prop('disabled', false)
        }
    }
}