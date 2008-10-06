//
//  ExploringGraphics2AppDelegate.m
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import "ExploringGraphics2AppDelegate.h"
#import "GraphicsView.h"

@implementation ExploringGraphics2AppDelegate

@synthesize window;
@synthesize contentView;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{	
	// Create window
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Everything happens in the GraphicsView
	self.contentView = [[[GraphicsView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
	[window addSubview:contentView];
    
	[window makeKeyAndVisible];
}


- (void)dealloc {
	[contentView release];
	[window release];
	[super dealloc];
}

@end
