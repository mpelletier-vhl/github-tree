
$(document).ready(function() {
  OAuth.initialize('OzXQoIVWxW526_qt8cp8R2kyPaU', options = {cache: true});

	OAuth.popup('github', function(error, result) {
		console.log(result);
	});

});