//
//  TableViewCell.h
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

#define kTableViewCellNibName @"CellView"
#define kTableViewCellReuseIdentifier @"redditCell"

@protocol TableViewCellDelegate <NSObject>

@required

-(void)entryForThumbnail:(Entry *)entry;

@end


@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) id <TableViewCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnail;

-(void)configureCell:(Entry *)entry;

@end
