/*
 *	This example adds a ScrollView behind a ScrollableView and moves the ScrollView horizontally as we page
 *	You can imagine using this in an app tutorial or similar
 */

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});
var TandemScroll = require('co.coolelephant.tandemscroll');

//Create a background view with three separate colours
var backgroundView = Ti.UI.createScrollView({
	width: Ti.Platform.displayCaps.platformWidth,
	contentWidth: 'auto',
	contentHeight: 'auto',
	height: Ti.UI.FILL,
	touchEnabled: false
});
var image = Ti.UI.createImageView({
	image: 'image.jpg'
});
backgroundView.add(image);

win.add(backgroundView);

//Add our scrollable view
var page1 = Ti.UI.createView({
	width: Ti.Platform.displayCaps.platformWidth,
	height: Ti.UI.FILL,
	backgroundColor: 'transparent'
});
var p1Label = Ti.UI.createLabel({
	text: 'TUTORIAL PAGE 1',
	color: 'white',
	width: Ti.UI.FILL,
	height: Ti.UI.SIZE,
	textAlign: 'center'
});
page1.add(p1Label);

var page2 = Ti.UI.createView({
	width: Ti.Platform.displayCaps.platformWidth,
	height: Ti.UI.FILL,
	backgroundColor: 'transparent'
});
var p2Label = Ti.UI.createLabel({
	text: 'TUTORIAL PAGE 2',
	color: 'white',
	width: Ti.UI.FILL,
	height: Ti.UI.SIZE,
	textAlign: 'center'
});
page2.add(p2Label);

var page3 = Ti.UI.createView({
	width: Ti.Platform.displayCaps.platformWidth,
	height: Ti.UI.FILL,
	backgroundColor: 'transparent'
});
var p3Label = Ti.UI.createLabel({
	text: 'TUTORIAL PAGE 3',
	color: 'white',
	width: Ti.UI.FILL,
	height: Ti.UI.SIZE,
	textAlign: 'center'
});
page3.add(p3Label);

var scrollableView = Ti.UI.createScrollableView({
	width: Ti.UI.FILL,
	height: Ti.UI.SIZE,
	views: [page1, page2, page3]
});

win.add(scrollableView);

TandemScroll.lockTogether({
	views: [scrollableView,backgroundView],
	parallaxFactorX: 0.6,
	parallaxFactorY: 1
});

scrollableView.addEventListener('scroll', function (evt) {
    Ti.API.info(evt.x + ',' + evt.y);

});

win.open();

/*
 *	Traditional TandemScrollView example - uncomment this one and comment out the previous one to try it out
 */
 /*
var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});
var TandemScroll = require('co.coolelephant.tandemscroll');
var scrollViews = [];
for (var i = 0; i < 3; i++) {
    var scrollView = Ti.UI.createScrollView({
        contentWidth: 1000 * (i + 1),
        contentHeight: 1000 * (i + 1)
    });
    scrollView.add(Ti.UI.createLabel({
        text: 'I am Scroll View ' + i,
        width: 160, height: 30,
        top: 200 + 70 * i, left: 200 + 40 * i
    }));
    scrollViews.push(scrollView);
    win.add(scrollView);
}
TandemScroll.lockTogether({
	views: scrollViews
});
scrollViews[scrollViews.length-1].addEventListener('scroll', function (evt) {
    Ti.API.info(evt.x + ',' + evt.y);
});
win.open();
*/
