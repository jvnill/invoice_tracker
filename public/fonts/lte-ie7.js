/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-plus-sign' : '&#xf055;',
			'icon-untitled' : '&#xf000;',
			'icon-file-pdf' : '&#xe007;',
			'icon-cancel-circle' : '&#xe001;',
			'icon-menu' : '&#xe002;',
			'icon-info' : '&#xe000;',
			'icon-spam' : '&#xe003;',
			'icon-remove' : '&#xe004;',
			'icon-cog' : '&#xe005;',
			'icon-pencil' : '&#xe008;'
		},
		els = document.getElementsByTagName('*'),
		i, attr, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		attr = el.getAttribute('data-icon');
		if (attr) {
			addIcon(el, attr);
		}
		c = el.className;
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
};