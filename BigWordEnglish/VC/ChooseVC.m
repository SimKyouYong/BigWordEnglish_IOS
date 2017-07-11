//
//  ChooseVC.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 13..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "ChooseVC.h"
#import "ChooseCell.h"
#import "DetailVC.h"
#import "AppDelegate.h"
#import "SearchVC.h"
#import "SettingVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface ChooseVC () <CaulyAdViewDelegate>

@end

@implementation ChooseVC

@synthesize listTableView;
@synthesize buttonIndexNum;
@synthesize scholasticTestButton;
@synthesize newspaperButton;
@synthesize toeicButton;
@synthesize movieButton;
@synthesize dramaButton;
@synthesize officialButton;
@synthesize choosePopupView;
@synthesize chooseView;
@synthesize chooseText;
@synthesize bannerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    yearCheckValue = @"0";
    
    [self listLoad];
    [self buttonSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listLoad{
    id AppID = [[UIApplication sharedApplication] delegate];
    
    chooseArrList = [[NSMutableArray alloc] init];
    chooseArrList = [AppID selectSubKey:buttonIndexNum];
    
    [listTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self caulyLoad];
}

#pragma mark -
#pragma mark Next VC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detail"])
    {
        DetailVC *vc = [segue destinationViewController];
        vc.viewCheck = viewCheckNum;
        vc.detailDic = chooseDic;
        vc.yearValue = yearCheckValue;
    }
}

#pragma mark -
#pragma mark Button Action

- (void)buttonSelected{
    [scholasticTestButton setImage:[UIImage imageNamed:@"btn_sub_menu_01_off"] forState:UIControlStateNormal];
    [newspaperButton setImage:[UIImage imageNamed:@"btn_sub_menu_02_off"] forState:UIControlStateNormal];
    [toeicButton setImage:[UIImage imageNamed:@"btn_sub_menu_03_off"] forState:UIControlStateNormal];
    [movieButton setImage:[UIImage imageNamed:@"btn_sub_menu_04_off"] forState:UIControlStateNormal];
    [dramaButton setImage:[UIImage imageNamed:@"btn_sub_menu_05_off"] forState:UIControlStateNormal];
    [officialButton setImage:[UIImage imageNamed:@"btn_sub_menu_06_off"] forState:UIControlStateNormal];
    
    if(buttonIndexNum == 1){
        [scholasticTestButton setImage:[UIImage imageNamed:@"btn_sub_menu_01_on"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 2){
        [newspaperButton setImage:[UIImage imageNamed:@"btn_sub_menu_02_on"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 3){
        [toeicButton setImage:[UIImage imageNamed:@"btn_sub_menu_03_on"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 4){
        [movieButton setImage:[UIImage imageNamed:@"btn_sub_menu_04_on"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 5){
        [dramaButton setImage:[UIImage imageNamed:@"btn_sub_menu_05_on"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 6){
        [officialButton setImage:[UIImage imageNamed:@"btn_sub_menu_06_on"] forState:UIControlStateNormal];
    }
}

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchButton:(id)sender {
    SearchVC *_searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"];
    [self.navigationController presentViewController:_searchVC animated:YES completion:nil];
}

- (IBAction)settingButton:(id)sender {
    SettingVC *_settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settingVC"];
    [self.navigationController pushViewController:_settingVC animated:NO];
}

- (IBAction)scholasticTestButton:(id)sender {
    buttonIndexNum = 1;
    
    [self listLoad];
    [self buttonSelected];
}

- (IBAction)newspaperButton:(id)sender {
    buttonIndexNum = 2;
    
    [self listLoad];
    [self buttonSelected];
}

- (IBAction)toeicButton:(id)sender {
    buttonIndexNum = 3;
    
    [self listLoad];
    [self buttonSelected];
}

- (IBAction)movieButton:(id)sender {
    buttonIndexNum = 4;
    
    [self listLoad];
    [self buttonSelected];
}

- (IBAction)dramaButton:(id)sender {
    buttonIndexNum = 5;
    
    [self listLoad];
    [self buttonSelected];
}

- (IBAction)officialButton:(id)sender {
    buttonIndexNum = 6;
    
    [self listLoad];
    [self buttonSelected];
}

#pragma mark -
#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chooseArrList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseCell *cell = (ChooseCell *)[tableView dequeueReusableCellWithIdentifier:@"ChooseCell"];
    
    if (cell == nil){
        cell = [[ChooseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChooseCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    NSDictionary *dic = [chooseArrList objectAtIndex:indexPath.row];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.titleLabel.text = [dic objectForKey:@"Category_Sub"];
    
    cell.selectButton.tag = indexPath.row;
    [cell.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)selectAction:(UIButton*)sender{
    NSDictionary *dic = [chooseArrList objectAtIndex:sender.tag];
    
    WORD_LEVEL_CHECK = @"";
    COL4_CHECK = @"";
    chooseDic = dic;
    
    // 수능
    if([[[dic objectForKey:@"KeyIndex"] stringValue] isEqualToString:@"20"]){
        chooseText.text = @"수능";
        choosePopupView.hidden = NO;
        chooseView.hidden = NO;
        
    // 공무원
    }else if([[[dic objectForKey:@"KeyIndex"] stringValue] isEqualToString:@"18"]){
        chooseText.text = @"공무원";
        choosePopupView.hidden = NO;
        chooseView.hidden = NO;
        
    }else{
        viewCheckNum = 2;
        [self performSegueWithIdentifier:@"detail" sender:sender];
    }
}

- (IBAction)choose1YearButton:(id)sender {
    yearCheckValue = @"-1";
    
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose3YearButton:(id)sender {
    yearCheckValue = @"-3";
    
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose5YearButton:(id)sender {
    yearCheckValue = @"-5";
    
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose7YearButton:(id)sender {
    yearCheckValue = @"-7";
    
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose10YearButton:(id)sender {
    yearCheckValue = @"-10";
    
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if(choosePopupView == [touch view]){
        choosePopupView.hidden = YES;
        chooseView.hidden = YES;
    }
    
    [super touchesBegan:touches withEvent:event];
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

@end
