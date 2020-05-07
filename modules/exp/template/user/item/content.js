  var itemTemplate = `
  <div class="row-x">
    <div class="col-4">
      {index}
    </div>
    <div class="col-6">
      <input type="text" class="form-control" id="name-{id}">
    </div>
    <div class="col-2">
      <button class="btn btn-danger" onclick="removeItem({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>
    </div>
  </div>`