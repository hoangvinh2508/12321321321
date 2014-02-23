//
//  DataCenter.m
//  TrafficUpdater
//
//  Created by Nguyen Viet Trung on 2/23/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import "DataCenter.h"

static DataCenter *_dataCenter = nil;
@implementation DataCenter

+(DataCenter *)dataCenter
{
    if (!_dataCenter)
        _dataCenter = [[DataCenter alloc]init];
    return _dataCenter;
}

-(HttpManager *)httpManager
{
    if (!_httpManager)
        _httpManager = [[HttpManager alloc]init];
    return _httpManager;
}

@end
