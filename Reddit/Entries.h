//
//  Entries.h
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kEntriesListNotification @"listEntriesNotification"
#define kEntriesDataKey @"data"
#define kEntriesAfterKey @"after"
#define kEntriesBeforeKey @"before"
#define kEntriesChildrenKey @"children"

typedef void(^completion)(id responseObject, NSError *error);

@interface Entries : NSObject

+(void)get50TopEntries:(NSNumber *)after withCompletion:(completion)completion;

@end
