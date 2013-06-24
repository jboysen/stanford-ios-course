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

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray *flipHistory;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *selectedCardsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *flippedCardsCollectionView;
@property (nonatomic) NSUInteger cardsInPlay;
@property (weak, nonatomic) IBOutlet UIButton *moreCards;
@end

@implementation CardGameViewController

-(void) updateCell:(UICollectionViewCell*)cell usingCard:(Card*)card animate:(BOOL)animate { }
-(Deck*)gameDeck { return nil; }
-(CardMatchingGameMode)gameMode { return 0; }
-(BOOL)hideUnplayable { return NO; }
- (NSAttributedString*)getFlipResult:(NSArray*)cards lastScore:(int)score { return [[NSAttributedString alloc] initWithString:@""]; }

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.cardCollectionView)
        return self.cardsInPlay;
    else if (collectionView == self.selectedCardsCollectionView)
        return [[self.game selectedCards] count];
    else
        return [[self.game flippedCards] count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    
    Card *card = nil;
    
    if (collectionView == self.cardCollectionView)
        card = [self.game cardAtIndex:indexPath.item];
    else if (collectionView == self.selectedCardsCollectionView)
        card = [[self.game selectedCards] objectAtIndex:indexPath.item];
    else
        card = [[self.game flippedCards] objectAtIndex:indexPath.item];

    [self updateCell:cell usingCard:card animate:NO];
    return cell;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount 
                                                          usingDeck:[self gameDeck]
                                                               mode:[self gameMode]];
    return _game;
}

- (NSMutableArray *)flipHistory
{
    if (!_flipHistory) _flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}

- (void)updateUI
{
    [self.selectedCardsCollectionView reloadData];
    [self.cardCollectionView reloadData];
    [self.flippedCardsCollectionView reloadData];
    
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:YES];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"S: %d", self.game.score];
    
    [self updateHistory];
}

- (void)updateHistory
{
    if (self.game.flippedCards) {
        [self.flipHistory addObject:[self getFlipResult:self.game.flippedCards lastScore:self.game.flipResult]];
        self.resultLabel.attributedText = [self.flipHistory lastObject];
    }
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        
        // check whether to hide any matched cards.
        if ([self hideUnplayable] && self.game.flipResult > 0) {
            [self.game hideCards:[self.game flippedCards]];
        }
        
        [self updateUI];
    }
}

- (IBAction)deal
{
    self.game = nil;
    self.flipHistory = nil;
    self.resultLabel.text = @"";
    self.moreCards.enabled = YES;
    self.cardsInPlay = self.startingCardCount;
    [self.moreCards setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self updateUI];
}

-(NSUInteger)cardsInPlay
{
    return [self.game cardsInPlay];
}

- (IBAction)draw3Cards:(id)sender
{
    BOOL deckIsEmpty = ![self.game drawMoreCards:3];
    
    if (deckIsEmpty) {
        self.moreCards.enabled = NO;
        [self.moreCards setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    [self.cardCollectionView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.cardsInPlay-1 inSection:0];
    [self.cardCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}


@end
