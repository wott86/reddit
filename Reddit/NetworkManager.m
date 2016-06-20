//
//  lifekeeApiEngine.m
//  lifekee-ios
//
//  Created by César Vilera on 4/22/14.
//  Copyright (c) 2014 César Vilera. All rights reserved.
//

#import "NetworkManager.h"
#import "Settings.h"

@implementation NetworkManager

+ (instancetype)sharedInstance {
    
    static NetworkManager *_sharedInstance = nil;
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        
        NSURL *URL = [[Settings sharedManager] baseURL];
        
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // Initialize the session
        _sharedInstance = [[NetworkManager alloc] initWithBaseURL:URL];
        [_sharedInstance setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [_sharedInstance setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
    });
    return _sharedInstance;
}

@end