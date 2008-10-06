//
//  Vector2D.h
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Point2D;

@interface Vector2D : NSObject
{
    CGFloat angle;
    CGFloat length;
    Point2D* endPoint;
}

@property (assign) CGFloat angle;
@property (assign) CGFloat length;
@property (assign) Point2D* endPoint;

- (id)initWithX:(CGFloat)x Y:(CGFloat)y;
- (void)setEndPointX:(CGFloat)x Y:(CGFloat)y;
- (void)setAngle:(CGFloat)degrees;
- (void)influence:(Vector2D*)influenceVector Max:(CGFloat)max;
- (void)scaleLength:(CGFloat)factor;

@end
