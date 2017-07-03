//
//  SettingVC.h
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaulyAdView.h"

@interface SettingVC : UIViewController{
    NSUserDefaults *defaults;
    
    CaulyAdView *m_bannerCauly;
}

@property (weak, nonatomic) IBOutlet UIView *bannerView;

- (IBAction)homeButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)noticeButton:(id)sender;
- (IBAction)useButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *wordNumCheck1;
- (IBAction)wordNumCheck1:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *wordNumCheck2;
- (IBAction)wordNumCheck2:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *wordNumCheck3;
- (IBAction)wordNumCheck3:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *wordNumCheck4;
- (IBAction)wordNumCheck4:(id)sender;

- (IBAction)bookmarkResetButton:(id)sender;

@end
