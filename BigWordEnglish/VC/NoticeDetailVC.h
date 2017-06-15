//
//  NoticeDetailVC.h
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeDetailVC : UIViewController

@property (nonatomic) NSString *pathValue;

- (IBAction)homeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *noticeDetailWebview;

@end
