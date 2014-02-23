//
//  MapsViewController.h
//  TrafficUpdater
//
//  Created by NHVinh on 2/16/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DataCenter.h"
@interface MapsViewController : UIViewController <CLLocationManagerDelegate>
{
    BOOL isSearching;
    BOOL isOnTrafficWarningMode;
}

@property (nonatomic, strong) NSMutableArray *arrayCoordinates;

@end
