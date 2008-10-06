//
//  MyView.h
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Object2D;
@class Vector2D;

@interface GraphicsView : UIView <UIAccelerometerDelegate>
{
    Object2D* ball;
    NSTimer* timer;
    Vector2D* gravity;
    UIAccelerationValue accelX;
    UIAccelerationValue accelY;
    UIAccelerationValue accelXcal;
    UIAccelerationValue accelYcal;   
    int accelCount; 

    CGFloat minX;
    CGFloat maxX;
    CGFloat minY;
    CGFloat maxY;
	NSMutableData *receivedData;
	bool challenged;
	int x_pos;
	int y_pos;
}

- (void)tick;

@end
