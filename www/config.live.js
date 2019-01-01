if(typeof(config) == 'undefined') config = {};
Object.merge(config, {
	client: 'ios',
	version: cordova_app_version,
	cookie_login: false,
	base_url: window.location.toString().replace(/\/(index\.html)?$/, '/app'),
	has_autologin: false,
	core: {
		adapter: 'mobile',
		options: {},
	},
	remember_me: {
		enabled: false,
		adapter: 'ios_keystore',
		options: {},
	},
});

