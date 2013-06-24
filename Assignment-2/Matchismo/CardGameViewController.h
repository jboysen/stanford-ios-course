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

- (Deck*)gameDeck;
- (CardMatchingGameMode)gameMode;
- (void)drawButton:(UIButton*)cardButton forCard:(Card*)card;
- (NSAttributedString*)formattedContentForCard:(Card*)card;

@end
