//
//  MainVC.h
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 5. 20..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaulyAdView.h"

@interface MainVC : UIViewController<NSURLConnectionDelegate>{
    NSUserDefaults *defaults;
    
    NSMutableData *receivedData;
    
    NSString *resultValue;
    
    // 로딩뷰
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    
    NSInteger buttonIndex;
    
    NSInteger nextWordCheck;
    
    CaulyAdView *m_bannerCauly;
}

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UIView *m_bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *introImage;

- (IBAction)searchButton:(id)sender;
- (IBAction)settingButton:(id)sender;
- (IBAction)scholasticTestButton:(id)sender;
- (IBAction)newspaperButton:(id)sender;
- (IBAction)toeicButton:(id)sender;
- (IBAction)movieButton:(id)sender;
- (IBAction)dramaButton:(id)sender;
- (IBAction)officialButton:(id)sender;
- (IBAction)allWordViewButton:(id)sender;
- (IBAction)wordViewSettingButton:(id)sender;

@end
