//
//  RecentPhoto.m
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 08/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "RecentPhoto.h"

@implementation RecentPhoto

#define ALL_PHOTOS_KEY @"RecentPhoto_ALL"
#define RECENT_PHOTOS 10

+ (NSArray*)allRecentPhotos
{
    return [[[[NSUserDefaults standardUserDefaults] arrayForKey:ALL_PHOTOS_KEY] reverseObjectEnumerator] allObjects];
}

+ (void) addRecentPhoto:(NSDictionary*)photo
{
    NSMutableArray *recentPhotos = [[[NSUserDefaults standardUserDefaults] arrayForKey:ALL_PHOTOS_KEY] mutableCopy];
    
    if (!recentPhotos) recentPhotos = [[NSMutableArray alloc] init];
    
    if ([recentPhotos containsObject:photo]) {
        [recentPhotos removeObject:photo];
    }
    
    [recentPhotos addObject:photo];
    
    if ([recentPhotos count] > RECENT_PHOTOS) {
        [recentPhotos removeObjectAtIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:recentPhotos forKey:ALL_PHOTOS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
