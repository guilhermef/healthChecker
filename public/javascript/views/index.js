var config;

$(document).ready(function(){
	$.getJSON('/config', function(data){
		config = data;
		var monitor_template = '<li><img id="{id}" src="{img}" alt="{alt}" title="{title}" /></li>';
		
		var monitores = '';
		for (var project_key in config.projects) {
			var project = config.projects[project_key];
			
			monitores += monitor_template.replace('{img}',   project.imgOk)
																	 .replace('{title}', project.name)
																	 .replace('{alt}',   project.name)
																	 .replace('{id}',    project.id);

			$.ajax({
				url: 			'/projeto/'+project_key,
				success:  function() { update_status('success', project) },
				error:    function(XMLHttpRequest, textStatus, errorThrown) { console.log(XMLHttpRequest, textStatus, errorThrown); update_status('error',   project) }
			});
		}
		$('#monitores').html(monitores);
	});
});


function update_status(status, project) {
	if (status == 'success') {
		$('#'+project.id).attr('src', project.imgOk);
	}
	else {
		$('#'+project.id).attr('src', project.imgOut);
	}
}
