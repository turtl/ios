window.addEvent('domready', function() {
	Composer.add_event(document.body, 'click', function(e) {
		e.preventDefault();
		var a = Composer.find_parent('a', e.target);
		// FUCK the system
		window.open(a.href, '_system');
	}, 'a[target="_blank"], a[target="_system"]');
});

