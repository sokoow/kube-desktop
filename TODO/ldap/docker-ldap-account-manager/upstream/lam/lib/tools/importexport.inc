<?php
namespace LAM\TOOLS\UPLOAD;
/*

  This code is part of LDAP Account Manager (http://www.ldap-account-manager.org/)
  Copyright (C) 2018  Roland Gruber

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
* Import and export tool.
*
* @author Roland Gruber
* @package tools
*/

/**
 * Import and export tool.
 *
 * @package tools
 */
class ImportExport implements \LAMTool {

	/**
	 * Returns the name of the tool.
	 *
	 * @return string name
	 */
	 function getName() {
	 	return _("LDAP import/export");
	 }

	/**
	 * returns a description text for the tool.
	 *
	 * @return string description
	 */
	function getDescription() {
		return _("Imports and exports LDAP data.");
	}

	/**
	 * Returns a link to the tool page (relative to templates/).
	 *
	 * @return string link
	 */
	function getLink() {
		return "tools/importexport.php";
	}

	/**
	 * Returns if the tool requires write access to LDAP.
	 *
	 * @return boolean true if write access is needed
	 */
	function getRequiresWriteAccess() {
		return true;
	}

	/**
	 * Returns if the tool requires password change rights.
	 *
	 * @return boolean true if password change rights are needed
	 */
	function getRequiresPasswordChangeRights() {
		return true;
	}

	/**
	 * Returns the link to the tool image (relative to graphics/)
	 *
	 * @return string image URL
	 */
	function getImageLink() {
		return 'importexport.png';
	}

	/**
	 * Returns the prefered position of this tool on the tools page.
	 * The position may be between 0 and 1000. 0 is the top position.
	 *
	 * @return int prefered position
	 */
	function getPosition() {
		return 450;
	}

	/**
	 * Returns a list of sub tools or an empty array.
	 *
	 * @return array list of subtools (LAMTool)
	 */
	function getSubTools() {
		return array();
	}

	/**
	 * Returns if the tool is visible in the menu.
	 *
	 * @return boolean visible
	 */
	function isVisible() {
		return true;
	}

	/**
	 * Returns if a tool may be hidden by configuration in the LAM server profile.
	 *
	 * @return boolean hideable
	 */
	function isHideable() {
		return true;
	}

}

?>