//
//  FlickrTagsTVC.m
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 08/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "FlickrTagsTVC.h"
#import "FlickrFetcher.h"

@interface FlickrTagsTVC () <UISplitViewControllerDelegate>

@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSDictionary *tagPhotos;

@end

@implementation FlickrTagsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sortPhotos];
}

- (void) awakeFromNib
{
    self.splitViewController.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowTag"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setPhotos:)]) {
                    [segue.destinationViewController performSelector:@selector(setPhotos:) withObject:[self.tagPhotos objectForKey:self.tags[indexPath.row]]];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                } 
            }
        }
    }
}

-(void) setTags:(NSArray *)tags
{
    _tags = tags;
    [self.tableView reloadData];
}

- (void) sortPhotos
{
    NSArray *ignoredTags = [[NSArray alloc] initWithObjects:@"cs193pspot", @"portrait", @"landscape", nil];
    NSArray* photos = [FlickrFetcher stanfordPhotos];
    NSMutableDictionary *tagPhotos = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *photo in photos) {
        for (NSString *tag in [[photo[FLICKR_TAGS] description] componentsSeparatedByString:@" "]) {
            if (![ignoredTags containsObject:tag]) {                
                NSMutableArray *photosForTag;            
                if ([tagPhotos objectForKey:tag]) {
                    photosForTag = [[NSMutableArray alloc] initWithArray:[tagPhotos objectForKey:tag]];
                    [photosForTag addObject:photo];
                } else {
                    photosForTag = [[NSMutableArray alloc] initWithObjects:photo, nil];
                }
                
                [tagPhotos setObject:[photosForTag sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:FLICKR_PHOTO_TITLE ascending:YES]]] forKey:tag];
            }
        }
    }
    
    self.tags = [[tagPhotos allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    self.tagPhotos = tagPhotos;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.tags[row] capitalizedString];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [[NSString alloc] initWithFormat:@"%lu photos", (unsigned long)[[self.tagPhotos objectForKey:self.tags[row]] count]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlickrTag" forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

@end
