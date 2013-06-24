//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 22/02/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) int mode;
@property (strong, nonatomic, readwrite) NSString *flipResult;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable) {
        
        if (!card.isFaceUp) {
            
            NSArray* otherCards = [self getFaceUpCardsNot:card];
            
            if (([otherCards count] == 1 && self.mode == CardMatchingGameMode2Cards)
                || ([otherCards count] == 2 && self.mode == CardMatchingGameMode3Cards)) {
                [self matchCards:otherCards againstCard:card];
            } else {
                self.flipResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (NSArray*)getFaceUpCardsNot:(Card*)card
{
    NSMutableArray* faceUpCards = [[NSMutableArray alloc] init];
    
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable && otherCard != card) {
            [faceUpCards addObject:otherCard];
        }
    }
    
    return faceUpCards;
}

- (void)matchCards:(NSArray*)otherCards againstCard:(Card*)card
{
    int matchScore = [card match:otherCards];
    
    NSString* otherCardsContent = [NSString stringWithFormat:@"%@ & %@", card.contents, [otherCards componentsJoinedByString:@" & "]];
    
    if (matchScore) {
        card.unplayable = YES;
        [self markCardsUnplayable:otherCards];
        self.score += matchScore * MATCH_BONUS;
        self.flipResult = [NSString stringWithFormat:@"Matched %@ for %d points", otherCardsContent, matchScore * MATCH_BONUS];
    } else {
        [self flipCardsDown:otherCards];
        self.score -= MISMATCH_PENALTY;
        self.flipResult = [NSString stringWithFormat:@"%@ don't match. %d points penalty", otherCardsContent, MISMATCH_PENALTY];
    }
}

- (void)markCardsUnplayable:(NSArray*)cards
{
    for (Card *card in cards) {
        card.unplayable = YES;
    }
}

- (void)flipCardsDown:(NSArray*)cards
{
    for (Card *card in cards) {
        card.faceUp = NO;
    }
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck*)deck
                   mode:(CardMatchingGameMode)mode
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
        self.mode = mode;
    }
    
    return self;
}

@end
