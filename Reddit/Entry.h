//
//  Entry.h
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Entry : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *title;
@property NSTimeInterval created;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSNumber *comments;
@property (strong, nonatomic) NSNumber *ups;
@property (strong, nonatomic) NSURL *thumbnailURL;
@property (strong, nonatomic) NSURL *picture;
@property (strong, nonatomic) UIImage *thumbnailImage;


-(instancetype)initWithDictionary:(NSDictionary *)entryInfo;
@end
