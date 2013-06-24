//
//  SetCardView.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 27/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"

@interface SetCardView ()
@property (nonatomic) float shapeHeight;
@property (nonatomic) float shapeWidth;
@end

@implementation SetCardView

#define SHAPE_WIDTH_RATIO 0.7
#define SHAPE_HEIGHT_RATIO 0.2

-(float)shapeHeight
{
    return self.bounds.size.height * SHAPE_HEIGHT_RATIO;
}

-(float)shapeWidth
{
    return self.bounds.size.width * SHAPE_WIDTH_RATIO;
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawCardBackground];
    
    for (int i = 1; i <= self.number; i++) {
        
        float y = self.bounds.size.height / (self.number + 1);
        
        y *= i;
        
        [self pushContextAndMoveCenterTo:CGPointMake(self.bounds.size.width / 2, y)];
        
        if (self.shape == SCShapeDiamond)
            [self drawDiamonds];
        else if (self.shape == SCShapeOval)
            [self drawOvals];
        else
            [self drawSquiggles];
        
        [self popContext];
    }
}

-(void)drawOvals
{
    CGRect rect = CGRectMake(-self.shapeWidth/2, -self.shapeHeight/2, self.shapeWidth, self.shapeHeight);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self colorAndDraw:path];
}

-(void)drawSquiggles
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint upperLeft = CGPointMake(-self.shapeWidth/2, -(self.shapeHeight / 2) + self.shapeHeight / 5);
    [path moveToPoint:upperLeft];
    
    CGPoint upperRight = CGPointMake(self.shapeWidth/2, -(self.shapeHeight / 2));
    CGPoint cp1 = CGPointMake(0, -self.shapeHeight/1.5);
    CGPoint cp2 = CGPointMake(0, 0);
    [path addCurveToPoint:upperRight controlPoint1:cp1 controlPoint2:cp2];
    
    CGPoint lowerRight = CGPointMake(self.shapeWidth/2, (self.shapeHeight / 2) - self.shapeHeight / 5);
    CGPoint cp3 = CGPointMake(self.shapeWidth/1.5, 0);
    [path addQuadCurveToPoint:lowerRight controlPoint:cp3];
    
    CGPoint lowerLeft = CGPointMake(-self.shapeWidth/2, (self.shapeHeight / 2));
    CGPoint cp4 = CGPointMake(0, self.shapeHeight/1.5);
    CGPoint cp5 = CGPointMake(0, 0);
    [path addCurveToPoint:lowerLeft controlPoint1:cp4 controlPoint2:cp5];
    
    CGPoint cp6 = CGPointMake(-self.shapeWidth/1.5, 0);
    [path addQuadCurveToPoint:upperLeft controlPoint:cp6];    

    [self colorAndDraw:path];
}

-(void)drawDiamonds
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, -(self.shapeHeight / 2))];
    [path addLineToPoint:CGPointMake(self.shapeWidth / 2, 0)];
    [path addLineToPoint:CGPointMake(0, self.shapeHeight / 2)];
    [path addLineToPoint:CGPointMake(- (self.shapeWidth / 2), 0)];
    [path closePath];
    
    [self colorAndDraw:path];
}

#define NUMBER_LINES 10

-(void)colorAndDraw:(UIBezierPath*)path
{
    if (self.shading == SCShadingSolid) {
        [[self getUIColor] setFill];
        [path fill];
    }
    
    [path addClip]; // allow us to draw stripes without having to care about bounds
    
    [[self getUIColor] setStroke];
    [path stroke];
    
    path.lineWidth = 0.3;
    if (self.shading == SCShadingStripped) {
        for (int i = 0; i <= NUMBER_LINES; i++) {
            [path moveToPoint:CGPointMake(-self.shapeWidth/2 + self.shapeWidth / NUMBER_LINES * i, -self.shapeHeight/2)];
            [path addLineToPoint:CGPointMake(-self.shapeWidth/2 + self.shapeWidth / NUMBER_LINES * i, self.shapeHeight/2)];
        }
        [path stroke];
    }
}

-(void)drawCardBackground
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width * 0.2]; // base radius on view size
    
    [roundedRect addClip];
    
    if (self.faceUp)
        [[UIColor lightGrayColor] setFill];
    else
        [[UIColor whiteColor] setFill];
    
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

- (UIColor*)getUIColor
{
    if (self.color == SCColorGreen)
        return [UIColor greenColor];
    else if (self.color == SCColorRed)
        return [UIColor redColor];
    else
        return [UIColor purpleColor];
}

- (void)pushContextAndMoveCenterTo:(CGPoint)point
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, point.x, point.y);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
