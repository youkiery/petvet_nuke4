<!-- BEGIN: main -->
<div class="container">
  <!-- <div id="loading">
    <div class="black-wag"> </div>
    <img class="loading" src="/themes/default/images/loading.gif">
  </div> -->
  <a href="/">
    <img src="/themes/default/images/banner.png" style="width: 200px;">
  </a>
  <div id="msgshow"></div>
  <ul class="nav navbar-nav">
      <!-- BEGIN: navbar --><li><a href="{NAVBAR.href}"><em class="fa fa-caret-right margin-right-sm"></em>{NAVBAR.title}</a></li><!-- END: navbar -->
  </ul>
  <div style="clear: both;"></div>

  <div class="page">
    <h2 class="margin-bottom-lg margin-top-lg">{LANG.listusers}</h2>
    <div class="table-responsive">
    	<table class="table table-bordered table-striped">
    		<colgroup>
    			<col style="width:60%"/>
    			<col style="width:15%"/>
    		</colgroup>
    		<thead>
    			<tr class="bg-lavender">
    				<td><a href="{username}" class="black text-uppercase">{LANG.account}</a></td>
    				<td><a href="{gender}" class="black text-uppercase">{LANG.gender}</a></td>
    				<td><a href="{regdate}" class="black text-uppercase">{LANG.regdate}</a></td>
    			</tr>
    		</thead>
    		<tbody>
    			<!-- BEGIN: list -->
    			<tr>
    				<td><a href="{USER.link}">{USER.username} <!-- BEGIN: fullname -->&nbsp;({USER.full_name})<!-- END: fullname --></a></td>
    				<td>{USER.gender}</td>
    				<td>{USER.regdate}</td>
    			</tr>
    			<!-- END: list -->
    		</tbody>
    		<!-- BEGIN: generate_page -->
    		<tfoot>
    			<tr>
    				<td colspan="3">{GENERATE_PAGE}</td>
    			</tr>
    		</tfoot>
    		<!-- END: generate_page -->
    	</table>
    </div>
  </div>
</div>
<!-- END: main -->