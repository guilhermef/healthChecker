$(document).ready(function(){
		$('.projects').each(function(){
				console.log( "Project Name: " + $(this).children('span')[0] );
		});
});