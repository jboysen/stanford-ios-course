//
//  RecentsViewController.m
//  SPoT
//
//  Created by Jakob Jakobsen Boysen on 08/04/2013.
//  Copyright (c) 2013 Jakob Jakobsen Boysen. All rights reserved.
//

#import "RecentsTVC.h"
#import "RecentPhoto.h"

@interface RecentsTVC () <UISplitViewControllerDelegate>

@end

@implementation RecentsTVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.photos = [RecentPhoto allRecentPhotos];
}

- (void) awakeFromNib
{
    self.splitViewController.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

@end
