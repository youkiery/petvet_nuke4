<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
    src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div id="content">
    {content}
</div>

<script>
    var global = {
        page: 1
    }

    function checkFilter() {
        return {
            page: global['page'],
            limit: 10
        }
    }

    function goPage(page) {
        global['page'] = page
        $.post(
            '', { action: 'filter', filter: checkFilter() },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    $("#content").html(data['html'])
                }, () => {})
            }
        )
    }

    function lockSubmit(itemid, lockValue) {
        $.post(
            '', { action: 'lock', id: itemid, type: lockValue, filter: checkFilter() },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    $("#content").html(data['html'])
                }, () => {})
            }
        )
    }
</script>
<!-- END: main -->
