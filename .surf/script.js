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

	if (window.location.hostname == "www.startpage.com") {
		var answers = document.querySelectorAll(".w-gl__result-title");
		var index = 0
		answers[index].focus()

		up = function () {
			if (index == 0) {
				return;
			}
			index -= 1;
			answers[index].focus()
		}

		down = function () {
			if (index >= answers.length - 1) {
				return;
			}
			index += 1;
			answers[index].focus()
		}

		right = function() {
			answers[index].click()
		}

		var search_field = document.getElementById('q')
		search = function() {
			search_field.focus()
		}

		search_field.addEventListener('keypress', (ev) => {
			if (ev.key == "Escape") {
				answers[index].focus()
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
		if (element.nodeName.toLowerCase() == "input" && element.type == "text") {
			return true;
		}

		// element is editable
		if (document.designMode == "on" || element.contentEditable == "true") {
			return true;
		}

		return false;
	}

	function deleteWord(element) {
		if (element.nodeName.toLowerCase() != "input") {
			return;
		}
		var i = element.selectionEnd;
		while (i > 0 && element.value[i] != ' ') {
			i -= 1;
		}
		while (i > 0 && element.value[i - 1] == ' ') {
			i -= 1;
		}
		element.value = element.value.slice(0, i)
	}

	function keypress(evt) {
		var target = evt.target;

		// if we're on a editable element, we probably don't want to catch
		// keypress, we just want to write the typed character.
		if (isEditable(target)) {
			if (evt.ctrlKey && String.fromCharCode(evt.charCode) == 'w') {
				deleteWord(evt.target);
			}
			return;
		}

		var key = String.fromCharCode(evt.charCode);
		if (evt.ctrlKey) {
			key = '^' + key;
		}

		var fun = bindings[key];
		if (fun) {
			evt.preventDefault()
			fun();
		}
	}

	window.addEventListener("keypress", keypress, false);
}
