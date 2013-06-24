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
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (readwrite, nonatomic) int flipResult;
@property (strong, nonatomic) Deck *deck;
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
            self.score -= FLIP_COST;
            
            if (([otherCards count] == 1 && self.mode == CardMatchingGameMode2Cards)
                || ([otherCards count] == 2 && self.mode == CardMatchingGameMode3Cards)) {
                [self matchCards:otherCards againstCard:card];
            } else {
                [self setFlipResult:-FLIP_COST flippedCards:@[card]];
            }
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (void)setFlipResult:(int)result flippedCards:(NSArray*)cards
{
    self.flipResult = result;
    self.flippedCards = cards;
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

- (void)hideCards:(NSArray*)cards
{
    for(Card *card in cards) {
        [self.cards removeObject:card];
    }
}

- (void)matchCards:(NSArray*)otherCards againstCard:(Card*)card
{
    int matchScore = [card match:otherCards];

    NSMutableArray* allCards = [[NSMutableArray alloc] initWithArray:otherCards];
    [allCards addObject:card];
    
    if (matchScore) {
        [self markCardsUnplayable:allCards];
        self.score += matchScore * MATCH_BONUS;
        [self setFlipResult:(matchScore * MATCH_BONUS) flippedCards:allCards];
    } else {
        [self flipCardsDown:otherCards];
        self.score -= MISMATCH_PENALTY;
        [self setFlipResult:(-MISMATCH_PENALTY) flippedCards:allCards];
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
        self.deck = deck;
    }
    
    return self;
}

- (BOOL)drawMoreCards:(int)number
{
    for (int i = 0; i < number; i++) {
        Card *card = [self.deck drawRandomCard];
        if (card)
            [self.cards addObject:card];
        else
            return NO;
    }

    return YES;
}
         
-(int)cardsInPlay
{
    return self.cards.count;
}

-(NSArray*)selectedCards
{
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
        if (!card.isUnplayable && card.isFaceUp) {
            [cards addObject:card];
        }
    }
    
    return cards;
}

@end
