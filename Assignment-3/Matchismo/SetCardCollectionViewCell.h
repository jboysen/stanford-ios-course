//
//  SetCardCollectionViewCell.h
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 27/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end
