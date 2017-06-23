//
//  ChooseVC.h
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 13..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseVC : UIViewController{
    NSMutableArray *chooseArrList;
    
    NSDictionary *chooseDic;
    
    NSInteger viewCheckNum;
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic) NSInteger buttonIndexNum;

@property (weak, nonatomic) IBOutlet UIView *bannerView;

- (IBAction)homeButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)settingButton:(id)sender;
- (IBAction)scholasticTestButton:(id)sender;
- (IBAction)newspaperButton:(id)sender;
- (IBAction)toeicButton:(id)sender;
- (IBAction)movieButton:(id)sender;
- (IBAction)dramaButton:(id)sender;
- (IBAction)officialButton:(id)sender;

@end
