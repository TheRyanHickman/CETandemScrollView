CETandemScrollView
===========================================


This is a revamp of the Titanium [TandemScroll](https://github.com/appcelerator/titanium_modules/tree/master/tandemscroll/mobile/ios) module.

You can lock a number of ScrollViews or ScrollableViews together and proportionally scroll them.  I've added a X,Y parallaxFactor, that allows you to play with the amount of scrolling.

**This is an iOS only module**

<img src="../images/demo.gif" />

## Quick Start

### Get it [![gitTio](http://gitt.io/badge.png)](http://gitt.io/component/co.coolelephant.tandemscroll)
Download the latest distribution ZIP-file and consult the [Titanium Documentation](http://docs.appcelerator.com/titanium/latest/#!/guide/Using_a_Module) on how install it, or simply use the [gitTio CLI](http://gitt.io/cli):

`$ gittio install co.coolelephant.tandemscroll`


### Usage

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
    
There is a ScrollableView demo included with the module that shows how this could be used for an application introduction screen.

####Known Issues
* If you use a ScrollableView, the paging control will not work

## Options

#### views

Type: `Array`  
Default: None (required)

Array of ScrollViews or ScrollableView to lock together (can be mixed).

#### parallaxFactorX

Type: `Float`  
Default: 1 (optional)

Can be used to 'scale' the amount of scrolling in the x-direction, 1 is no scaling 

#### parallaxFactorY

Type: `Float`  
Default: 1 (optional)

Can be used to 'scale' the amount of scrolling in the y-direction, 1 is no scaling 

## Events

### scroll
Fired when the view that is being touched scrolls

##### x
Type: `Float`	
The offset in the x direction the current view has moved
   
##### y
Type: `Float`	
The offset in the y direction the current view has moved

##### decelerating
Type: `Boolean`	
True if the scrolling view is decelerating

##### dragging
Type: `Boolean`	
True if the scrolling view is moving because of a user drag interaction


## Changelog

* v1.0  
  * initial version

##ABOUT THE AUTHOR
Cool Elephant is a front to back end system integration company with a special focus on mobile application design, development and integration. Titanium Appcelerator is one of our specialities!

web: [Cool Elephant](http://coolelephant.co.uk)  
twitter: [@coolelephant](https://twitter.com/coolelephant)  
email: trunk@coolelephant.co.uk


## License

    Copyright (c) 2010-2014 Cool Elephant Ltd

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
