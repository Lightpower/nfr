$(function() {
    var stopped = true;

    var swichTime = 10000;
    
    var langs = ['ru', 'ua', 'en'];
    var current = langs.indexOf('ua');
    for (var i in langs) {
        $('<img/>')[0].src = '/assets/logo/' + langs[i] + '_infinite.gif';
        $('<img/>')[0].src = '/assets/logo/' + langs[i] + '_static.gif';
    };
    
    var changeTimeout;
    
    var img = $('#logo img');
    
    function stopAnimation() {
        current = (current + 1) % 3;
        img.attr('src', '/assets/logo/' + langs[current] + '_static.gif');        
        stopped = true;
        changeTimeout = setTimeout(startAnimation, swichTime);
    }
    
    function startAnimation() {
        clearTimeout(changeTimeout);
        stopped = false;
        img.attr('src', '/assets/logo/' + langs[current] + '_infinite.gif');
        setTimeout(stopAnimation, 1000);
    }

    $('#logo').on('mouseover', function() {
        if (stopped) {
            startAnimation();
        }
    })
    
    changeTimeout = setTimeout(startAnimation, swichTime);
})