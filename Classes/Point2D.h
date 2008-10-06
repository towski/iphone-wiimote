//
//  Point2D.h
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vector2D;

@interface Point2D : NSObject
{
    CGFloat X;
    CGFloat Y;
}

@property (assign) CGFloat X;
@property (assign) CGFloat Y;

- (id)initWithX:(CGFloat)x Y:(CGFloat)y;
- (void)addVector:(Vector2D*)vector;

@end
