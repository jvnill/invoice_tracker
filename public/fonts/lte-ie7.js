/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-success' : '&#xe000;',
			'icon-error' : '&#xe001;',
			'icon-minus' : '&#xe002;',
			'icon-plus' : '&#xe003;',
			'icon-info' : '&#xe004;',
			'icon-warning' : '&#xe005;',
			'icon-list' : '&#xe006;',
			'icon-pdf' : '&#xe007;',
			'icon-edit' : '&#xe008;',
			'icon-cog' : '&#xe009;',
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
