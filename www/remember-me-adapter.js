RememberMe.adapters.ios_keystore = Composer.Event.extend({
	initialize: function(_options) {
	},

	get_login: function() {
		return Promise.resolve(false);
	},

	save: function(user_id, key) {
		return Promise.resolve(false);
	},

	clear: function() {
		return Promise.resolve(false);
	},
});

