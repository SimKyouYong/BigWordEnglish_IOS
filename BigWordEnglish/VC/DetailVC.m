//
//  DetailVC.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "DetailVC.h"
#import "AppDelegate.h"
#import "DetailCell.h"
#import "SearchVC.h"
#import "SettingVC.h"
#import "GlobalHeader.h"

@interface DetailVC ()

@end

@implementation DetailVC

@synthesize detailDic;
@synthesize viewCheck;
@synthesize wordCheck;
@synthesize bannerView;
@synthesize detailTableView;
@synthesize bottomFourView;
@synthesize bottomFiveView;
@synthesize wordViewbutton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    detailListArr = [[NSMutableArray alloc] init];
    
    NSLog(@"%@", detailDic);
    NSLog(@"%ld", viewCheck);
    
    id AppID = [[UIApplication sharedApplication] delegate];
    if(viewCheck == 1){
        bottomFourView.hidden = NO;
        bottomFiveView.hidden = YES;
        
        if(wordCheck == 1){
            detailListArr = [AppID selectAllWord];
            wordViewbutton.selected = 0;
            bookmarkNum = 0;
        }else{
            detailListArr = [AppID selectBookmarkWord];
            wordViewbutton.selected = 1;
            bookmarkNum = 1;
        }
    }else if(viewCheck == 2 || viewCheck == 3){
        detailListArr = [AppID selectCategoryWord:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
        bottomFourView.hidden = YES;
        bottomFiveView.hidden = NO;
    }
    
    wordHiddenNum = 0;
    meanHiddenNum = 0;
    examHiddenNum = 0;
    bookmarkNum = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [detailListArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(examHiddenNum == 1){
        NSDictionary *dic = [detailListArr objectAtIndex:indexPath.row];
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:[dic objectForKey:@"col_7"] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:14.0]}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 50, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        
        return 70 + size.height;
        
    }else{
        return 70;
    }
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    
    if (cell == nil){
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dic = [detailListArr objectAtIndex:indexPath.row];
    
    cell.numberLabel.text = [[dic objectForKey:@"col_1"] stringValue];
    cell.wordLabel.text = [NSString stringWithFormat:@"%@ [%@]", [dic objectForKey:@"col_2"], [dic objectForKey:@"col_3"]];
    cell.contentLabel.text = [dic objectForKey:@"col_5"];
    cell.levelLabel.text = [dic objectForKey:@"col_6"];
    
    cell.soundButton.tag = indexPath.row;
    [cell.soundButton addTarget:self action:@selector(soundAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.bookmarkButton.tag = indexPath.row;
    [cell.bookmarkButton addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 단어가리기
    if(wordHiddenNum == 1){
        cell.wordLabel.hidden = YES;
    }else{
        cell.wordLabel.hidden = NO;
    }
    
    // 뜻 가리기
    if(meanHiddenNum == 1){
        cell.contentLabel.hidden = YES;
    }else{
        cell.contentLabel.hidden = NO;
    }
    
    // 예문 가리기
    if(examHiddenNum == 1){
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:[dic objectForKey:@"col_7"] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:14.0]}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 50, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        cell.contentExamLabel.frame = CGRectMake(50, 70, WIDTH_FRAME - 50, size.height);
        cell.contentExamLabel.hidden = NO;
        cell.contentExamLabel.text = [dic objectForKey:@"col_7"];
        cell.lineView.frame = CGRectMake(0, 69.5 + size.height, WIDTH_FRAME, 0.5);
    }else{
        cell.contentExamLabel.hidden = YES;
        cell.lineView.frame = CGRectMake(0, 69.5, WIDTH_FRAME, 0.5);
    }
    
    // 즐겨찾기 상태값
    if([[dic objectForKey:@"col_13"] isEqualToString:@""]){
        [cell.bookmarkButton setTitle:@"OFF" forState:UIControlStateNormal];
    }else{
        [cell.bookmarkButton setTitle:@"ON" forState:UIControlStateNormal];
    }
    
    return cell;
}

#pragma mark -
#pragma mark Button Action

- (void)soundAction:(UIButton*)sender{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    synthesizer = [[AVSpeechSynthesizer alloc] init];
    utterance.rate = 0.3;
    utterance.pitchMultiplier = 1.0;
    [synthesizer speakUtterance:utterance];
    
    //[synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)bookmarkAction:(UIButton*)sender{
    NSDictionary *dic = [detailListArr objectAtIndex:sender.tag];
    
    id AppID = [[UIApplication sharedApplication] delegate];
    
    if([[dic objectForKey:@"col_13"] isEqualToString:@""]){
        [AppID wordBookmarkUpdate:[[dic objectForKey:@"col_1"] integerValue] bookmarkValue:@"true"];
    }else{
        [AppID wordBookmarkUpdate:[[dic objectForKey:@"col_1"] integerValue] bookmarkValue:@""];
    }
    
    detailListArr = [[NSMutableArray alloc] init];
    if(bookmarkNum == 1){
        detailListArr = [AppID selectBookmarkWord];
    }else{
        detailListArr = [AppID selectAllWord];
    }
    [detailTableView reloadData];
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

- (IBAction)wordHiddenButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordHiddenNum = 1;
    }else{
        wordHiddenNum = 0;
    }
    
    [detailTableView reloadData];
}

- (IBAction)meanHiddenButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        meanHiddenNum = 1;
    }else{
        meanHiddenNum = 0;
    }
    
    [detailTableView reloadData];
}

- (IBAction)examButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        examHiddenNum = 1;
    }else{
        examHiddenNum = 0;
    }
    
    [detailTableView reloadData];
}

- (IBAction)wordViewButton:(id)sender {
    id AppID = [[UIApplication sharedApplication] delegate];
    detailListArr = [[NSMutableArray alloc] init];
    
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        bookmarkNum = 1;
        detailListArr = [AppID selectBookmarkWord];
    }else{
        bookmarkNum = 0;
        detailListArr = [AppID selectAllWord];
    }
 
    [detailTableView reloadData];
}

- (IBAction)wordHidden5Button:(id)sender {
}

- (IBAction)meanHidden5Button:(id)sender {
}

- (IBAction)exam5Button:(id)sender {
}

- (IBAction)wordView5Button:(id)sender {
}

- (IBAction)setting5Button:(id)sender {
}

@end
