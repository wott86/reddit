//
//  TableViewController.m
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import "TableViewController.h"
#import "PictureViewController.h"
#import "TableViewFooterView.h"
#import "Entries.h"

@interface TableViewController ()
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) Entry *selectedEntry;
@property (strong, nonatomic) TableViewFooterView *tableViewFooterView;
@property (strong, nonatomic) NSString *after;
@property (strong, nonatomic) NSString *before;
@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *redditCell = [UINib nibWithNibName:kTableViewCellNibName bundle:nil];
    [self.tableView registerNib:redditCell forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    
    _tableViewFooterView = [[[NSBundle mainBundle] loadNibNamed:kTableViewFooterViewNibName owner:self options: nil] firstObject];
    [_tableViewFooterView.nextButton  addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = _tableViewFooterView;
    
    [Entries get50TopEntries:@0 withCompletion:^(id responseObject, NSError *error) {
        
        [self handleNewEntries:responseObject];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Entry *entry = [_data objectAtIndex:indexPath.row];
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    
    [cell configureCell:entry];
    
    if ([entry.picture.absoluteString length] > 0) {
 
        cell.delegate = self;
        
    }else {
        
        cell.delegate = nil;
        
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowPictureSegue"] && _selectedEntry) {
        
        PictureViewController *pictureViewController = segue.destinationViewController;
        pictureViewController.selectedEntry = _selectedEntry;
        _selectedEntry = nil;
        
    }
}

-(void)nextButtonClicked:(id)sender {
    
    [Entries get50TopEntries:_after withCompletion:^(id responseObject, NSError *error) {
        
        [self handleNewEntries:responseObject];
        
    }];
    
}

-(void)handleNewEntries:(NSDictionary *)userInfo {
    
    [_tableViewFooterView.nextButton setEnabled:NO];
    
    if (userInfo) {
        _data = userInfo[kEntriesDataKey];
        
        if (userInfo[kEntriesAfterKey]) {
            
            [_tableViewFooterView.nextButton setEnabled:YES];
            _after = userInfo[kEntriesAfterKey];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self scrollToTopAnimated];
            
        });
        
    }
}

-(void)scrollToTopAnimated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

-(void)entryForThumbnail:(Entry *)entry {
    
    _selectedEntry = entry;
    [self performSegueWithIdentifier:@"ShowPictureSegue" sender:self];
    
}

@end
