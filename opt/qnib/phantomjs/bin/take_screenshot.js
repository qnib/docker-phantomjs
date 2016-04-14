var page = new WebPage(),
    system = require('system'),
    s_width = 1280,
    s_height = 960,
    screen_url = system.args[1],
    shot_path = system.args[2],
    screendelay = parseInt(system.args[3]);

//viewportSize being the actual size of the headless browser
page.viewportSize = { width: s_width, height: s_height };
//the clipRect is the portion of the page you are taking a screenshot of
page.clipRect = { top: 0, left: 0, width: s_width, height: s_height };
// if a thrid arg is given
if (system.args.length === 5) {
    page.customHeaders={'Authorization': 'Bearer '+ system.args[4]};
}
page.open(screen_url, function (status) {
        just_wait();
});

function just_wait() {
    setTimeout(function() {
            page.render(shot_path);
            phantom.exit();
    }, screendelay);
}
