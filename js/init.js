
$(document).ready(function() {
  OAuth.initialize('5K2-WvCelwL0WSroLuUViEz4gpU', options = {cache: true});

	OAuth.popup('github', function(error, result) {
		console.log(result);
	});

});