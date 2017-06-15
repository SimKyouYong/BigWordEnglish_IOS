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
    id AppID = [[UIApplication sharedApplication] delegate];
    
    chooseArrList = [[NSMutableArray alloc] init];
    chooseArrList = [AppID selectSubKey:buttonIndexNum];
    
    NSLog(@"%@", chooseArrList);
    
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
    viewCheckNum = 3;
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
    
    // 수능
    if([[[dic objectForKey:@"KeyIndex"] stringValue] isEqualToString:@"18"]){
        
    // 공무원
    }else if([[[dic objectForKey:@"KeyIndex"] stringValue] isEqualToString:@"20"]){
        
    }else{
        viewCheckNum = 2;
        chooseDic = dic;
        [self performSegueWithIdentifier:@"detail" sender:sender];
    }
}

@end
