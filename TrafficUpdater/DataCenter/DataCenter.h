//
//  DataCenter.h
//  TrafficUpdater
//
//  Created by Nguyen Viet Trung on 2/23/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"
@interface DataCenter : NSObject

+(DataCenter *)dataCenter;
@property (strong, nonatomic) HttpManager *httpManager;

@end
