<!-- BEGIN: main -->
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <colgroup>
            <col class="w100">
        </colgroup>
        <thead>
            <tr>
                <th>&nbsp;</th>
                <th>{LANG.title}</th>
                <th class="w150 text-center ">{LANG.status}</th>
                <th class="w150 text-center">{LANG.function}</th>
            </tr>
        </thead>
        <tbody>
            <!-- BEGIN: loop -->
            <tr>
                <td><img class="img-thumbnail img-responsive" src="{ROW.person_image_thumb}"></td>
                <td>
                    <h3 class="employ-title"><a href="{ROW.link}">{ROW.title}</a></h3>
                    <p>{LANG.content_person_name}: <strong>{ROW.person_name}</strong></p>
                    <p>{LANG.content_person_gender}: <strong>{ROW.person_gender}</strong></p>
                    <p>{LANG.content_person_birthday}: <strong>{ROW.person_birthday}</strong></p>
                </td>
                <td class="text-center">
                    <!-- BEGIN: queue -->
                    {LANG.queue}
                    <!-- END: queue -->
                    <!-- BEGIN: status -->
                    <input name="status" id="change_status{ROW.id}" value="1" type="checkbox"{ROW.status_render} onclick="nv_change_status('{ROW.id}');" />
                    <!-- END: status -->
                </td>
                <td class="text-center">
                    <em class="fa fa-edit fa-lg">&nbsp;</em> <a href="{ROW.url_edit}">{GLANG.edit}</a> &nbsp;
                    <em class="fa fa-trash-o fa-lg">&nbsp;</em> <a href="javascript:void(0);" onclick="nv_del_row('{ROW.id}');">{GLANG.delete}</a>
                </td>
            </tr>
            <!-- END: loop -->
        </tbody>
        <!-- BEGIN: generate_page -->
        <tfoot>
            <tr>
                <td colspan="4">
                    {GENERATE_PAGE}
                </td>
            </tr>
        </tfoot>
        <!-- END: generate_page -->
    </table>
</div>
<!-- END: main -->