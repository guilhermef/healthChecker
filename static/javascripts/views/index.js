HealthChecker = function() {
  this.init();
};

HealthChecker.prototype = {

  init: function() {
    $('.project').each(this.setHealthcheck.bind(this));
  },

  setHealthcheck: function(i, element){
    var project = $(element),
      url = project.data('healthcheck');
    setInterval(this.healthCheck.bind(this, project, url), 10000);
  },

  healthCheck: function(project, url){
    project.removeClass('down').removeClass('ok');
    $.ajax({
      url: url,
      context: project
    }).done(this.healthCheckCallback);
  },

  healthCheckCallback: function(response){
    this.addClass(response.status);
  }
};

new HealthChecker();
