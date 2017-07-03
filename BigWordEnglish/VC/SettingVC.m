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

@synthesize wordNumCheck1;
@synthesize wordNumCheck2;
@synthesize wordNumCheck3;
@synthesize wordNumCheck4;
@synthesize bannerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    wordNumCheck1.selected = 0;
    wordNumCheck2.selected = 0;
    wordNumCheck3.selected = 0;
    wordNumCheck4.selected = 0;
    
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        wordNumCheck1.selected = 1;
        [wordNumCheck1 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        wordNumCheck2.selected = 1;
        [wordNumCheck2 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        wordNumCheck3.selected = 1;
        [wordNumCheck3 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        wordNumCheck4.selected = 1;
        [wordNumCheck4 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
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
        wordNumCheck1.selected = 0;
        [wordNumCheck1 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (IBAction)wordNumCheck2:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:2];
    }else{
        wordNumCheck2.selected = 0;
        [wordNumCheck2 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (IBAction)wordNumCheck3:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:3];
    }else{
        wordNumCheck3.selected = 0;
        [wordNumCheck3 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (IBAction)wordNumCheck4:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;

    if(button.selected == 1){
        [self wordNumSelectedInit:4];
    }else{
       wordNumCheck4.selected = 0;
        [wordNumCheck4 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (void)wordNumSelectedInit:(NSInteger)checkNum{
    wordNumCheck1.selected = 0;
    wordNumCheck2.selected = 0;
    wordNumCheck3.selected = 0;
    wordNumCheck4.selected = 0;
    
    [wordNumCheck1 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
    [wordNumCheck2 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
    [wordNumCheck3 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
    [wordNumCheck4 setImage:[UIImage imageNamed:@"check_box_false"] forState:UIControlStateNormal];
    
    [defaults setObject:@"0" forKey:WORD_NUM];
    
    if(checkNum == 1){
        wordNumCheck1.selected = 1;
        [wordNumCheck1 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
        [defaults setObject:@"1" forKey:WORD_NUM];
        
    }else if(checkNum == 2){
        wordNumCheck2.selected = 1;
        [wordNumCheck2 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
        [defaults setObject:@"2" forKey:WORD_NUM];
        
    }else if(checkNum == 3){
        wordNumCheck3.selected = 1;
        [wordNumCheck3 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
        [defaults setObject:@"3" forKey:WORD_NUM];
        
    }else if(checkNum == 4){
        wordNumCheck4.selected = 1;
        [wordNumCheck4 setImage:[UIImage imageNamed:@"check_box_true"] forState:UIControlStateNormal];
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
