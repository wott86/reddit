//
//  TableViewCell.m
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *entryDate;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (strong, nonatomic) Entry *entry;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(Entry *)entry {
    
    [self clearCell];
    
    _entry = entry;
    
    _title.text = entry.title;
    _thumbnail.image = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.thumbnail setImage:[UIImage imageNamed:@"thumbnail"]];
    });
        
    _author.text = [NSString stringWithFormat:@"Author: %@",entry.author];
    _comments.text = [NSString stringWithFormat:@"Comments: %@",[entry.comments stringValue]];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:entry.created];
    _entryDate.text = [NSString stringWithFormat:@"%ld hours ago",(long)[self hoursSince:date]];
    
    if (entry.thumbnailURL){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.thumbnail setImageWithURL:entry.thumbnailURL placeholderImage:[UIImage imageNamed:@"thumbnail"]];
        });
    }
    
}

-(void)clearCell {
    
    _entry = nil;
    _title.text = nil;
    _thumbnail.image = nil;
    _author.text = nil;
    _comments.text = nil;
    _entryDate.text = nil;
    
}

-(NSInteger)hoursSince:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar component:NSCalendarUnitHour fromDate:date];
}

- (IBAction)thumbnailTapped:(id)sender {
    if (self.delegate) {
        [self.delegate entryForThumbnail:_entry];
    }
}


@end
