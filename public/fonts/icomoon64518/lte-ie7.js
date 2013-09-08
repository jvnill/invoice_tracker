/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-untitled' : '&#xe006;',
			'icon-untitled-2' : '&#xe009;',
			'icon-untitled-3' : '&#xe008;',
			'icon-untitled-4' : '&#xe005;',
			'icon-untitled-5' : '&#xe004;',
			'icon-untitled-6' : '&#xe003;',
			'icon-untitled-7' : '&#xe002;',
			'icon-untitled-8' : '&#xe001;',
			'icon-untitled-9' : '&#xe000;',
			'icon-untitled-10' : '&#xf000;',
			'icon-file-pdf' : '&#xe007;'
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