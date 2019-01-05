window.addEvent('domready', function() {
	Composer.add_event(document.body, 'click', function(e) {
		e.preventDefault();
		window.open(this.url, '_system');
	}, 'a[target="_blank"]');
});

