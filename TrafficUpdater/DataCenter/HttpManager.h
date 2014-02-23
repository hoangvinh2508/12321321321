//
//  HttpManager.h
//  TrafficUpdater
//
//  Created by Nguyen Viet Trung on 2/23/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
@interface HttpManager : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSDictionary *parameters;

@end
