var config;

$(document).ready(function(){
	$.getJSON('/config', function(data){
		config = data;
		var monitores = '';
		var $ul_moniotres = $('#monitores');
		for (var project_key in config.projects) {
			var project = config.projects[project_key];
			$ul_moniotres.append(html_monitor_for(project));
			$.ajax({
				url: 			'/projeto/'+project_key,
				success:  function() { update_status('success', project) },
				error:    showMessageError
			});
		}
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

function showMessageError(XMLHttpRequest, textStatus, errorThrown){
  console.log(XMLHttpRequest, textStatus, errorThrown); 
  update_status('error',   project);
}

function html_monitor_for(project){
  var monitor_template = '<li><img id="{id}" src="{img}" alt="{alt}" title="{title}" /></li>';
  return monitor_template.replace('{img}',   project.imgOk)
                         .replace('{title}', project.name)
                         .replace('{alt}',   project.name)
                         .replace('{id}',    project.id);
}
function html_graphic_for(data){
  return false;
}
