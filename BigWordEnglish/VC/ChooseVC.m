//
//  ChooseVC.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 13..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "ChooseVC.h"
#import "ChooseCell.h"

@interface ChooseVC ()

@end

@implementation ChooseVC

@synthesize listTableView;
@synthesize buttonIndexNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%ld", buttonIndexNum);
    
    [self listLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listLoad{
    chooseArrList = [[NSMutableArray alloc] init];
    
    if(buttonIndexNum == 1){
        [chooseArrList addObject:@"수능"];
        [chooseArrList addObject:@"수능 전체단어"];
    }else if(buttonIndexNum == 2){
        [chooseArrList addObject:@"신문 1"];
        [chooseArrList addObject:@"신문 2"];
        [chooseArrList addObject:@"신문 3"];
        [chooseArrList addObject:@"신문 전체단어"];
    }else if(buttonIndexNum == 3){
        [chooseArrList addObject:@"토익"];
        [chooseArrList addObject:@"토익 전체단어"];
    }else if(buttonIndexNum == 4){
        [chooseArrList addObject:@"영화 1"];
        [chooseArrList addObject:@"영화 2"];
        [chooseArrList addObject:@"영화 3"];
        [chooseArrList addObject:@"영화 4"];
        [chooseArrList addObject:@"영화 5"];
        [chooseArrList addObject:@"영화 전체단어"];
    }else if(buttonIndexNum == 5){
        [chooseArrList addObject:@"드라마 1"];
        [chooseArrList addObject:@"드라마 2"];
        [chooseArrList addObject:@"드라마 3"];
        [chooseArrList addObject:@"드라마 4"];
        [chooseArrList addObject:@"드라마 5"];
        [chooseArrList addObject:@"드라마 전체단어"];
    }else if(buttonIndexNum == 6){
        [chooseArrList addObject:@"9급 국가직"];
        [chooseArrList addObject:@"7급 국가직"];
        [chooseArrList addObject:@"일반순경"];
        [chooseArrList addObject:@"9급 지방직"];
        [chooseArrList addObject:@"7급 지방직"];
        [chooseArrList addObject:@"공무원"];
        [chooseArrList addObject:@"공무원 전체단어"];
    }
    
    NSLog(@"%@", chooseArrList);
    
    [listTableView reloadData];
}

#pragma mark -
#pragma mark Next VC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchButton:(id)sender {
}

- (IBAction)settingButton:(id)sender {
}

- (IBAction)scholasticTestButton:(id)sender {
    buttonIndexNum = 1;
    
    [self listLoad];
}

- (IBAction)newspaperButton:(id)sender {
    buttonIndexNum = 2;
    
    [self listLoad];
}

- (IBAction)toeicButton:(id)sender {
    buttonIndexNum = 3;
    
    [self listLoad];
}

- (IBAction)movieButton:(id)sender {
    buttonIndexNum = 4;
    
    [self listLoad];
}

- (IBAction)dramaButton:(id)sender {
    buttonIndexNum = 5;
    
    [self listLoad];
}

- (IBAction)officialButton:(id)sender {
    buttonIndexNum = 6;
    
    [self listLoad];
}

- (IBAction)allWordViewButton:(id)sender {
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
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.titleLabel.text = [chooseArrList objectAtIndex:indexPath.row];
    
    cell.selectButton.tag = indexPath.row;
    [cell.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)selectAction:(UIButton*)sender{
    
}

@end
