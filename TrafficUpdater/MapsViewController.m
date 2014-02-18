//
//  MapsViewController.m
//  TrafficUpdater
//
//  Created by NHVinh on 2/16/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import "MapsViewController.h"
#import "GoogleMaps/GoogleMaps.h"

@interface MapsViewController ()

@end

@implementation MapsViewController
{
    GMSMapView *mapView_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        isSearching = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    
    NSLog(@"Current identifier: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:174 green:235 blue:225 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showSearchBar:(id)sender {
    
    if (!isSearching)
    {
        UISearchBar *searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        searchbar.placeholder = @"Enter here";
        self.navigationItem.titleView = searchbar;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(showSearchBar:)];
    }
    else{
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar:)];
    }
    
    isSearching = !isSearching;
}

-(IBAction)showBookmarks:(id)sender
{
    
}
@end
