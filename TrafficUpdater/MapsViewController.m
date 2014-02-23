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
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    GMSMapView *mapView_;
}

-(NSMutableArray*)arrayCoordinates
{
    if (!_arrayCoordinates)
        _arrayCoordinates = [[NSMutableArray alloc]init];
    return _arrayCoordinates;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        isSearching = NO;
        isOnTrafficWarningMode = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:10.76337
                                                            longitude:106.68235
                                                                 zoom:13];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(10.76337,106.68235);
    marker.title = @"My School";
    marker.snippet = @"VietNam";
    marker.map = mapView_;
    
    NSLog(@"Current identifier: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
        locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //locationManager.distanceFilter=kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
    [locationManager stopUpdatingLocation];
    CLLocationCoordinate2D coord;
    coord.longitude = locationManager.location.coordinate.longitude;
    coord.latitude = locationManager.location.coordinate.latitude;
    double latitude = coord.latitude;
    double longtitude = coord.longitude;
    NSURL *URL = [NSURL URLWithString:@"getMarker/" relativeToURL:[DataCenter dataCenter].httpManager.baseURL];
    NSDictionary *parameters = @{@"Lat": [NSString stringWithFormat:@"%f", latitude], @"Long" : [NSString stringWithFormat:@"%f", longtitude]};
    [[DataCenter dataCenter].httpManager.manager
     POST:URL.absoluteString
     parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         for (NSDictionary* dic in [responseObject valueForKey:@"data"])
         {
             double latitude = [[dic valueForKey:@"lat"] doubleValue];
             double longtitude = [[dic valueForKey:@"long"] doubleValue];
             CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longtitude];
             [self.arrayCoordinates addObject:location];
             GMSMarker *marker = [[GMSMarker alloc] init];
             marker.position = CLLocationCoordinate2DMake(latitude, longtitude);
             marker.icon = [UIImage imageNamed:@"den giao thong-1"];
             marker.map = mapView_;
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error);
     }];

    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:174 green:235 blue:225 alpha:1];
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@", error);
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"Location : %@", newLocation);
    CLLocationCoordinate2D coord;
    coord.longitude = newLocation.coordinate.longitude;
    coord.latitude = newLocation.coordinate.latitude;
    float latitude = coord.latitude;
    float longtitude = coord.longitude;
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0)
        {
            
            placemark = [placemarks lastObject];
            NSLog(@"%@ %@/n %@ %@/n %@ /n %@", placemark.subThoroughfare, placemark.thoroughfare,
                  placemark.locality, placemark.postalCode,
                  placemark.administrativeArea,
                  placemark.country);
            NSLog(@"placemarks : %@", placemarks);
            
        }
    }];
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    
//}

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
