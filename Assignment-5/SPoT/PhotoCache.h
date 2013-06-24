//
//  PhotoCache.h
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 09/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoCache : NSObject

- (NSData*)getValue:(NSURL*)imageURL;
- (void)setValue:(NSData*)data forImageURL:(NSURL*)imageURL;

@end
