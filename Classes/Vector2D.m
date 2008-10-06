//
//  Vector2D.m
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import "Vector2D.h"
#import "Point2D.h"

// Geometry constants
#define PI 3.14159
#define ONEEIGHTYOVERPI 57.29582
#define PIOVERONEEIGHTY  0.01745

@implementation Vector2D

@synthesize angle;
@synthesize length;
@synthesize endPoint;

- (id)init
{
    if (self = [super init])
    {
        angle = 0.0;
        length = 0.0;
        endPoint = [[Point2D alloc] init];
    }
    
    return self;
}

- (id)initWithX:(CGFloat)x Y:(CGFloat)y
{
    if (self = [super init])
    {
        endPoint = [[Point2D alloc] init];
        [self setEndPointX:x Y:y];
    }
    
    return self;
}

- (void)setAngle:(CGFloat)degrees
{
    angle = degrees;
    double radians = angle * PIOVERONEEIGHTY;
    endPoint.X = length * cos(radians); // could speed these up with a lookup table
    endPoint.Y = -(length * sin(radians));
}

- (void)setEndPointX:(CGFloat)x Y:(CGFloat)y
{
    endPoint.X = x;
    endPoint.Y = y;

    // Calculate the angle based on the end point
    angle = atan2(-endPoint.Y, endPoint.X) * ONEEIGHTYOVERPI;
    if(angle < 0)
    {
        angle += 360;
    }

    // Calculate the length of the vector
    length = sqrt(endPoint.X * endPoint.X + endPoint.Y * endPoint.Y);
}

- (void)influence:(Vector2D*)influenceVector Max:(CGFloat)max;
{
    [endPoint addVector:influenceVector];
    length = sqrt(endPoint.X * endPoint.X + endPoint.Y * endPoint.Y);
    CGFloat newAngle = atan2(-endPoint.Y, endPoint.X) * ONEEIGHTYOVERPI;
    if(newAngle < 0)
    {
        newAngle += 360;
    }
    
    if(abs(newAngle - influenceVector.angle) >= 90)
    {
        length *= 0.96;
    }
    else
    {
        length *= 1.03;
    }
    
    if(length > max)
    {
        length = max;
    }
    else if(length < 0.0)
    {
        length = 0.0;
    }

    [self setAngle:newAngle];
}

- (void)scaleLength:(CGFloat)factor;
{
    length *= factor;
    if(length < 0.05)
    {
        length = 0.0;
    }
    
    double radians = angle * PIOVERONEEIGHTY;
    endPoint.X = length * cos(radians); // could speed these up with a lookup table
    endPoint.Y = -(length * sin(radians));
}

@end
