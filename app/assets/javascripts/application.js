// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require masonry/jquery.imagesloaded.min
//= require_tree .

var max_height    = 300;
var min_row_width = 600;
var pic_margin    = 4;
var right_margin  = 10;

function h_origin_size() {
  $(".h_img").each(function(i){
    var max_width = $(this).width() * max_height / $(this).height();
    $(this).attr('height', max_height);
    $(this).attr('width', max_width);
  });
}

function h_mark_old_row_div() {
  $(".h_row").each(function(i){
    $(this).attr('class', 'h_delete');
  });
}

function h_delete_old_row() {
  $(".h_delete").each(function(){
    $(this).remove();
  });
}

var waitForFinalEvent = (function () {
  var timers = {};
  return function (callback, ms, uniqueId) {
    if (!uniqueId) {
      uniqueId = "Don't call this twice without a uniqueId";
    }
    if (timers[uniqueId]) {
      clearTimeout (timers[uniqueId]);
    }
    timers[uniqueId] = setTimeout(callback, ms);
  };
})();

function reset_height(current_width, layout_width) {
  $("#h_layout").append("<div class='h_row' id='last_h_row'></div>");
  var height = max_height;
  if(current_width > layout_width) {
    height = (layout_width - right_margin) * max_height  / current_width;
  }
  $(".one_line").each(function(i){
    if(current_width > layout_width) {
      var width = $(this).width() * height / $(this).height();
      $(this).attr('height', height);
      $(this).attr('width', width);
    }
    $(this).parent().parent().appendTo("#last_h_row")
  });
  $("#last_h_row").removeAttr("id");
  $(".one_line").each(function(i){
    $(this).attr('class', 'h_img');
  });
}

function h_layout(layout_width) {
  var current_width = 0;

  $(".h_img").each(function(i){
    current_width = current_width + $(this).width() + pic_margin;
    $(this).attr('class', 'one_line');
    if (current_width > layout_width) {
      reset_height(current_width, layout_width);
      current_width = 0;
    }
  });
  reset_height(current_width, layout_width);
  current_width = 0;
}

function s_layout() {
  var cal_height = $(window).height() - 200;
  if( cal_height > 900 ) {
    cal_height = 900;
  }
  $("#s_img").attr('height', cal_height);

  var max_width = $(window).width() - 500;
  var cal_width = cal_height * 16 / 9;
  if( cal_width > max_width ){
    cal_width = max_width;
  }
  $(".s_wrap_img iframe").attr({'height':cal_height, 'width':cal_width});
}

$(document).ready(function(){
  $("#h_layout").imagesLoaded(function(){
    var layout_width = $("#h_layout").width();
    if( layout_width < min_row_width ) {
      layout_width = min_row_width;
      $("#h_layout").attr('width', layout_width);
    }
    h_layout( layout_width );
  });

  s_layout();
});

$(window).resize(function(){
  waitForFinalEvent(function(){
    var layout_width = $("#h_layout").width();
    if( layout_width < min_row_width ) {
      layout_width = min_row_width;
      $("#h_layout").attr('width', layout_width);
    }
    h_origin_size();
    h_mark_old_row_div();
    h_layout( layout_width );
    h_delete_old_row();
  }, 500, "v_layout");

  waitForFinalEvent(function(){
    s_layout();
  }, 500, "s_img");
});
