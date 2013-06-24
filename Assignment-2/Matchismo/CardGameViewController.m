//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 21/02/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"   
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeControl;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *flipHistory;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self gameDeck]
                                                               mode:[self gameMode]];
    return _game;
}

- (NSMutableArray *)flipHistory
{
    if (!_flipHistory) _flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [self drawButton:cardButton forCard:card];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // disable game mode controller if flips greater than 0
    self.modeControl.enabled = (self.flipCount == 0);
    
    [self updateHistory];
}

- (void)updateHistory
{
    if (self.game.flippedCards) {
        [self.flipHistory addObject:[self getFlipResult:self.game.flippedCards lastScore:self.game.flipResult]];
        self.resultLabel.attributedText = [self.flipHistory lastObject];
    }
    
    self.historySlider.enabled = ([self.flipHistory count] > 0);
    self.historySlider.maximumValue = [self.flipHistory count];
    [self.historySlider setValue:[self.flipHistory count]];
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

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    self.flipHistory = nil;
    self.resultLabel.text = @"";
    [self updateUI];
}

- (IBAction)changeMode:(id)sender
{
    if (self.modeControl.selectedSegmentIndex == 1) {
        [self.game setMode:CardMatchingGameMode3Cards];
    } else {
        [self.game setMode:CardMatchingGameMode2Cards];
    }
}

- (IBAction)slideHistory:(id)sender
{
    int index = self.historySlider.value - 1;
    if (index >= 0)
        self.resultLabel.attributedText = [self.flipHistory objectAtIndex:index];
    if (index < [self.flipHistory count] - 1)
        self.resultLabel.textColor = [UIColor grayColor];
    else
        self.resultLabel.textColor = [UIColor blackColor];
}

- (Deck*)gameDeck
{
    return nil;
}

- (CardMatchingGameMode)gameMode
{
    return 0;
}

- (void)drawButton:(UIButton *)cardButton forCard:(Card *)card
{
}


@end
