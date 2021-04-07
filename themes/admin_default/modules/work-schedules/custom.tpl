<!-- BEGIN: main -->
<p class="text-right">
    <em>
        <span class="text-danger">(<i class="fa fa-asterisk"></i>)</span> 
        {lang.ae_id_requires}
    </em>
</p>
<!-- BEGIN: error -->
<div class="message-box-wrapper red">
    <div class="message-box-title">{ERROR}</div>
</div>
<!-- END: error -->
<form method="post" action="{FORM_ACTION}" role="form" onsubmit="return ws_add_validForm(this);" >
    <input type="hidden" name="action" value="add">
    <div class="form-detail">
        <div class="form-group">
            <div>
                <label> {lang.custom_name} <span class="fa-required text-danger" style="display: inline-block">(<i class="fa fa-asterisk"></i>)</span></label>
                <input type="text" name="custom_name" value="{DATA.custom_name}" class="form-control required" placeholder="{lang.note_custom_name}">
            </div>
        </div>
        <div class="form-group">
            <div>
                <label>{lang.custom_number}<span class="fa-required text-danger"></label>
                <input type="text" name="custom_number" value="{DATA.custom_number}" class="form-control" placeholder="{lang.note_custom_number}">
            </div>
        </div>
        <div class="form-group">
            <div>
                <label>{lang.custom_address}<span class="fa-required text-danger"></label>
                <input type="text" name="custom_address" value="{DATA.custom_address}" class="form-control" placeholder="{lang.note_custom_address}">
            </div>
        </div>
        <div class="form-group">
            <div class="text-center">
                <input type="submit" name="submit" value="{lang.custom_submit}" class="btn btn-warning">
            </div>
        </div>
    </div>
</form>
<!-- END: main -->