//
//  RecentPhoto.h
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 08/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhoto : NSObject

+ (NSArray*)allRecentPhotos;
+ (void)addRecentPhoto:(NSDictionary*)photo;

@end
