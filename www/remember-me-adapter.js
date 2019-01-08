RememberMe.adapters.ios_keystore = Composer.Event.extend({
	initialize: function(_options) {
	},

	get_login: function() {
		return new Promise(function(resolve, reject) {
			Keychain.get(resolve, reject, 'turtl-remember-me', 'Please login with TouchID');
		}).then(function(res) {
			if(!res) return null;
			var decoded = JSON.parse(atob(res));
			return {user_id: decoded.user_id, key: decoded.key};
		});
	},

	save: function(user_id, key) {
		const encoded = btoa(JSON.stringify({user_id: user_id, key: key}));
		return new Promise(function(resolve, reject) {
			Keychain.set(resolve, reject, 'turtl-remember-me', encoded, false);
		});
	},

	clear: function() {
		return new Promise(function(resolve, reject) {
			Keychain.remove(resolve, reject, 'turtl-remember-me');
		});
	},
});

