/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import "TiUIScrollViewProxy.h"
#import "TiUIScrollView.h"
#import "TiUIScrollableViewProxy.h"
#import "TiUIScrollableView.h"

@interface CoCoolelephantTandemscrollModule : TiModule<UIScrollViewDelegate>
{
    NSMutableArray* scrollViews;
    UIScrollView* controllingScrollView;
    
    float parallaxFactorX;
    float parallaxFactorY;
    
    
}

@end
