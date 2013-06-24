//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 22/02/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

typedef enum {
    CardMatchingGameMode2Cards = 2,
    CardMatchingGameMode3Cards = 3
} CardMatchingGameMode;

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck*)deck
                   mode:(CardMatchingGameMode)mode;

- (void) flipCardAtIndex:(NSUInteger)index;

- (Card*) cardAtIndex:(NSUInteger)index;

- (void) setMode:(int)mode;

@property (readonly) int score;
@property (readonly) int mode;
@property (readonly) int flipResult;
@property (strong) NSArray* flippedCards;

@end
