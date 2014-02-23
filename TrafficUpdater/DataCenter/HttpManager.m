//
//  HttpManager.m
//  TrafficUpdater
//
//  Created by Nguyen Viet Trung on 2/23/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

-(AFHTTPRequestOperationManager*)manager
{
    if (!_manager) _manager = [AFHTTPRequestOperationManager manager];
    return _manager;
}

-(NSString*) domain
{
    if (!_domain)
        _domain = @"http://127.0.0.1";
    return _domain;
}

-(NSURL*) baseURL
{
    if (!_baseURL)
        _baseURL = [NSURL URLWithString:@"http://127.0.0.1:3001/api/"];
    return _baseURL;
}


@end
