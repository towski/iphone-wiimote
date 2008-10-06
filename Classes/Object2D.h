//
//  Ball.h
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Point2D;
@class Vector2D;

@interface Object2D : NSObject
{
    Point2D* position;
    Vector2D* vector;
    CGSize size;
}

@property (assign) Point2D* position;
@property (assign) Vector2D* vector;
@property (assign) CGSize size;

- (id)initWithPosition:(Point2D*)pos vector:(Vector2D*)vec;
- (void)move:(CGRect)bounds;
- (void)bounce:(CGFloat)boundryNormalAngle;
- (void)draw:(CGContextRef)context;
- (void)affectSpeed:(CGFloat)factor;

@end
