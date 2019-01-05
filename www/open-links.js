window.addEvent('domready', function() {
	document.body.addEvent('click:relay(a[target="_blank"])', function(e) {
		e.preventDefault();
		window.open(this.url, '_system');
	});
});

