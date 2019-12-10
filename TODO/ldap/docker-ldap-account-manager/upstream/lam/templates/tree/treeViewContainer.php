<?php
/*

  This code is part of LDAP Account Manager (http://www.ldap-account-manager.org/)
  Copyright (C) 2010 - 2019  Roland Gruber

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

*/

/**
* Provides a container around the tree view frameset.
*
* @author Roland Gruber
* @package lists
* @subpackage tree
*/

/** security functions */
include_once(__DIR__ . "/../../lib/security.inc");
/** access to configuration options */
include_once(__DIR__ . "/../../lib/config.inc");

// start session
startSecureSession();
enforceUserIsLoggedIn();

setlanguage();

include __DIR__ . '/../../lib/adminHeader.inc';

?>
<div id="tabcontent" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
<iframe
	id="treeframe"
	style="width: 100%; height: 800px;"
	src="../3rdParty/pla/htdocs/index.php"
	frameborder="0"
	title="Tree view">
</iframe>
<script type="text/javascript">
function resizeIframe() {
    var height = document.documentElement.clientHeight;
    height -= document.getElementById('treeframe').offsetTop;
    height -= 105
    document.getElementById('treeframe').style.height = height +"px";
};
document.getElementById('treeframe').onload = resizeIframe;
window.onresize = resizeIframe;
</script>

</div>

<?php
include __DIR__ . '/../../lib/adminFooter.inc';
?>
