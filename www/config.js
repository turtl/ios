if(typeof(config) == 'undefined') config = {};
Object.merge(config, {
	client: 'ios',
	version: cordova_app_version,
	base_url: window.location.toString().replace(/\/(index\.html)?$/, '/app'),
	core: {
		adapter: 'mobile',
		options: {},
	},
	remember_me: {
		enabled: true,
		adapter: 'ios_keystore',
		options: {},
	},
});

