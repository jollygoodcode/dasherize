window.Dasherize = {
  init: function() {
    Turbolinks.ProgressBar.enable();

    // Material Forms
    $('select').material_select();

    // Material SideNav for Mobile View
    $(".button-collapse").sideNav();
  }
};
