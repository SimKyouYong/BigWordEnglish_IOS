//
//  DetailVC.h
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController{
    NSMutableArray *detailListArr;
    
    NSInteger wordHiddenNum;
    NSInteger meanHiddenNum;
    NSUInteger bookmarkNum;
}

// 모든단어보기 & 카테고리 선택으로 들어왔는지 체크(모든 단어보기 - 1, 카테고리 - 2, 카테고리 모든단어 - 3)
@property (nonatomic) NSInteger viewCheck;
// 모든 단어보기인지 & 내 단어장 보기인지 체크(모든 단어보기 - 1, 내 단어장 보기 - 2)
@property (nonatomic) NSInteger wordCheck;

@property (nonatomic) NSDictionary *detailDic;

- (IBAction)homeButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)settingButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@property (weak, nonatomic) IBOutlet UIView *bannerView;

// 모든 단어 하단 버튼
@property (weak, nonatomic) IBOutlet UIView *bottomFourView;

- (IBAction)wordHiddenButton:(id)sender;
- (IBAction)meanHiddenButton:(id)sender;
- (IBAction)examButton:(id)sender;
- (IBAction)wordViewButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wordViewbutton;

// 카테고리 단어 하단 버튼
@property (weak, nonatomic) IBOutlet UIView *bottomFiveView;
- (IBAction)wordHidden5Button:(id)sender;
- (IBAction)meanHidden5Button:(id)sender;
- (IBAction)exam5Button:(id)sender;
- (IBAction)wordView5Button:(id)sender;
- (IBAction)setting5Button:(id)sender;

@end
