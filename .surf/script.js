if (up === undefined) {

	function page_percent(percent) {
		return window.innerHeight * percent / 100;
	}

	var up = window.scrollByLines
		? function () { window.scrollByLines(-5); }
		: function () { window.scrollBy(0, -page_percent(10)); }
	;

	var down = window.scrollByLines
		? function () { window.scrollByLines(5); }
		: function () { window.scrollBy(0, page_percent(10)); }
	;

	var pageup = window.scrollByPages
		? function () { window.scrollByPages(-1); }
		: function () { window.scrollBy(0, page_percent(95)); }
	;

	var pagedown = window.scrollByPages
		? function () { window.scrollByPages(1); }
		: function () { window.scrollBy(0, -page_percent(95)); }
	;

	var search = null

	function right() {
		window.scrollBy(page_percent(10), 0);
	}

	function left() {
		window.scrollBy(-page_percent(10), 0);
	}

	function home() {
		window.scroll(0, 0);
	}

	function bottom() {
		window.scroll(0, document.body.scrollHeight);
	}

	if (document.head.innerHTML.includes("Book generated using mdBook")) {
		left = function () {
			document.querySelector(".previous").click()
		}

		right = function () {
			document.querySelector(".next").click()
		}
	}

	var queries = {
		"www.startpage.com": ".w-gl__result-title",
		"www.google.com": "a[jsname='UWckNb']",
		"search.brave.com": ".h",
		"search.disroot.org": ".result > h3 > a",
	};

	var query = queries[window.location.hostname]
	if (query) {
		document.querySelector(query).focus()

		up = function () {
			let elements = document.querySelectorAll(query)
			if (!elements) {
				return;
			}
			let index = Array.prototype.indexOf.call(elements, document.activeElement);
			if (index < 0) {
				index = 0;
			}
			if (index >= 1) {
				index -= 1;
			}
			elements[index].focus()
		}

		down = function () {
			let elements = document.querySelectorAll(query)
			if (!elements) {
				return;
			}
			let index = Array.prototype.indexOf.call(elements, document.activeElement);
			if (index < 0) {
				index = 0;
			}
			if (index < elements.length - 1) {
				index += 1;
			}
			elements[index].focus()
		}

		right = function() {
			document.activeElement.click()
		}

		var search_field = document.querySelector('#q,#searchbox,textarea[name="q"]')
		search = function() {
			search_field.focus()
		}

		search_field.addEventListener('keypress', (ev) => {
			console.log(ev.key)
			if (ev.key == "Escape") {
				document.querySelector(query).focus()
			}
		})

	}

	// If you don't like default key bindings, customize here.
	// if you want to use the combination 'Ctrl + b' (for example), use '^b'
	var bindings = {
		'h': left,
		'l': right,
		'k': up,
		'j': down,
		'g': home,
		'G': bottom,
		'd': pageup,
		'u': pagedown,
		'/': search,
	}

	function isEditable(element) {
		if (element.nodeName.toLowerCase() == "textarea") {
			return true;
		}

		// we don't get keypress events for text input, but I don't known
		// if it's a bug, so let's test that
		if (element.nodeName.toLowerCase() == "input") {
			return true;
		}

		// element is editable
		if (document.designMode == "on" || element.contentEditable == "true") {
			return true;
		}

		return false;
	}

	function deleteWord(element) {
		if (!element.selectionEnd || !element.value) {
			return;
		}
		var i = element.selectionEnd - 1;
		var word_delimiters = '`~!?@#$%^&*()[]{}<>-_=+ \t\n\r|\\//;:\'\",.';
		while (i > 0 && element.value[i] == ' ') {
			i -= 1;
		}
		if (word_delimiters.includes(element.value[i])) {
			i -= 1;
		}
		else {
			while (i >= 0 && !word_delimiters.includes(element.value[i])) {
				i -= 1;
			}
		}
		element.value = element.value.slice(0, i + 1) + element.value.slice(element.selectionEnd, element.value.length)
		element.selectionEnd = i + 1
	}

	function keypress(event) {
		// if we're on a editable element, we probably don't want to catch
		// keypress, we just want to write the typed character.
		if (isEditable(event.target)) {
			if (event.ctrlKey && String.fromCharCode(event.charCode) == 'w') {
				deleteWord(event.target);
			}
			return;
		}

		var key = String.fromCharCode(event.charCode);
		if (event.ctrlKey) {
			key = '^' + key;
		}

		var fun = bindings[key];
		if (fun) {
			event.preventDefault()
			fun();
		}
	}

	window.addEventListener("keypress", keypress, false);
}
