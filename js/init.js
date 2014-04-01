$(document).ready(function() {
  OAuth.initialize('5K2-WvCelwL0WSroLuUViEz4gpU', options = {cache: false});

	OAuth.popup('github', function(error, result) {
		chrome.runtime.sendMessage({ messages: result});
	});
});