//
//  SetCardView.h
//  Matchismo
//
//  Created by Jakob Jakobsen Boysen on 27/03/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property NSUInteger number;
@property (strong) NSString* shape;
@property (strong) NSString* shading;
@property (strong) NSString* color;

@property (nonatomic) BOOL faceUp;

@end
