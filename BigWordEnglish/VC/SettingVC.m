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

@interface SettingVC ()

@end

@implementation SettingVC

@synthesize wordNumCheck1;
@synthesize wordNumCheck2;
@synthesize wordNumCheck3;
@synthesize wordNumCheck4;

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
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        wordNumCheck2.selected = 1;
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        wordNumCheck3.selected = 1;
        
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        wordNumCheck4.selected = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
}

- (void)wordNumSelectedInit:(NSInteger)checkNum{
    wordNumCheck1.selected = 0;
    wordNumCheck2.selected = 0;
    wordNumCheck3.selected = 0;
    wordNumCheck4.selected = 0;
    
    [defaults setObject:@"0" forKey:WORD_NUM];
    
    if(checkNum == 1){
        wordNumCheck1.selected = 1;
        [defaults setObject:@"1" forKey:WORD_NUM];
        
    }else if(checkNum == 2){
        wordNumCheck2.selected = 1;
        [defaults setObject:@"2" forKey:WORD_NUM];
        
    }else if(checkNum == 3){
        wordNumCheck3.selected = 1;
        [defaults setObject:@"3" forKey:WORD_NUM];
        
    }else if(checkNum == 4){
        wordNumCheck4.selected = 1;
        [defaults setObject:@"4" forKey:WORD_NUM];
    }
}

@end
