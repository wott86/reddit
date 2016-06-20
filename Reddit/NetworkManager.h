//
//  lifekeeApiEngine.h
//  lifekee-ios
//
//  Created by César Vilera on 4/22/14.
//  Copyright (c) 2014 César Vilera. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface NetworkManager : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;

@end
