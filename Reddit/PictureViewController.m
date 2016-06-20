//
//  PictureViewController.m
//  Reddit
//
//  Created by Cesar Vilera on 12/22/15.
//  Copyright © 2015 Cesar Vilera. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:_selectedEntry.picture];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:data];
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveImage:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_imageView.image,nil,nil,nil);
}


@end
