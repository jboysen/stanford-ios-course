//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 21/02/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

- (Deck*)gameDeck; // abstract
- (CardMatchingGameMode)gameMode; // abstract
- (void) updateCell:(UICollectionViewCell*)cell usingCard:(Card*)card animate:(BOOL)animate; // abstract
- (BOOL) hideUnplayable; // abstract
- (NSString*)getFlipResult:(NSArray*)cards lastScore:(int)score; // abstract
@property NSUInteger startingCardCount; // abstract


@end
