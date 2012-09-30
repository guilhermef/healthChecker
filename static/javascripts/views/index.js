HealthChecker = function() {
  this.init();
};

HealthChecker.prototype = {

  init: function() {
    $('.project').each(this.setHealthcheck.bind(this));
  },

  setHealthcheck: function(i, element){
    var project = $(element);
    setInterval(this.healthCheck.bind(this, project), 5000);
  },

  healthCheck: function(project){
    var url = project.data('healthcheck');
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
