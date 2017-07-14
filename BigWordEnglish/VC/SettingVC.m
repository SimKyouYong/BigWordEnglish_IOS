//
//  SettingVC.m
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "SettingVC.h"
#import "NoticeVC.h"
#import "SearchVC.h"
#import "GlobalHeader.h"
#import "AppDelegate.h"

@interface SettingVC () <CaulyAdViewDelegate>

@end

@implementation SettingVC

@synthesize delegate;
@synthesize wordNumCheck1;
@synthesize wordNumImage1;
@synthesize wordNumCheck2;
@synthesize wordNumImage2;
@synthesize wordNumCheck3;
@synthesize wordNumImage3;
@synthesize wordNumCheck4;
@synthesize wordNumImage4;
@synthesize bannerView;
@synthesize bgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    bgView.layer.borderWidth = 3;
    bgView.layer.borderColor = [UIColor colorWithRed:210.0/255.0 green:211.0/255.0 blue:213.0/255.0 alpha:1.0].CGColor;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    wordNumCheck1.selected = 0;
    wordNumCheck2.selected = 0;
    wordNumCheck3.selected = 0;
    wordNumCheck4.selected = 0;
    
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        wordNumImage1.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage1.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck1.selected = 1;
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        wordNumImage2.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage2.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck2.selected = 1;
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        wordNumImage3.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage3.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck3.selected = 1;
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        wordNumImage4.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage4.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck4.selected = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self caulyLoad];
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.delegate settingClose];
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)searchButton:(id)sender {
    SearchVC *_searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"];
    [self.navigationController presentViewController:_searchVC animated:YES completion:nil];
}

- (IBAction)noticeButton:(id)sender {
    NoticeVC *_noticeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"noticeVC"];
    [self.navigationController presentViewController:_noticeVC animated:YES completion:nil];
}

- (IBAction)useButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://snap40.cafe24.com/BigWordEgs/img/help.png"]];
}

- (IBAction)wordNumCheck1:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:1];
    }else{
        wordNumImage1.backgroundColor = [UIColor clearColor];
        wordNumImage1.image = [UIImage imageNamed:@"check_box_false"];
        wordNumCheck1.selected = 0;
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (IBAction)wordNumCheck2:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:2];
    }else{
        wordNumImage2.backgroundColor = [UIColor clearColor];
        wordNumImage2.image = [UIImage imageNamed:@"check_box_false"];
        wordNumCheck2.selected = 0;
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (IBAction)wordNumCheck3:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:3];
    }else{
        wordNumImage3.backgroundColor = [UIColor clearColor];
        wordNumImage3.image = [UIImage imageNamed:@"check_box_false"];
        wordNumCheck3.selected = 0;
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (IBAction)wordNumCheck4:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:4];
    }else{
        wordNumImage4.backgroundColor = [UIColor clearColor];
        wordNumImage4.image = [UIImage imageNamed:@"check_box_false"];
        wordNumCheck4.selected = 0;
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (void)wordNumSelectedInit:(NSInteger)checkNum{
    wordNumImage1.image = [UIImage imageNamed:@"check_box_false"];
    wordNumImage2.image = [UIImage imageNamed:@"check_box_false"];
    wordNumImage3.image = [UIImage imageNamed:@"check_box_false"];
    wordNumImage4.image = [UIImage imageNamed:@"check_box_false"];
    
    wordNumCheck1.selected = 0;
    wordNumCheck2.selected = 0;
    wordNumCheck3.selected = 0;
    wordNumCheck4.selected = 0;
    
    wordNumImage1.backgroundColor = [UIColor clearColor];
    wordNumImage2.backgroundColor = [UIColor clearColor];
    wordNumImage3.backgroundColor = [UIColor clearColor];
    wordNumImage4.backgroundColor = [UIColor clearColor];
    
    [defaults setObject:@"0" forKey:WORD_NUM];
    
    if(checkNum == 1){
        wordNumImage1.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage1.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck1.selected = 1;
        [defaults setObject:@"1" forKey:WORD_NUM];
        
    }else if(checkNum == 2){
        wordNumImage2.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage2.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck2.selected = 1;
        [defaults setObject:@"2" forKey:WORD_NUM];
        
    }else if(checkNum == 3){
        wordNumImage3.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage3.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck3.selected = 1;
        [defaults setObject:@"3" forKey:WORD_NUM];
        
    }else if(checkNum == 4){
        wordNumImage4.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:250.0/255.0 alpha:1.0];
        wordNumImage4.image = [UIImage imageNamed:@"check_box_true"];
        wordNumCheck4.selected = 1;
        [defaults setObject:@"4" forKey:WORD_NUM];
    }
}

- (IBAction)bookmarkResetButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"알림" message:@"어플리케이션을 초기화 하시겠습니까?" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
    alert.tag = 9999;
    [alert show];
}

#pragma mark -
#pragma mark CaulyAdView Delegate

- (void)caulyLoad{
    CaulyAdSetting * adSetting = [CaulyAdSetting globalSetting];
    [CaulyAdSetting setLogLevel:CaulyLogLevelRelease];
    adSetting.adSize = CaulyAdSize_IPhone;
    adSetting.appCode = ClientID_Cauly;
    adSetting.animType = CaulyAnimNone;
    adSetting.useGPSInfo = NO;
    
    m_bannerCauly= [[CaulyAdView alloc] initWithParentViewController:self];
    m_bannerCauly.frame = CGRectMake(0, 0, WIDTH_FRAME, 50);
    m_bannerCauly.delegate = self;
    m_bannerCauly.showPreExpandableAd = TRUE;
    [bannerView addSubview:m_bannerCauly];
    [m_bannerCauly startBannerAdRequest];
}

// 광고 정보 수신 성공
- (void)didReceiveAd:(CaulyAdView *)adView isChargeableAd:(BOOL)isChargeableAd{
    NSLog(@"didReceiveCauly");
}

// 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString *)errorMsg {
    //NSLog(@"didFailToReceiveAd : %d(%@)", errorCode, errorMsg);
    
    NSLog(@"didFailCauly");
    [m_bannerCauly stopAdRequest];
}

#pragma mark -
#pragma mark AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 9999){
        if(buttonIndex == 1){
            id AppID = [[UIApplication sharedApplication] delegate];
            [AppID wordBookmarkReset];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    }
}


@end
