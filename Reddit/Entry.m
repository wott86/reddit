//
//  Entry.m
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import "Entry.h"

@implementation Entry

-(instancetype)initWithDictionary:(NSDictionary *)entryInfo {
    self = [super init];
    if (self) {
        NSDictionary *entryData = entryInfo[@"data"];
        _name = entryData[@"name"];
        _title = entryData[@"title"];
        _comments = entryData[@"num_comments"];
        _created = [entryData[@"created_utc"] doubleValue];
        _author = entryData[@"author"];
        _thumbnailURL = [entryData[@"thumbnail"] length] > 0 ? [NSURL URLWithString:entryData[@"thumbnail"]] : nil;
        if ([entryData objectForKey:@"preview"]) {
            NSArray *images = entryData[@"preview"][@"images"];
            _picture = [NSURL URLWithString:[images firstObject][@"source"][@"url"]];
        }
        
    }
    return self;
}


@end
