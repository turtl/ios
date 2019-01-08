RememberMe.adapters.ios_keystore = Composer.Event.extend({
	initialize: function(_options) {
	},

	get_login: function() {
		return new Promise(function(resolve, reject) {
			Keychain.get(function(res) {
				if(!res) return null;
				var token = JSON.parse(res).key;
				if(!token) return null;
				var decoded = JSON.parse(atob(token));
				return {user_id: decoded.user_id, key: decoded.key};
			}, reject, 'turtl-remember-me', 'Please login with TouchID');
		});
	},

	save: function(user_id, key) {
		const token = JSON.stringify({user_id: user_id, key: key});
		const token_str = btoa(token);
		return new Promise(function(resolve, reject) {
			Keychain.set(resolve, reject, 'turtl-remember-me', token_str, false);
		});
	},

	clear: function() {
		return new Promise(function(resolve, reject) {
			Keychain.remove(resolve, reject, 'turtl-remember-me');
		});
	},
});

