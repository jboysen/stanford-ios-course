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

@interface SetCard : Card

@property NSUInteger number;
@property (strong) NSString* symbol;
@property (strong) NSString* shading;
@property (strong) NSString* color;

+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
