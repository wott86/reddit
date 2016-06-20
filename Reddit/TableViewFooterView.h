//
//  TableViewFooterView.h
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTableViewFooterViewNibName @"TableViewFooterView"

@interface TableViewFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end
