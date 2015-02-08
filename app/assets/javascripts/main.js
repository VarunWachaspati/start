$(document).ready(function(){

  //Preloader
  $(window).load(function() {
    $("#loader").fadeOut();
    $("#mask").delay(1000).fadeOut("slow");
  });

  //Adding fixed position to header
  $(document).scroll(function() {
    if ($(document).scrollTop() >= 500) {
      $('.navbar').addClass('navbar-fixed-top');
      $('html').addClass('has-fixed-nav');
    } else {
      $('.navbar').removeClass('navbar-fixed-top');
      $('html').removeClass('has-fixed-nav');
    }
  });

  //Navigation Scrolling
  $('a[href*=#]').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });

  //Close navbar on click
  $('.nav a').on('click', function(){
    if ($(window).width() < 768) {
      $(".navbar-toggle").click();
    }
  });

  //Nav Selection
  $('#nav').onePageNav({
    currentClass: 'active',
    scrollOffset: 50
  });

  //Home Text Slider
  $('.home-slider').flexslider({
      animation: "slide",
      directionNav: false,
      controlNav: false,
      direction: "vertical",
      slideshowSpeed: 5000,
      animationSpeed: 1000,
      smoothHeight: true,
      useCSS: false
  });

  //Elements animation
  $('.animated').appear(function(){
    var element = $(this);
    var animation = element.data('animation');
    var animationDelay = element.data('delay');
    if (animationDelay) {
      setTimeout(function(){
        element.addClass( animation + " visible" );
        element.removeClass('hiding');
        if (element.hasClass('counter')) {
          element.children('.value').countTo();
        }
      }, animationDelay);
    }else {
      element.addClass( animation + " visible" );
      element.removeClass('hiding');
      if (element.hasClass('counter')) {
        element.children('.value').countTo();
      }
    }    
  },{accY: -150});

  //Portfolio project slider
  function initProjectSlider() {
    $('.project-slider').flexslider({
      prevText: "",
      nextText: "",
      useCSS: false,
      animation: "slide"
    });
  };

  //Portfolio Project Loading
  $('.open-project').click(function(){
    $('html, body').animate({ scrollTop: $("#project-extended").offset().top }, 900); 
    var projectUrl = $(this).attr("href");      
    
    $('#project-content').animate({opacity:0}, 400,function(){
      $("#project-content").load(projectUrl);
      $('#project-content').delay(400).animate({opacity:1}, 400);
    });  
    
    //Project Page Open
    $('#project-extended').slideUp(600, function(){
      $('#project-extended').addClass('open');
    }).delay(500).slideDown(600,function(){          
        $('#project-content').fadeIn('slow',function(){
          if ($('.project-slider').length > 0) {
            initProjectSlider();
          }
        });
    });

    return false;       
  
  });

  //Project Page Close
  $('#close-project').click(function(event) {
    $('#project-content').animate({opacity:0}, 400,function(){
      $('#project-extended').delay(400).slideUp(400).removeClass('open');
      $('html, body').animate({ scrollTop: $("#portfolio-grid").offset().top -60}, 900);
    });
    return false;
  });
});