<!-- BEGIN: main -->
<div class="container">
  <div id="msgshow"></div>
  <div class="text-center start-content"
    style="max-width: 450px; margin: auto; padding-top: 50px; border: 1px solid lightgray; padding: 15px; border-radius: 20px;">
    <a href="/{module_file}">
      <img src="/themes/default/images/banner.png" style="width: 200px; margin: 20px 20px;">
    </a>

    <div style="margin-top: 20px;"></div>
    <!-- BEGIN: redirect2 -->
    <div class="text-center margin-bottom-lg">
      <!-- BEGIN: image -->
      <a title="{SITE_NAME}" href="{THEME_SITE_HREF}"><img src="{LOGO_SRC}" width="{LOGO_WIDTH}" height="{LOGO_HEIGHT}"
          alt="{SITE_NAME}" /></a>
      <!-- END: image -->
      <!-- BEGIN: swf -->
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
        width="{LOGO_WIDTH}" height="{LOGO_HEIGHT}">
        <param name="wmode" value="transparent" />
        <param name="movie" value="{LOGO_SRC}" />
        <param name="quality" value="high" />
        <param name="menu" value="false" />
        <param name="seamlesstabbing" value="false" />
        <param name="allowscriptaccess" value="samedomain" />
        <param name="loop" value="true" />
        <!--[if !IE]> <-->
        <object type="application/x-shockwave-flash" width="{LOGO_WIDTH}" height="{LOGO_HEIGHT}" data="{LOGO_SRC}">
          <param name="wmode" value="transparent" />
          <param name="pluginurl" value="http://www.adobe.com/go/getflashplayer" />
          <param name="loop" value="true" />
          <param name="quality" value="high" />
          <param name="menu" value="false" />
          <param name="seamlesstabbing" value="false" />
          <param name="allowscriptaccess" value="samedomain" />
        </object>
        <!--> <![endif]-->
      </object>
      <!-- END: swf -->
    </div>
    <!-- END: redirect2 -->
    <h2 class="text-center margin-bottom-lg">{LANG.login}</h2>
    {FILE "login_form.tpl"}
    <div class="text-center margin-top-lg" id="other_form">
      <!-- BEGIN: navbar --><a href="{NAVBAR.href}" class="margin-right-lg"><em
          class="fa fa-caret-right margin-right-sm"></em>{NAVBAR.title}</a><!-- END: navbar -->
    </div>
  </div>
</div>
</div>
</div>
<!-- END: main -->