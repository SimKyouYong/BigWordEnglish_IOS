//
//  MainVC.m
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 5. 20..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "MainVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import <QuartzCore/QuartzCore.h>
#import "ChooseVC.h"
#import "DetailVC.h"
#import "AppDelegate.h"
#import "SettingVC.h"
#import "SearchVC.h"

@interface MainVC () <CaulyAdViewDelegate>
            
@end

@implementation MainVC

@synthesize popupView;
@synthesize m_bannerView;
@synthesize introImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(WIDTH_FRAME == 414){
        introImage.image = [UIImage imageNamed:@"intro_414"];
    }else if(WIDTH_FRAME == 375){
        introImage.image = [UIImage imageNamed:@"intro_375"];
    }else{
        introImage.image = [UIImage imageNamed:@"intro_320"];
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    [self versionCheck];
}

- (void)versionCheck{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, VERSION_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (statusCode == 200) {
            if([[defaults stringForKey:DB_VERSION] isEqualToString:resultValue]){
                introImage.hidden = YES;
            }else{
                [self fileDown];
            }
        }
    }];
    [dataTask resume];
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
#pragma mark Next VC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"choose"])
    {
        ChooseVC *vc = [segue destinationViewController];
        vc.buttonIndexNum = buttonIndex;
    }
    if ([[segue identifier] isEqualToString:@"mainDetail"])
    {
        DetailVC *vc = [segue destinationViewController];
        vc.viewCheck = 1;
        vc.wordCheck = nextWordCheck;
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)searchButton:(id)sender {
    SearchVC *_searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"];
    [self.navigationController presentViewController:_searchVC animated:YES completion:nil];
}

- (IBAction)settingButton:(id)sender {
    SettingVC *_settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settingVC"];
    [self.navigationController pushViewController:_settingVC animated:NO];
}

- (IBAction)scholasticTestButton:(id)sender {
    buttonIndex = 1;
    [self performSegueWithIdentifier:@"choose" sender:sender];
}

- (IBAction)newspaperButton:(id)sender {
    buttonIndex = 2;
    [self performSegueWithIdentifier:@"choose" sender:sender];
}

- (IBAction)toeicButton:(id)sender {
    buttonIndex = 3;
    [self performSegueWithIdentifier:@"choose" sender:sender];
}

- (IBAction)movieButton:(id)sender {
    buttonIndex = 4;
    [self performSegueWithIdentifier:@"choose" sender:sender];
}

- (IBAction)dramaButton:(id)sender {
    buttonIndex = 5;
    [self performSegueWithIdentifier:@"choose" sender:sender];
}

- (IBAction)officialButton:(id)sender {
    buttonIndex = 6;
    [self performSegueWithIdentifier:@"choose" sender:sender];
}

- (IBAction)allWordViewButton:(id)sender {
    WORD_LEVEL_CHECK = @"";
    COL4_CHECK = @"";

    nextWordCheck = 1;
    [self performSegueWithIdentifier:@"mainDetail" sender:sender];
}

- (IBAction)wordViewSettingButton:(id)sender {
    WORD_LEVEL_CHECK = @"";
    COL4_CHECK = @"";
    
    nextWordCheck = 2;
    [self performSegueWithIdentifier:@"mainDetail" sender:sender];
}

#pragma mark -
#pragma mark FileDown

- (void)fileDown{
    //[self loadingInit];
    
    NSString *urlString = DB_FILE_URL
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
   
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    } else {
        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"파일 다운로드 실패하였습니다.\n앱 종료후 다시 시도해주세요." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {}];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
    //[self loadingClose];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSArray *fileArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [fileArr objectAtIndex:0];
    NSString *documentPath = [filepath stringByAppendingPathComponent:@"EgDb.db"];

    [receivedData writeToFile:documentPath atomically:YES];
    
    [defaults setObject:resultValue forKey:DB_VERSION];
    
    //[self loadingClose];
    
    introImage.hidden = YES;
}

#pragma mark -
#pragma mark Loading Method

- (void)loadingInit{
    popupView.hidden = NO;
    
    // 로딩관련
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(WIDTH_FRAME/2 - activityView.bounds.size.width/2, HEIGHT_FRAME/2 - activityView.bounds.size.height/2, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    [activityView startAnimating];
}

- (void)loadingClose{
    popupView.hidden = YES;
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
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
    [m_bannerView addSubview:m_bannerCauly];
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
