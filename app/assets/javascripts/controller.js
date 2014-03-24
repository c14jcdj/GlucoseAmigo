var Controller = function(data){
  this.view = data.view;
  this.user = data.user;
}

Controller.prototype = {
  nextPageEvent: function(response){
    this.view.reloadPage(response);
  },
  addAlert: function(alert){
    this.view.addAlert(alert);
  },
  logout: function(){
    Ajax.logout(this.user.uId, this.loadNextPage.bind(this));
  },
  loadNextPage: function(response){
    Ajax.get(response.target, this.view.newPage.bind(this.view));
  },
  loadSignUp: function(event){
    Ajax.get(event.target.href, this.nextPageEvent.bind(this));
  }
}