var config;

$(document).ready(getConfigAndMakeHtml);

function getConfigAndMakeHtml(){
  $.getJSON('/config',makeHtml);
  setTimeout('getConfigAndMakeHtml()', 2000);
}

function makeHtml(data){
  config = data;
  var monitores = '';
  var $ul_monitores = $('#monitores');
  for (var project_key in config.projects) {
    var project = config.projects[project_key];
    if($.isEmptyObject($ul_monitores.find("li#"+project_key).html())){
      $ul_monitores.append(html_monitor_for(project));
    }
    updateStatus(project);
  }
}

function updateStatus(project){
  $.ajax({
    url: '/project/'+project.id,
    dataType: "json",
    success:  append_li_status,
    error:    showMessageError
  });
}

function showMessageError(XMLHttpRequest, textStatus, errorThrown){
  console.log(XMLHttpRequest, textStatus, errorThrown); 
  update_status('error',   project);
}

function append($ul,html){
  var tam = $ul.find("li").length;
  if(tam >= 8 ){
    $ul.find("li:first").remove();
  }
  $ul.append(html);
}

function append_li_status(data){
  var $li = $("ul#monitores li#"+data.project_name);
  var $ul_electro = $li.find("ul");
  var old_status = $li.attr("status");
  var actual_status = data.status;
  append($ul_electro,htmlFromStatus(actual_status,old_status));
  $li.attr("status", actual_status);
}

function htmlFromStatus(actualStatus, oldStatus){
  var ret = liHtmlForOk();
  if(actualStatus == "200"){
    if(changeStatus(actualStatus,oldStatus)){
      ret = liHtmlForBeginningFail();
    }
  } else {
    if(changeStatus(actualStatus,oldStatus)){
      ret = liHtmlForBeginningOk();
    }else {
      ret = liHtmlForFail();
    }
  }
  return ret;
}

function changeStatus(actualStatus, oldStatus){
  return (actualStatus != oldStatus);
}

function liHtmlForOk(){
  return '<li class=""></li>'
}

function liHtmlForBeginningOk(){
  return '<li class="beginning_ok"></li>'
}

function liHtmlForBeginningFail(){
  return '<li class="beginning_fail"></li>'
}
function liHtmlForFail(){
  return '<li class="fail"></li>'
}

function html_monitor_for(project){
  var monitor_template = '<li id="{id}" status="200" class="projeto"><span>{title}</span><div><ul></ul></div></li>';
  return monitor_template.replace('{title}', project.name)
                         .replace('{id}',    project.id);
}

