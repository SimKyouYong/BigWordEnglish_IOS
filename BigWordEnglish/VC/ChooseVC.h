//
//  ChooseVC.h
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 13..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaulyAdView.h"

@interface ChooseVC : UIViewController{
    NSMutableArray *chooseArrList;
    
    NSDictionary *chooseDic;
    
    NSInteger viewCheckNum;
    
    CaulyAdView *m_bannerCauly;
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic) NSInteger buttonIndexNum;

@property (weak, nonatomic) IBOutlet UIView *bannerView;

- (IBAction)homeButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)settingButton:(id)sender;
- (IBAction)scholasticTestButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *scholasticTestButton;
- (IBAction)newspaperButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *newspaperButton;
- (IBAction)toeicButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *toeicButton;
- (IBAction)movieButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *movieButton;
- (IBAction)dramaButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dramaButton;
- (IBAction)officialButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *officialButton;

@property (weak, nonatomic) IBOutlet UIView *choosePopupView;
@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (weak, nonatomic) IBOutlet UILabel *chooseText;

- (IBAction)choose1YearButton:(id)sender;
- (IBAction)choose3YearButton:(id)sender;
- (IBAction)choose5YearButton:(id)sender;
- (IBAction)choose7YearButton:(id)sender;
- (IBAction)choose10YearButton:(id)sender;

@end
