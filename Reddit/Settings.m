//
//  Settings.m
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+(id)sharedManager {
    static Settings *settings = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        settings = [[self alloc] init];
    });
    return settings;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:@"http://www.reddit.com"];
    }
    return self;
}

@end
