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

@implementation SetCardGameViewController

- (SetCardDeck*)gameDeck
{
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGameMode)gameMode
{
    return CardMatchingGameMode3Cards;
}

- (UIColor*)getCardColor:(SetCard*)card
{
    if (card.color == SCColorGreen)
        return [UIColor greenColor];
    else if (card.color == SCColorRed)
        return [UIColor redColor];
    else
        return [UIColor purpleColor];
}

- (float)getCardShading:(SetCard*)card
{
    if (card.shading == SCShadingOpen)
        return 0.0;
    else if (card.shading == SCShadingStripped)
        return 0.1;
    else
        return 1.0;
}

- (void)drawButton:(UIButton *)cardButton forCard:(Card*)card
{
    [cardButton setAttributedTitle:[self formattedContentForCard:card] forState:UIControlStateNormal];

    cardButton.backgroundColor = (card.isFaceUp ? [UIColor lightGrayColor] : nil);
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = (card.isUnplayable ? 0.1 : 1.0);
}

- (NSAttributedString*)formattedContentForCard:(Card*)card
{
    SetCard* setCard = (SetCard*)card;
    
    UIColor* bgColor = [[self getCardColor:setCard] colorWithAlphaComponent:[self getCardShading:setCard]];
    
    return [[NSMutableAttributedString alloc] initWithString:setCard.contents
                                                                                attributes:@{
                                                               NSStrokeColorAttributeName : [self getCardColor:setCard],
                                                               NSStrokeWidthAttributeName : @-9,
                                                           NSForegroundColorAttributeName : bgColor
                                          }];
}

@end
