//
//  Ball.m
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import "Object2D.h"
#import "Vector2D.h"
#import "Point2D.h"

// Screen edge normals
#define kLeftNorm 0.0
#define kLeftTopNorm 315.0
#define kTopNorm 270.0
#define kRightTopNorm 225.0
#define kRightNorm 180.0
#define kRightBottomNorm 135.0
#define kBottomNorm 90.0
#define kLeftBottomNorm 45.0

#define kDefaultSize 25.0

@implementation Object2D

@synthesize position;
@synthesize vector;
@synthesize size;

- (id)init
{
    if (self = [super init])
    {
        position = [[Point2D alloc] init];
        vector = [[Vector2D alloc] init];
        size.width = kDefaultSize;
        size.height = kDefaultSize;
    }
    
    return self;
}

- (id)initWithPosition:(Point2D*)pos vector:(Vector2D*)vec 
{
    if (self = [super init])
    {
        position = [pos retain];
        vector = [vec retain];
        size.width = kDefaultSize;
        size.height = kDefaultSize;
    }
    
    return self;
}

- (void)move:(CGRect)bounds
{
    // Move the ball by adding the vector to the position
    [position addVector:vector];

    // If the ball has hit the edge of the screen bounce it
    if (position.X <= bounds.origin.x && position.Y <= bounds.origin.y)
    {
        position.X = bounds.origin.x;
        position.Y = bounds.origin.y;
        [self bounce:kLeftTopNorm];
    }
    else if (position.X <= bounds.origin.x && position.Y+size.height >= bounds.size.height)
    {
        position.X = bounds.origin.x;
        position.Y = bounds.size.height - size.height;
        [self bounce:kLeftBottomNorm];
    }
    else if (position.X+size.width >= bounds.size.width && position.Y <= bounds.origin.y)
    {
        position.X = bounds.size.width - size.width;
        position.Y = bounds.origin.y;
        [self bounce:kRightTopNorm];
    }
    else if (position.X+size.width >= bounds.size.width && position.Y+size.height >= bounds.size.height)
    {
        position.X = bounds.size.width - size.width;
        position.Y = bounds.size.height - size.height;
        [self bounce:kRightBottomNorm];
    }
    else if (position.X <= bounds.origin.x)
    {
        position.X = bounds.origin.x;
        [self bounce:kLeftNorm];
    }
    else if (position.X+size.width >= bounds.size.width)
    {
        position.X = bounds.size.width - size.width;
        [self bounce:kRightNorm];
    }
    else if (position.Y <= bounds.origin.y)
    {
        position.Y = bounds.origin.y;
        [self bounce:kTopNorm];
    }
    else if (position.Y+size.height >= bounds.size.height)
    {
        position.Y = bounds.size.height - size.height;
        [self bounce:kBottomNorm];
    }
}

- (void)bounce:(CGFloat)boundryNormalAngle
{
    double angle = vector.angle;
    double oppAngle = (int)(angle + 180) % 360;
    double normalDiffAngle;
    
    if (boundryNormalAngle >= oppAngle)
    {
        normalDiffAngle = boundryNormalAngle - oppAngle;
        angle = (int)(boundryNormalAngle + normalDiffAngle) % 360;        
    }

    if (boundryNormalAngle < oppAngle)
    {
        normalDiffAngle = oppAngle - boundryNormalAngle;
        angle = boundryNormalAngle - normalDiffAngle;
        if (angle < 0)
        {
            angle += 360;
        }
    }

    // Set the new vector angle
    [vector setAngle:angle];
    [self affectSpeed:0.99];
}

- (void)draw:(CGContextRef)ctx
{
    //CGContextSetRGBFillColor(ctx, 255, 0, 0, 1);
    //CGContextFillEllipseInRect(ctx, CGRectMake(position.X, position.Y, size.width, size.height));
}

- (void)affectSpeed:(CGFloat)factor;
{
    [vector scaleLength:factor];
}

@end
