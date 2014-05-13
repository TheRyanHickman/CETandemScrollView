/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "CoCoolelephantTandemscrollModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation CoCoolelephantTandemscrollModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"341efc7d-56c1-4a6d-a4ad-237ac9071014";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"co.coolelephant.tandemscroll";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)unbindScrollViews
{
    if (scrollViews) {
        for (TiUIScrollViewProxy* proxy in scrollViews) {
            [proxy forgetSelf];
        }
        RELEASE_TO_NIL(scrollViews);
    }
}

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

-(UIScrollView*)toScrollView:(id)view
{
    UIScrollView* scrollView = nil;
    if ([view respondsToSelector:@selector(scrollView)]) {
        scrollView = [view scrollView];
    }
    else if ([view respondsToSelector:@selector(scrollview)]) {
        scrollView = [view scrollview];
    }
    return scrollView;
}

#pragma Public APIs

-(void)lockTogether:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    [self unbindScrollViews];
    
    //How much offset to apply
    parallaxFactorX = [TiUtils floatValue:[args objectForKey:@"parallaxFactorX"] def:1];
    parallaxFactorY = [TiUtils floatValue:[args objectForKey:@"parallaxFactorY"] def:1];

    
    scrollViews = [[NSMutableArray alloc] initWithCapacity:[args count]];
    
    for (TiViewProxy* proxy in [args objectForKey:@"views"]) {
        [proxy rememberSelf];
        id view = proxy.view;
        UIScrollView* scroll = [self toScrollView:view];
        scroll.delegate = self;
        [scrollViews addObject:proxy];
    }
}

#pragma UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    controllingScrollView = scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // We only care about scroll events from the view that is actually being dragged by the user.
    if (scrollView != controllingScrollView)
        return;
    
    for (TiViewProxy* proxy in scrollViews)
    {
        // Skip the view that is actually scrolling,
        id view = proxy.view;
        UIScrollView* scroll = [self toScrollView:view];
        if (scroll == controllingScrollView)
        {
            CGPoint offset = [scrollView contentOffset];
            [proxy fireEvent:@"scroll" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   NUMFLOAT(offset.x),@"x",
                                                   NUMFLOAT(offset.y),@"y",
                                                   NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                                   NUMBOOL([scrollView isDragging]),@"dragging", nil]];
            continue;
        }
        
        // Scroll proportionally.
        [scroll setContentOffset:CGPointMake(scrollView.contentOffset.x * scroll.contentSize.width * parallaxFactorY / scrollView.contentSize.width,
                                             scrollView.contentOffset.y * scroll.contentSize.height * parallaxFactorX / scrollView.contentSize.height) animated:NO];
    }
}

@end
