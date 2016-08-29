/**
 * This is a busy indicator widget
 *
 * It need jquery and jquery ui
 *
 * @author zhujt
 * @param text
 * @returns
 */

var myIndicator = function (text) {
    var id = "my-indicator-dlg";
    var text = text || '';
    var html = [];
    html.push('<div id="' + id + '" style="text-align: center;">');
    html.push('<table width="100%" height="100%">');
    html.push('<tr>');
    html.push('<td align="right" valign="center">');
    html.push('<img src="../scripts/myIndicator/ajax-loader-1.gif">');
    html.push('</td>');
    html.push('<td align="left" valign="center">');
    html.push('<span>' + text + '</span>');
    html.push('</td>');
    html.push('</tr>');
    html.push('</table>');
    html.push('</div>');
    var dlg = jQuery('body').append(html.join(''));

    jQuery("#" + id).dialog({
        width: 160,
        height: 86,
        draggable: false,
        position: "center",
        resizable: false,
        modal: true
    });
    jQuery("#" + id).prev().css("display", "none");

    jQuery("#my-indicator-dlg").css("height", "56px");

    this.hide = function () {
        jQuery("#" + id).dialog("close");
        jQuery("#" + id).remove();
    };

    return this;
};