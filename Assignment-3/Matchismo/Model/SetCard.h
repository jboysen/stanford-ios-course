//
//  SetCard.h
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 18/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "Card.h"

// http://stackoverflow.com/questions/538996/constants-in-objective-c
FOUNDATION_EXPORT NSString *const SCShadingSolid;
FOUNDATION_EXPORT NSString *const SCShadingStripped;
FOUNDATION_EXPORT NSString *const SCShadingOpen;

FOUNDATION_EXPORT NSString *const SCColorRed;
FOUNDATION_EXPORT NSString *const SCColorGreen;
FOUNDATION_EXPORT NSString *const SCColorPurple;

FOUNDATION_EXPORT NSString *const SCShapeSquiggle;
FOUNDATION_EXPORT NSString *const SCShapeDiamond;
FOUNDATION_EXPORT NSString *const SCShapeOval;

@interface SetCard : Card

@property NSUInteger number;
@property (strong) NSString* shape;
@property (strong) NSString* shading;
@property (strong) NSString* color;

+ (NSUInteger)maxNumber;
+ (NSArray *)validShapes;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
