//
//  PhotoCache.m
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 09/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "PhotoCache.h"

@interface PhotoCache ()
@property (strong, nonatomic) NSFileManager* fileManager;
@end

@implementation PhotoCache

- (NSFileManager*)fileManager
{
    if (!_fileManager) _fileManager = [[NSFileManager alloc] init];
    return _fileManager;
}

- (NSURL*)cacheKey:(NSURL*)imageURL
{
    return [[self cacheDirectory] URLByAppendingPathComponent:[imageURL lastPathComponent]];
}

- (NSURL*)cacheDirectory
{
    NSArray *urls = [self.fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    return urls[0];
}

- (NSArray*)cachedFiles
{
    NSArray* cachedFiles = [self.fileManager contentsOfDirectoryAtURL:[self cacheDirectory] includingPropertiesForKeys:@[NSURLContentAccessDateKey, NSURLFileSizeKey] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    return [cachedFiles sortedArrayUsingComparator:^NSComparisonResult(NSURL* file1, NSURL* file2) {
        NSDictionary* file1Desc = [file1 resourceValuesForKeys:@[NSURLContentAccessDateKey] error:nil];
        NSDictionary* file2Desc = [file2 resourceValuesForKeys:@[NSURLContentAccessDateKey] error:nil];
        
        return [file2Desc[NSURLContentAccessDateKey] compare:file1Desc[NSURLContentAccessDateKey]];
    }];
}

#define CACHE_DIR_SIZE 1024 * 1024 * 10

- (void)cleanupCacheDirectory
{
    int dirSize = 0;
    
    for (NSURL* file in [self cachedFiles]) {
        NSDictionary* fileDesc = [file resourceValuesForKeys:@[NSURLFileSizeKey] error:nil];
        
        NSNumber *size = fileDesc[NSURLFileSizeKey];
        
        dirSize += [size intValue];
        
        if (dirSize > CACHE_DIR_SIZE) {
            [self.fileManager removeItemAtURL:file error:nil];
        }
    }
}

- (void)setValue:(NSData *)data forImageURL:(NSURL *)imageURL
{
    [data writeToURL:[self cacheKey:imageURL] atomically:YES];

    [self cleanupCacheDirectory];
}

- (NSData*)getValue:(NSURL *)imageURL
{
    return [NSData dataWithContentsOfURL:[self cacheKey:imageURL]];
}

@end
