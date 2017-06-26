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

@interface ChooseVC ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%ld", buttonIndexNum);
    
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

#pragma mark -
#pragma mark Next VC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detail"])
    {
        DetailVC *vc = [segue destinationViewController];
        vc.viewCheck = viewCheckNum;
        vc.detailDic = chooseDic;
    }
}

#pragma mark -
#pragma mark Button Action

- (void)buttonSelected{
    [scholasticTestButton setImage:[UIImage imageNamed:@"menu_01"] forState:UIControlStateNormal];
    [newspaperButton setImage:[UIImage imageNamed:@"menu_02"] forState:UIControlStateNormal];
    [toeicButton setImage:[UIImage imageNamed:@"menu_03"] forState:UIControlStateNormal];
    [movieButton setImage:[UIImage imageNamed:@"menu_04"] forState:UIControlStateNormal];
    [dramaButton setImage:[UIImage imageNamed:@"menu_05"] forState:UIControlStateNormal];
    [officialButton setImage:[UIImage imageNamed:@"menu_06"] forState:UIControlStateNormal];
    
    if(buttonIndexNum == 1){
        [scholasticTestButton setImage:[UIImage imageNamed:@"menu_01_press"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 2){
        [newspaperButton setImage:[UIImage imageNamed:@"menu_02_press"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 3){
        [toeicButton setImage:[UIImage imageNamed:@"menu_03_press"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 4){
        [movieButton setImage:[UIImage imageNamed:@"menu_04_press"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 5){
        [dramaButton setImage:[UIImage imageNamed:@"menu_05_press"] forState:UIControlStateNormal];
    }else if(buttonIndexNum == 6){
        [officialButton setImage:[UIImage imageNamed:@"menu_06_press"] forState:UIControlStateNormal];
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
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose3YearButton:(id)sender {
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose5YearButton:(id)sender {
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose7YearButton:(id)sender {
    [self performSegueWithIdentifier:@"detail" sender:sender];
    
    choosePopupView.hidden = YES;
    chooseView.hidden = YES;
}

- (IBAction)choose10YearButton:(id)sender {
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

@end
