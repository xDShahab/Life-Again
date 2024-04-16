(function(){

	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
			'<div class="head"><span>{{{title}}}</span></div>' +
				'<div class="menu-items">' + 
					'{{#elements}}' +
						'<div class="menu-item {{#selected}}selected{{/selected}}">' +
							'{{{label}}}{{#isSlider}} : &lt;{{{sliderLabel}}}&gt;{{/isSlider}}' +
						'</div>' +
					'{{/elements}}' +
				'</div>'+
			'</div>' +
		'</div>'
	;

	window.ESX_MENU       = {};
	ESX_MENU.ResourceName = 'esx_menu_default';
	ESX_MENU.opened       = {};
	ESX_MENU.focus        = [];
	ESX_MENU.pos          = {};

	current_name = 'null'

	ESX_MENU.open = function(namespace, name, data) {

		if (typeof ESX_MENU.opened[namespace] == 'undefined') {
			ESX_MENU.opened[namespace] = {};
		}

		if (typeof ESX_MENU.opened[namespace][name] != 'undefined') {
			ESX_MENU.close(namespace, name);
		}

		if (typeof ESX_MENU.pos[namespace] == 'undefined') {
			ESX_MENU.pos[namespace] = {};
		}

		for (let i=0; i<data.elements.length; i++) {
			if (typeof data.elements[i].type == 'undefined') {
				data.elements[i].type = 'default';
			}
		}

		data._index     = ESX_MENU.focus.length;
		data._namespace = namespace;
		data._name      = name;

		for (let i=0; i<data.elements.length; i++) {
			data.elements[i]._namespace = namespace;
			data.elements[i]._name      = name;
		}

		ESX_MENU.opened[namespace][name] = data;
		ESX_MENU.pos   [namespace][name] = 0;

		for (let i=0; i<data.elements.length; i++) {
			if (data.elements[i].selected) {
				ESX_MENU.pos[namespace][name] = i;
			} else {
				data.elements[i].selected = false;
			}
		}

		ESX_MENU.focus.push({
			namespace: namespace,
			name     : name
		});
		
		current_name = name
		ESX_MENU.render(true, false);
		$('#menu_' + namespace + '_' + name).find('.menu-item.selected')[0].scrollIntoView();
	};

	ESX_MENU.close = function(namespace, name) {
		
		delete ESX_MENU.opened[namespace][name];

		for (let i=0; i<ESX_MENU.focus.length; i++) {
			if (ESX_MENU.focus[i].namespace == namespace && ESX_MENU.focus[i].name == name) {
				ESX_MENU.focus.splice(i, 1);
				break;
			}
		}

		ESX_MENU.render(false, true);

	};

	ESX_MENU.render = function(first, close, name) {
		if (current_name === 'skin') {
			first = false
		}

		let menuContainer       = document.getElementById('menus');
		let focused             = ESX_MENU.getFocused();
		menuContainer.innerHTML = '';


		$(menuContainer).hide();

		for (let namespace in ESX_MENU.opened) {
			for (let name in ESX_MENU.opened[namespace]) {

				let menuData = ESX_MENU.opened[namespace][name];
				let view     = JSON.parse(JSON.stringify(menuData));

				for (let i=0; i<menuData.elements.length; i++) {
					let element = view.elements[i];

					switch (element.type) {
						case 'default' : break;

						case 'slider' : {
							element.isSlider    = true;
							element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value];

							break;
						}

						default : break;
					}

					if (i == ESX_MENU.pos[namespace][name]) {
						element.selected = true;
					}
				}

				let menu = $(Mustache.render(MenuTpl, view))[0];
				$(menu).hide();
				menuContainer.appendChild(menu);
			}
		}

		if (typeof focused != 'undefined') {
			$('#menu_' + focused.namespace + '_' + focused.name).show();
		}
		if (first) {
		    // const audio = new Audio('https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/889995977849712650/926879402330046464/click-round-pop-2.wav');
			const audio = new Audio('https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/819384704087359518/928484919624224788/1.wav');
			audio.play();

		    $(menuContainer).fadeIn(200)
		} else {
            if (current_name !== 'skin') {
		        // const audio = new Audio('https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/889995977849712650/926879402527170560/click-round-pop-3.wav');
				const audio = new Audio('https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/819384704087359518/928485599252475924/2.wav');
			    audio.play();
            }
			
			$(menuContainer).show();
		}

	};

	ESX_MENU.submit = function(namespace, name, data) {
		$.post('http://' + ESX_MENU.ResourceName + '/menu_submit', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : ESX_MENU.opened[namespace][name].elements
		}));
	};

	ESX_MENU.cancel = function(namespace, name) {
		$.post('http://' + ESX_MENU.ResourceName + '/menu_cancel', JSON.stringify({
			_namespace: namespace,
			_name     : name
		}));
	};

	ESX_MENU.change = function(namespace, name, data) {
		$.post('http://' + ESX_MENU.ResourceName + '/menu_change', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : ESX_MENU.opened[namespace][name].elements
		}));
	};

	ESX_MENU.getFocused = function() {
		return ESX_MENU.focus[ESX_MENU.focus.length - 1];
	};

	window.onData = (data) => {

		switch (data.action) {

			case 'openMenu': {
				ESX_MENU.open(data.namespace, data.name, data.data, data.effect);
				break;
			}

			case 'closeMenu': {
				ESX_MENU.close(data.namespace, data.name);
				break;
			}

			case 'controlPressed': {

				switch (data.control) {

					case 'ENTER': {
						let focused = ESX_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							if (menu.elements.length > 0) {
								ESX_MENU.submit(focused.namespace, focused.name, elem);
							}
						}

						break;
					}

					case 'BACKSPACE': {
						let focused = ESX_MENU.getFocused();

						if (typeof focused != 'undefined') {
							ESX_MENU.cancel(focused.namespace, focused.name);
						}

						break;
					}

					case 'TOP': {

						let focused = ESX_MENU.getFocused();

						if (typeof focused != 'undefined') {

							let menu = ESX_MENU.opened[focused.namespace][focused.name];
							let pos  = ESX_MENU.pos[focused.namespace][focused.name];

							if (pos > 0) {
								ESX_MENU.pos[focused.namespace][focused.name]--;
							} else {
								ESX_MENU.pos[focused.namespace][focused.name] = menu.elements.length - 1;
							}

							let elem = menu.elements[ESX_MENU.pos[focused.namespace][focused.name]];

							for (let i=0; i<menu.elements.length; i++) {
								if (i == ESX_MENU.pos[focused.namespace][focused.name]) {
									menu.elements[i].selected = true;
								} else {
									menu.elements[i].selected = false;
								}
							}

							ESX_MENU.change(focused.namespace, focused.name, elem);
							ESX_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;

					}

					case 'DOWN' : {

						let focused = ESX_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu   = ESX_MENU.opened[focused.namespace][focused.name];
							let pos    = ESX_MENU.pos[focused.namespace][focused.name];
							let length = menu.elements.length;

							if (pos < length - 1) {
								ESX_MENU.pos[focused.namespace][focused.name]++;
							} else {
								ESX_MENU.pos[focused.namespace][focused.name] = 0;
							}

							let elem = menu.elements[ESX_MENU.pos[focused.namespace][focused.name]];

							for (let i=0; i<menu.elements.length; i++) {
								if (i == ESX_MENU.pos[focused.namespace][focused.name]) {
									menu.elements[i].selected = true;
								} else {
									menu.elements[i].selected = false;
								}
							}

							ESX_MENU.change(focused.namespace, focused.name, elem);
							ESX_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;
					}

					case 'LEFT' : {

						let focused = ESX_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu = ESX_MENU.opened[focused.namespace][focused.name];
							let pos  = ESX_MENU.pos[focused.namespace][focused.name];
							let elem = menu.elements[pos];

							switch(elem.type) {
								case 'default': break;

								case 'slider': {
									let min = (typeof elem.min == 'undefined') ? 0 : elem.min;

									if (elem.value > min) {
										elem.value--;
										ESX_MENU.change(focused.namespace, focused.name, elem);
									}

									ESX_MENU.render(false, false);
									break;
								}

								default: break;
							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;
					}

					case 'RIGHT' : {

						let focused = ESX_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu = ESX_MENU.opened[focused.namespace][focused.name];
							let pos  = ESX_MENU.pos[focused.namespace][focused.name];
							let elem = menu.elements[pos];

							switch(elem.type) {
								case 'default': break;

								case 'slider': {
									if (typeof elem.options != 'undefined' && elem.value < elem.options.length - 1) {
										elem.value++;
										ESX_MENU.change(focused.namespace, focused.name, elem);
									}

									if (typeof elem.max != 'undefined' && elem.value < elem.max) {
										elem.value++;
										ESX_MENU.change(focused.namespace, focused.name, elem);
									}

									ESX_MENU.render(false, false);
									break;
								}

								default: break;
							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;
					}

					default : break;

				}

				break;
			}

		}

	};

	window.onload = function(e){
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();