var page = new WebPage(),
    system = require('system'),
    s_width = 1280,
    s_height = 960;

//viewportSize being the actual size of the headless browser
page.viewportSize = { width: s_width, height: s_height };
//the clipRect is the portion of the page you are taking a screenshot of
page.clipRect = { top: 0, left: 0, width: s_width, height: s_height };
// if a thrid arg is given
if (system.args.length === 4) {
    page.customHeaders={'Authorization': 'Bearer '+ system.args[3]};
}
page.open(system.args[1], function (status) {
        just_wait();
});

function just_wait() {
    setTimeout(function() {
            page.render(system.args[2]);
            phantom.exit();
    }, 2000);
}
