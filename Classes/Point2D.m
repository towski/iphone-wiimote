//
//  Point2D.m
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import "Point2D.h"
#import "Vector2D.h"

@implementation Point2D

@synthesize X;
@synthesize Y;

- (id)init
{
    if (self = [super init])
    {
        X = 0.0;
        Y = 0.0;
    }
    
    return self;
}

- (id)initWithX:(CGFloat)x Y:(CGFloat)y;
{
    if (self = [super init])
    {
        X = x;
        Y = y;
    }
    
    return self;
}

- (void)addVector:(Vector2D*)vector
{
    X += vector.endPoint.X;
    Y += vector.endPoint.Y;
}

@end
