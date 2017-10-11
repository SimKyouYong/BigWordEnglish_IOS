//
//  DetailVC.h
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CaulyAdView.h"
#import "MNMBottomPullToRefreshManager.h"

@interface DetailVC : UIViewController<MNMBottomPullToRefreshManagerClient>{
    NSMutableArray *detailListArr;
    
    NSInteger wordHiddenNum;
    NSInteger meanHiddenNum;
    NSInteger examHiddenNum;
    NSInteger bookmarkNum;
    
    NSInteger wordLevelHighSelectedNum;
    NSInteger wordLevelMiddleSelectedNum;
    NSInteger wordLevelLowSelectedNum;
    NSInteger wordNumberSelectedNum;
    
    NSInteger listCountNum;
    
    CaulyAdView *m_bannerCauly;
    
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
}

// 모든단어보기 & 카테고리 선택으로 들어왔는지 체크(모든 단어보기 - 1, 카테고리 - 2, 카테고리 모든단어 - 3)
@property (nonatomic) NSInteger viewCheck;
// 모든 단어보기인지 & 내 단어장 보기인지 체크(모든 단어보기 - 1, 내 단어장 보기 - 2)
@property (nonatomic) NSInteger wordCheck;
// 기출문제 년도 체크(없으면 0)
@property (nonatomic) NSString *yearValue;

@property (nonatomic) NSDictionary *detailDic;

- (IBAction)homeButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)settingButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@property (weak, nonatomic) IBOutlet UIView *bannerView;

// 하단 버튼
@property (weak, nonatomic) IBOutlet UIView *bottomFiveView;
- (IBAction)wordHidden5Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wordHidden5Button;
- (IBAction)meanHidden5Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *meanHidden5Button;
- (IBAction)exam5Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exam5Button;
- (IBAction)wordView5Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wordView5Button;
- (IBAction)setting5Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *setting5Button;

// 단어보기 설정
@property (weak, nonatomic) IBOutlet UIView *allWordSettingView;
@property (weak, nonatomic) IBOutlet UIButton *wordLevelHighButton;
- (IBAction)wordLevelHighButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wordLevelMidButton;
- (IBAction)wordLevelMidButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wordLevelLowButton;
- (IBAction)wordLevelLowButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word1Button;
- (IBAction)word1Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word2Button;
- (IBAction)word2Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word3Button;
- (IBAction)word3Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word4Button;
- (IBAction)word4Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word5Button;
- (IBAction)word5Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word7Button;
- (IBAction)word7Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *word10Button;
- (IBAction)word10Button:(id)sender;

- (IBAction)submitButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
