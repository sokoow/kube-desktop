<?php
/**
 * Displays a form for renaming an LDAP entry.
 *
 * @package phpLDAPadmin
 * @subpackage Page
 */

/**
 */

require './common.php';

# The DN we are working with
$request = array();
$request['dn'] = get_request('dn','GET');
$request['template'] = get_request('template','GET');

$request['page'] = new PageRender($app['server']->getIndex(),get_request('template','REQUEST',false,'none'));
$request['page']->setDN($request['dn']);
$request['page']->accept();

# Render the form
$request['page']->drawTitle(sprintf('%s <b>%s</b>',_('Rename'),htmlspecialchars(get_rdn($request['dn']))));
$request['page']->drawSubTitle();

echo '<center>';
printf(_('Rename <b>%s</b> to a new object.') . '<br /><br />',htmlspecialchars(get_rdn($request['dn'])));

echo '<form action="cmd.php?cmd=rename" method="post" />';
printf('<input type="hidden" name="server_id" value="%s" />',$app['server']->getIndex());
printf('<input type="hidden" name="dn" value="%s" />',rawurlencode($request['dn']));
printf('<input type="hidden" name="template" value="%s" />',htmlspecialchars($request['template']));
printf('<input type="text" name="new_rdn" size="30" value="%s" />',htmlspecialchars(get_rdn($request['dn'])));
printf('<input type="submit" value="%s" />',_('Rename'));
echo '</form>';

echo '</center>';
echo "\n";
?>
