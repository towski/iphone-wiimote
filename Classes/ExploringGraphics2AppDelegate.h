//
//  ExploringGraphics2AppDelegate.h
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphicsView;

@interface ExploringGraphics2AppDelegate : NSObject
{
	UIWindow *window;
	GraphicsView *contentView;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) GraphicsView *contentView;

@end

