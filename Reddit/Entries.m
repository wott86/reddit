//
//  Entries.m
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import "Entries.h"
#import "NetworkManager.h"
#import "Entry.h"

@implementation Entries

+(void)get50TopEntries:(NSNumber *)after withCompletion:(completion)completion {
    
    NSString *requestURL = @"/top.json?limit=50";
    
    NSDictionary *params = @{@"after" : after};
    
    [[NetworkManager sharedInstance] GET:requestURL parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *jsonData = responseObject;
        
        NSMutableArray *entries = [[NSMutableArray alloc] init];
        
        for (NSDictionary *entryData in jsonData[kEntriesDataKey][kEntriesChildrenKey]) {
            
            Entry *entry = [[Entry alloc] initWithDictionary:entryData];
            [entries addObject:entry];
            
        }
        
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        
        if ([entries count] > 0) {
            
            [userInfo setObject:entries forKey:kEntriesDataKey];
            
        }
        
        if (![jsonData[kEntriesDataKey][kEntriesAfterKey] isKindOfClass:[NSNull class]]) {
            
            [userInfo setObject:jsonData[kEntriesDataKey][kEntriesAfterKey] forKey:kEntriesAfterKey];
            
        }
        
        if (![jsonData[kEntriesDataKey][kEntriesBeforeKey] isKindOfClass:[NSNull class]]) {
            
            [userInfo setObject:jsonData[kEntriesDataKey][kEntriesBeforeKey] forKey:kEntriesBeforeKey];
            
        }
        
        if (completion) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(userInfo,nil);
            });
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
        }
        
    }];
    
}
@end
