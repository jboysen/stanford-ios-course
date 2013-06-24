//
//  MatchingCardGameViewController.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 18/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "MatchingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@implementation MatchingCardGameViewController

- (PlayingCardDeck*)gameDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGameMode)gameMode
{
    return CardMatchingGameMode2Cards;
}

- (NSUInteger)startingCardCount
{
    return 22;
}

-(void) updateCell:(UICollectionViewCell*)cell usingCard:(Card*)card animate:(BOOL)animate 
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView* playingCardView = ((PlayingCardCollectionViewCell*) cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard* playingCard = (PlayingCard*)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
            
            if (animate && playingCardView.faceUp != playingCard.isFaceUp) {
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = playingCard.isFaceUp;
                                }
                                completion:NULL];
            }
            else {
                playingCardView.faceUp = playingCard.isFaceUp;
            }
        }
    }
}

- (NSAttributedString*)getFlipResult:(NSArray*)cards lastScore:(int)score
{
    NSMutableAttributedString *result;
    
    if ([cards count] > 1 && score < 0) {
        result = [[NSMutableAttributedString alloc] initWithAttributedString:[self joinCards:cards]];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match. %d points penalty", score]]];
    } else if ([cards count] == 1) {
        result = [[NSMutableAttributedString alloc] initWithString:@"Flipped up "];
        [result appendAttributedString:[self joinCards:cards]];
    } else if ([cards count] > 1 && score > 0) {
        result = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        [result appendAttributedString:[self joinCards:cards]];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points", score]]];
    }
    return result;
}

- (NSAttributedString*)formattedContentForCard:(Card*)card
{
    return [[NSAttributedString alloc] initWithString:card.contents];
}

- (NSAttributedString*)joinCards:(NSArray*)cards
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < [cards count]; i++) {
        [str appendAttributedString:[self formattedContentForCard:cards[i]]];
        if (i + 1 != [cards count])
            [str appendAttributedString:[[NSAttributedString alloc] initWithString:@" & "]];
    }
    
    return str;
}

@end
