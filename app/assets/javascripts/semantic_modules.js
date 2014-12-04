$(document).on('click', '.dropdown', function() {
  $(this).dropdown('show');
}).on('mouseleave', '.dropdown', function(){
  $('.ui.dropdown').dropdown('hide');
});

window.onload = function(e) {
  $('.tooltip').popup({
    position: 'top center'
  });

  $('.ui.accordion').accordion();

  $('#tabs a').on('click', function(){
    $('#tabs a').removeClass('active');
    $('.main-content').hide();

    $(this).addClass('active');
    var current = $(this).attr('href');
    $(current).show();
    return false;
  });
};