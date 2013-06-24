//
//  ListPhotosTVC.m
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 08/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "ListPhotosTVC.h"
#import "FlickrFetcher.h"
#import "RecentPhoto.h"

@interface ListPhotosTVC ()

@end

@implementation ListPhotosTVC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowPhoto"]) {
                [RecentPhoto addRecentPhoto:self.photos[indexPath.row]];
            }
            if ([segue.identifier isEqualToString:@"ShowPhoto"] || [segue.identifier isEqualToString:@"ShowRecentPhoto"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                    int format = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? FlickrPhotoFormatOriginal : FlickrPhotoFormatLarge;
                    NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:format];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_TITLE] description];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [self.photos[row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlickrPhoto" forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

@end
