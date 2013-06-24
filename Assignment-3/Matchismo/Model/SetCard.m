//
//  SetCard.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 18/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "SetCard.h"



NSString *const SCShadingSolid = @"Solid";
NSString *const SCShadingStripped = @"Stripped";
NSString *const SCShadingOpen = @"Open";

NSString *const SCColorRed = @"Red";
NSString *const SCColorGreen = @"Green";
NSString *const SCColorPurple = @"Purple";

NSString *const SCShapeSquiggle = @"Squiggle";
NSString *const SCShapeDiamond = @"Diamond";
NSString *const SCShapeOval = @"Oval";

@implementation SetCard

- (int)match:(NSArray *)otherCards
{    
    id secondCard = [otherCards objectAtIndex:0];
    id thirdCard = [otherCards objectAtIndex:1];
    
    if ([secondCard isKindOfClass:[SetCard class]] && [thirdCard isKindOfClass:[SetCard class]]) {
        
        SetCard *secondSetCard = (SetCard*)secondCard;
        SetCard *thirdSetCard = (SetCard*)thirdCard;
        
        if (!(self.number == secondSetCard.number && self.number == thirdSetCard.number)
            && !(self.number != secondSetCard.number && self.number != thirdSetCard.number && secondSetCard.number != thirdSetCard.number))
            return 0;
        
        if (!(self.shape == secondSetCard.shape && self.shape == thirdSetCard.shape)
            && !(self.shape != secondSetCard.shape && self.shape != thirdSetCard.shape && secondSetCard.shape != thirdSetCard.shape))
            return 0;
        
        if (!(self.shading == secondSetCard.shading && self.shading == thirdSetCard.shading)
            && !(self.shading != secondSetCard.shading && self.shading != thirdSetCard.shading && secondSetCard.shading != thirdSetCard.shading))
            return 0;
        
        if (!(self.color == secondSetCard.color && self.color == thirdSetCard.color)
            && !(self.color != secondSetCard.color && self.color != thirdSetCard.color && secondSetCard.color != thirdSetCard.color))
            return 0;
    }
    
    return 5;
}

- (NSString*)contents
{
    return [@"" stringByPaddingToLength:self.number withString:self.shape startingAtIndex:0];
}

+ (NSUInteger)maxNumber
{
    return 3;
}

+ (NSArray *)validShapes
{
    return @[SCShapeSquiggle, SCShapeDiamond, SCShapeOval];
}

+ (NSArray *)validShadings
{
    return @[SCShadingSolid, SCShadingStripped, SCShadingOpen];
}

+ (NSArray *)validColors
{
    return @[SCColorGreen, SCColorPurple, SCColorRed];
}

@end
