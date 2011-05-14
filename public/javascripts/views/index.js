var config;

getConfigAndMakeHtml= function(){
  $.getJSON('/config',makeHtml);
  setTimeout('getConfigAndMakeHtml()', 2000);
}

$(document).ready(getConfigAndMakeHtml);

makeHtml = function(data){
  config = data;
  var monitores = '';
  var $ul_monitores = $('#monitores');
  for (var project_key in config.projects) {
    var project = config.projects[project_key];
    if($.isEmptyObject($ul_monitores.find("li#"+project_key).html())){
      $ul_monitores.append(html_monitor_for(project));
    }
    showAnalyzing(project);
    updateStatus(project);
  }
}

updateStatus = function (project){
  $.ajax({
    url: '/project/'+project.id,
    dataType: "json",
    success:  append_li_status,
    error:    showMessageError
  });
}

showMessageError = function (XMLHttpRequest, textStatus, errorThrown){
  console.log(XMLHttpRequest, textStatus, errorThrown); 
  update_status('error',   project);
}

append = function($ul,html){
  var tam = $ul.find("li").length;
  if(tam >= 9 ){
    $ul.find("li:first").remove();
  }
  $ul.append(html);
}

append_li_status= function (data){
  var $li = $("ul#monitores li#"+data.project_name);
  var $ul_electro = $li.find("ul");
  var old_status = $li.attr("status");
  var actual_status = data.status;
  append($ul_electro,htmlFromStatus(actual_status,old_status));
  $li.attr("status", actual_status);
}

htmlFromStatus = function(actualStatus, oldStatus){
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

changeStatus = function (actualStatus, oldStatus){
  return (actualStatus != oldStatus);
}

html_monitor_for = function (project){
  var monitor_template = '<li id="{id}" status="200" class="projeto">'
  monitor_template+=' <span>{title}</span>';
  monitor_template+=' <span class="check_sign;al"></span>';
  monitor_template+=' <div>';
  monitor_template+=' <ul></ul>';
  monitor_template+=' </div>';
  monitor_template+=' </li>';
  return monitor_template.replace('{title}', project.name)
                         .replace('{id}',    project.id);
}

showAnalyzing = function (project){
  $("ul#monitores li#"+project.id).toggleClass("analyzing");
}

//Parte de template para montar os elementos na tela
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
