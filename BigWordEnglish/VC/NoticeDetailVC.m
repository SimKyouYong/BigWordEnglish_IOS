//
//  NoticeDetailVC.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "NoticeDetailVC.h"

@interface NoticeDetailVC ()

@end

@implementation NoticeDetailVC

@synthesize pathValue;
@synthesize noticeDetailWebview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:pathValue];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [noticeDetailWebview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
