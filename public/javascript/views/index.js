var config;

$(document).ready(function(){
	$.getJSON('/config', function(data){
		config = data;
		var monitores = '';
		var $ul_moniotres = $('#monitores');
		for (var project_key in config.projects) {
			var project = config.projects[project_key];
			$ul_moniotres.append(html_monitor_for(project));
			setTimeout(function(){ updateStatus(project); },1000);
		}
	});
});


function updateStatus(project){
  $.ajax({
		url: 			'/project/'+project.id,
		success:  function(data ){append_li_status(project,data)},
		error:    showMessageError
	});
}

function showMessageError(XMLHttpRequest, textStatus, errorThrown){
  console.log(XMLHttpRequest, textStatus, errorThrown); 
  update_status('error',   project);
}

function append_li_status(project, status){
  var $li = $("ul#monitores li#"+project.id);
  var $ul_electro = $li.find("ul");
  var old_status = $li.attr("status");
  var actual_status = status;
  var class_css = "";
  if(actual_status == "200"){
    if(actual_status != old_status){
      class_css = "beginning_fail";
    }
  } else {
    if(actual_status != old_status){
      class_css = "beginning_ok";
    }else {
      class_css = "fail";
    }
  }
  html_li = '<li class="{classe}"></li>'.replace('{classe}',class_css);
  $ul_electro.append(html_li);
}
function html_monitor_for(project){
  var monitor_template = '<li id="{id}" status="200">{title}<ul><li></li><li class="beginning_fail"></li><li class="fail"></li><li class="beginning_ok"></li><li></li></ul></li>';
  return monitor_template.replace('{img}',   project.imgOk)
                         .replace('{title}', project.name)
                         .replace('{alt}',   project.name)
                         .replace('{id}',    project.id);
}
