var healthCheckCallback = function(response){
  var status = response.status;
  this.addClass(status);

  // if (status != "ok"){
  //   var $errors = $('<span>').addClass('errors');

  //   this.append
  // }
};

var healthCheck = function(project) {
  var url = project.data('healthcheck');
  project.removeClass('down').removeClass('ok');
  $.ajax({
    url: url,
    context: project
  }).done(healthCheckCallback);
};

(function(){
  $('.project').each(function(){
    var project = $(this);
    setInterval(function(){ healthCheck(project);}, 5000);
  });
})();


