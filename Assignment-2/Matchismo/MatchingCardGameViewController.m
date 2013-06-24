//
//  MatchingCardGameViewController.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 18/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "MatchingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation MatchingCardGameViewController

- (PlayingCardDeck*)gameDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGameMode)gameMode
{
    return CardMatchingGameMode2Cards;
}

- (void)drawButton:(UIButton *)cardButton forCard:(Card*)card
{    
    UIImage *cardBackImage = [UIImage imageNamed:@"playing-card-back.jpg"];
    
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    
    [cardButton setImage:(card.isFaceUp ? nil : cardBackImage) forState:UIControlStateNormal];
    [cardButton setImageEdgeInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
}

@end
