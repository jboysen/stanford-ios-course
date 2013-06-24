//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 18/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardCollectionViewCell.h"

@implementation SetCardGameViewController

- (SetCardDeck*)gameDeck
{
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGameMode)gameMode
{
    return CardMatchingGameMode3Cards;
}

- (NSUInteger)startingCardCount
{
    return 12;
}

-(BOOL) hideUnplayable
{
    return YES;
}

-(void) updateCell:(UICollectionViewCell*)cell usingCard:(Card*)card animate:(BOOL)animate
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView* setCardView = ((SetCardCollectionViewCell*) cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard* setCard = (SetCard*)card;
            setCardView.color = setCard.color;
            setCardView.number = setCard.number;
            setCardView.shading = setCard.shading;
            setCardView.shape = setCard.shape;
            setCardView.faceUp = setCard.isFaceUp;
        }
    }
}



- (NSAttributedString*)getFlipResult:(NSArray*)cards lastScore:(int)score
{
    NSMutableAttributedString *result;
    
    if ([cards count] > 1 && score < 0) {
        result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d points penalty. Card don't match:", score]];
    } else if ([cards count] == 1) {
        result = [[NSMutableAttributedString alloc] initWithString:@"Flipped up card:"];
    } else if ([cards count] > 1 && score > 0) {
        result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Matched cards for %d points:", score]];
    }
    return result;
}



@end
