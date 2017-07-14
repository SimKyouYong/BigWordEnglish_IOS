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
#import "GlobalObject.h"

@interface DetailVC () <CaulyAdViewDelegate, settingDelegate>

@end

@implementation DetailVC

@synthesize detailDic;
@synthesize viewCheck;
@synthesize wordCheck;
@synthesize bannerView;
@synthesize detailTableView;
@synthesize bottomFiveView;
@synthesize wordHidden5Button;
@synthesize meanHidden5Button;
@synthesize exam5Button;
@synthesize wordView5Button;
@synthesize setting5Button;
@synthesize allWordSettingView;
@synthesize wordLevelHighButton;
@synthesize wordLevelMidButton;
@synthesize wordLevelLowButton;
@synthesize word1Button;
@synthesize word2Button;
@synthesize word3Button;
@synthesize word4Button;
@synthesize word5Button;
@synthesize word7Button;
@synthesize word10Button;
@synthesize yearValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    wordLevelSelectedNum = 0;
    wordNumberSelectedNum = 0;
    listCountNum = 0;
    LIMIT_NUM = 0;
    
    detailListArr = [[NSMutableArray alloc] init];
    
    if(viewCheck == 1){
        if(wordCheck == 1){
            //[self allWordQuerySetting];
            bookmarkNum = 0;
        }else{
            //[self bookmarkQuerySetting];
            bookmarkNum = 1;
            wordView5Button.selected = 1;
            [wordView5Button setTitle:@"전체보기" forState:UIControlStateNormal];
            wordView5Button.backgroundColor = [UIColor darkGrayColor];
        }
    }else if(viewCheck == 2 || viewCheck == 3){
        //[self categoryQuerySetting:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
    }
    
    wordHiddenNum = 0;
    meanHiddenNum = 0;
    examHiddenNum = 0;
    
    wordHidden5Button.layer.masksToBounds = YES;
    wordHidden5Button.layer.cornerRadius = 15.0;
    meanHidden5Button.layer.masksToBounds = YES;
    meanHidden5Button.layer.cornerRadius = 15.0;
    exam5Button.layer.masksToBounds = YES;
    exam5Button.layer.cornerRadius = 15.0;
    wordView5Button.layer.masksToBounds = YES;
    wordView5Button.layer.cornerRadius = 15.0;
    setting5Button.layer.masksToBounds = YES;
    setting5Button.layer.cornerRadius = 15.0;
    
    reloads_ = -1;
    
    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:detailTableView withClient:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self caulyLoad];
    
    [self loadTable];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [pullToRefreshManager_ relocatePullToRefreshView];
}

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
    NSDictionary *dic = [detailListArr objectAtIndex:indexPath.row];
    
    // 타이틀 텍스트
    NSString *titleLength = [dic objectForKey:@"col_2"];
    NSAttributedString *titleAttributedText = [[NSAttributedString alloc] initWithString:titleLength attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:18.0]}];
    CGRect titleRect = [titleAttributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 172, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize titleSize = titleRect.size;
    
    // 상세 텍스트
    NSString *contentLength = [dic objectForKey:@"col_5"];
    NSAttributedString *contentAttributedText = [[NSAttributedString alloc] initWithString:contentLength attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:12.0]}];
    CGRect contentRect = [contentAttributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 172, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize contentSize = contentRect.size;
    
    if(examHiddenNum == 1){
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:[dic objectForKey:@"col_7"] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14.0]}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 50, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        
        return titleSize.height + 5 + contentSize.height + 5 + size.height + 2;
        
    }else{
        return titleSize.height + 5 + contentSize.height + 5;
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
    
    // 타이틀 텍스트
    NSString *titleLength = [dic objectForKey:@"col_2"];
    NSAttributedString *titleAttributedText = [[NSAttributedString alloc] initWithString:titleLength attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:18.0]}];
    CGRect titleRect = [titleAttributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 172, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize titleSize = titleRect.size;
    
    // 상세 텍스트
    NSString *contentLength = [dic objectForKey:@"col_5"];
    NSAttributedString *contentAttributedText = [[NSAttributedString alloc] initWithString:contentLength attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:12.0]}];
    CGRect contentRect = [contentAttributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 172, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize contentSize = contentRect.size;
    
    cell.wordLabel.frame = CGRectMake(45, 5, titleSize.width, titleSize.height);
    cell.wordLabel2.frame = CGRectMake(45 + titleSize.width + 5, 5, (WIDTH_FRAME - 172) - (titleSize.width), titleSize.height);
    cell.contentLabel.frame = CGRectMake(45, titleSize.height + 5, WIDTH_FRAME - 172, contentSize.height);
    
    cell.numberLabel.text = [[dic objectForKey:@"col_4"] stringValue];
    if([[[dic objectForKey:@"col_4"] stringValue] isEqualToString:@"0"]){
        cell.numberLabel.text = @"-";
    }
    
    cell.wordLabel.text = [dic objectForKey:@"col_2"];
    cell.wordLabel2.text = [NSString stringWithFormat:@"[%@]", [dic objectForKey:@"col_3"]];
    cell.contentLabel.text = contentLength;
    cell.levelLabel.text = [dic objectForKey:@"col_6"];
    
    cell.soundButton.tag = indexPath.row;
    [cell.soundButton addTarget:self action:@selector(soundAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.bookmarkButton.tag = indexPath.row;
    [cell.bookmarkButton addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 단어가 2줄이상이면 발음기호 히든
    if(titleSize.height > 21){
        cell.wordLabel2.hidden = YES;
    }else{
        cell.wordLabel2.hidden = NO;
    }
    
    // 단어가리기
    if(wordHiddenNum == 1){
        cell.wordLabel.hidden = YES;
        cell.wordLabel2.hidden = YES;
    }else{
        cell.wordLabel.hidden = NO;
        cell.wordLabel2.hidden = NO;
    }
    
    // 뜻 가리기
    if(meanHiddenNum == 1){
        cell.contentLabel.hidden = YES;
    }else{
        cell.contentLabel.hidden = NO;
    }
    
    // 예문 가리기
    NSInteger examHeight = 0;
    if(examHiddenNum == 1){
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:[dic objectForKey:@"col_7"] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14.0]}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WIDTH_FRAME - 50, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        cell.contentExamLabel.frame = CGRectMake(45, titleSize.height + 2 + contentSize.height + 5, WIDTH_FRAME - 45, size.height);
        cell.contentExamLabel.hidden = NO;
        cell.contentExamLabel.text = [dic objectForKey:@"col_7"];
        examHeight = size.height + 2;
    }else{
        cell.contentExamLabel.hidden = YES;
    }
    
    // 즐겨찾기 상태값
    if(![[dic objectForKey:@"col_13"] isEqualToString:@"true"]){
        cell.bookmarkImg.image = [UIImage imageNamed:@"btn_favorite"];
    }else{
        cell.bookmarkImg.image = [UIImage imageNamed:@"btn_favorite_press"];
    }
    
    cell.numberLabel.frame = CGRectMake(10, 10, 29, 20);
    cell.levelLabel.frame = CGRectMake(WIDTH_FRAME - 121, (titleSize.height + 10 + contentSize.height)/2 - 9, 40, 17);
    cell.soundImg.frame = CGRectMake(WIDTH_FRAME - 75, (titleSize.height + 10 + contentSize.height)/2 - 9, 18, 17);
    cell.soundButton.frame = CGRectMake(WIDTH_FRAME - 81, 0, 29, titleSize.height + 5 + contentSize.height);
    cell.bookmarkImg.frame = CGRectMake(WIDTH_FRAME - 40, (titleSize.height + 10 + contentSize.height)/2 - 9, 18, 17);
    cell.bookmarkButton.frame = CGRectMake(WIDTH_FRAME - 52, 0, 42, titleSize.height + 5 + contentSize.height);
    cell.lineView.frame = CGRectMake(10, titleSize.height + 5 + contentSize.height + examHeight + 5 - 0.5, WIDTH_FRAME - 20, 0.5);
    
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {    
    [pullToRefreshManager_ tableViewReleased];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [pullToRefreshManager_ tableViewScrolled];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}

- (void)loadTable {
    LIMIT_NUM = LIMIT_NUM + 300;
    
    if(bookmarkNum == 0){
        if(viewCheck == 1){
            if(wordCheck == 1){
                [self allWordQuerySetting];
            }else{
                [self bookmarkQuerySetting];
            }
            
        }else if(viewCheck == 2 || viewCheck == 3){
            [self categoryQuerySetting:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
        }
    }else{
        [self bookmarkQuerySetting];
    }
    
    [detailTableView reloadData];
    
    reloads_++;
    
    [pullToRefreshManager_ tableViewReloadFinished];
}

#pragma mark -
#pragma mark Button Action

- (void)soundAction:(UIButton*)sender{
    NSDictionary *dic = [detailListArr objectAtIndex:sender.tag];
    
    AVSpeechSynthesizer * synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc]initWithString:[dic objectForKey:@"col_2"]];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.rate = 0.4f;
    
    [synthesizer speakUtterance:utterance];
}

- (void)bookmarkAction:(UIButton*)sender{
    NSDictionary *dic = [detailListArr objectAtIndex:sender.tag];
    
    DetailCell *cell = (DetailCell *)[detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    id AppID = [[UIApplication sharedApplication] delegate];
    
    if([[dic objectForKey:@"col_13"] isEqualToString:@""]){
        [AppID wordBookmarkUpdate:[[dic objectForKey:@"col_1"] integerValue] bookmarkValue:@"true"];
        cell.bookmarkImg.image = [UIImage imageNamed:@"btn_favorite_press"];
    }else{
        [AppID wordBookmarkUpdate:[[dic objectForKey:@"col_1"] integerValue] bookmarkValue:@""];
        cell.bookmarkImg.image = [UIImage imageNamed:@"btn_favorite"];
    }
    
    if(viewCheck == 1){
        if(bookmarkNum == 0){
            detailListArr = [[NSMutableArray alloc] init];
            [self allWordQuerySetting];
            [detailTableView reloadData];
        }else{
            //[self bookmarkQuerySetting];
        }
    }else if(viewCheck == 2 || viewCheck == 3){
        if(bookmarkNum == 0){
            detailListArr = [[NSMutableArray alloc] init];
            [self categoryQuerySetting:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
            [detailTableView reloadData];
        }else{
            //[self bookmarkQuerySetting];
        }
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

- (IBAction)wordHidden5Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordHiddenNum = 1;
        [wordHidden5Button setTitle:@"단어보기" forState:UIControlStateNormal];
        wordHidden5Button.backgroundColor = [UIColor darkGrayColor];
    }else{
        wordHiddenNum = 0;
        [wordHidden5Button setTitle:@"단어가리기" forState:UIControlStateNormal];
        wordHidden5Button.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:171.0/255.0 blue:238.0/255.0 alpha:1.0];
    }
    
    [detailTableView reloadData];
}

- (IBAction)meanHidden5Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        meanHiddenNum = 1;
        [meanHidden5Button setTitle:@"뜻보기" forState:UIControlStateNormal];
        meanHidden5Button.backgroundColor = [UIColor darkGrayColor];
    }else{
        meanHiddenNum = 0;
        [meanHidden5Button setTitle:@"뜻가리기" forState:UIControlStateNormal];
        meanHidden5Button.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:171.0/255.0 blue:238.0/255.0 alpha:1.0];
    }
    
    [detailTableView reloadData];
}

- (IBAction)exam5Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        examHiddenNum = 1;
        [exam5Button setTitle:@"예문가리기" forState:UIControlStateNormal];
        exam5Button.backgroundColor = [UIColor darkGrayColor];
    }else{
        examHiddenNum = 0;
        [exam5Button setTitle:@"예문보기" forState:UIControlStateNormal];
        exam5Button.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:171.0/255.0 blue:238.0/255.0 alpha:1.0];
    }
    
    [detailTableView reloadData];
}

- (IBAction)wordView5Button:(id)sender {
    detailListArr = [[NSMutableArray alloc] init];
    
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        bookmarkNum = 1;
        wordCheck = 2;
        [wordView5Button setTitle:@"전체보기" forState:UIControlStateNormal];
        wordView5Button.backgroundColor = [UIColor darkGrayColor];
        [self bookmarkQuerySetting];
    }else{
        bookmarkNum = 0;
        wordCheck = 1;
        [wordView5Button setTitle:@"단어장" forState:UIControlStateNormal];
        wordView5Button.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:171.0/255.0 blue:238.0/255.0 alpha:1.0];
        if(viewCheck == 2 || viewCheck == 3){
            [self categoryQuerySetting:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
        }else{
            [self allWordQuerySetting];
        }
    }
    
    [detailTableView reloadData];
}

- (IBAction)setting5Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        allWordSettingView.hidden = NO;
    }else{
        allWordSettingView.hidden = YES;
    }
}

- (IBAction)wordLevelHighButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordLevelSelectedNum = 1;
        [self wordLevelSelected];
        
    }else{
        [wordLevelHighButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordLevelSelectedNum = 0;
    }
}

- (IBAction)wordLevelMidButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordLevelSelectedNum = 2;
        [self wordLevelSelected];
        
    }else{
        [wordLevelMidButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordLevelSelectedNum = 0;
    }
}

- (IBAction)wordLevelLowButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordLevelSelectedNum = 3;
        [self wordLevelSelected];
        
    }else{
        [wordLevelLowButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordLevelSelectedNum = 0;
    }
}

// 난이도 설정 버튼
- (void)wordLevelSelected{
    [wordLevelHighButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [wordLevelMidButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [wordLevelLowButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    
    if(wordLevelSelectedNum == 1){
        [wordLevelHighButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordLevelSelectedNum == 2){
        [wordLevelMidButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordLevelSelectedNum == 3){
        [wordLevelLowButton setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }
}

- (IBAction)word1Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 1;
        [self wordSelected];
        
    }else{
        [word1Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

- (IBAction)word2Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 2;
        [self wordSelected];
        
    }else{
        [word2Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

- (IBAction)word3Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 3;
        [self wordSelected];
        
    }else{
        [word3Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

- (IBAction)word4Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 4;
        [self wordSelected];
        
    }else{
        [word4Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

- (IBAction)word5Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 5;
        [self wordSelected];
        
    }else{
        [word5Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

- (IBAction)word7Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 6;
        [self wordSelected];
        
    }else{
        [word7Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

- (IBAction)word10Button:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        wordNumberSelectedNum = 7;
        [self wordSelected];
        
    }else{
        [word10Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
        button.selected = 0;
        wordNumberSelectedNum = 0;
    }
}

// 출제횟수 설정 버튼
- (void)wordSelected{
    [word1Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [word2Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [word3Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [word4Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [word5Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [word7Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    [word10Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_off"] forState:UIControlStateNormal];
    
    if(wordNumberSelectedNum == 1){
        [word1Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordNumberSelectedNum == 2){
        [word2Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordNumberSelectedNum == 3){
        [word3Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordNumberSelectedNum == 4){
        [word4Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordNumberSelectedNum == 5){
        [word5Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordNumberSelectedNum == 6){
        [word7Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }else if(wordNumberSelectedNum == 7){
        [word10Button setBackgroundImage:[UIImage imageNamed:@"bg_search_set_on"] forState:UIControlStateNormal];
    }
}

- (void)totalSelected{
    // 단어 난이도 상중하
    if(wordLevelSelectedNum == 1){
        WORD_LEVEL_CHECK = @"상";
    }else if(wordLevelSelectedNum == 2){
        WORD_LEVEL_CHECK = @"중";
    }else if(wordLevelSelectedNum == 3){
        WORD_LEVEL_CHECK = @"하";
    }else{
        WORD_LEVEL_CHECK = @"";
    }
    
    // 출제 횟수
    if(wordNumberSelectedNum == 1){
        COL4_CHECK = @"0";
    }else if(wordNumberSelectedNum == 2){
        COL4_CHECK = @"1";
    }else if(wordNumberSelectedNum == 3){
        COL4_CHECK = @"2";
    }else if(wordNumberSelectedNum == 4){
        COL4_CHECK = @"3";
    }else if(wordNumberSelectedNum == 5){
        COL4_CHECK = @"4";
    }else if(wordNumberSelectedNum == 6){
        COL4_CHECK = @"6";
    }else if(wordNumberSelectedNum == 7){
        COL4_CHECK = @"9";
    }else{
        COL4_CHECK = @"";
    }
    
    detailListArr = [[NSMutableArray alloc] init];
    
    if(viewCheck == 1){
        if(bookmarkNum == 0){
            [self allWordQuerySetting];
        }else{
            [self bookmarkQuerySetting];
        }
    }else if(viewCheck == 2 || viewCheck == 3){
        [self categoryQuerySetting:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
    }
    
    [detailTableView reloadData];
}

- (IBAction)submitButton:(id)sender {
    allWordSettingView.hidden = YES;
    setting5Button.selected = 0;
    
    [self totalSelected];
}

- (IBAction)cancelButton:(id)sender {
    allWordSettingView.hidden = YES;
    setting5Button.selected = 0;
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
    [bannerView addSubview:m_bannerCauly];
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

#pragma mark -
#pragma mark Setting Delegate

- (void)settingClose{
    LIMIT_NUM = 300;
    
    if(bookmarkNum == 0){
        if(viewCheck == 1){
            if(wordCheck == 1){
                [self allWordQuerySetting];
            }else{
                [self bookmarkQuerySetting];
            }
            
        }else if(viewCheck == 2 || viewCheck == 3){
            [self categoryQuerySetting:[[detailDic objectForKey:@"KeyIndex"] stringValue]];
        }
    }else{
        [self bookmarkQuerySetting];
    }
    
    [detailTableView reloadData];
}

#pragma mark -
#pragma mark Query Setting

// 모든 단어
- (void)allWordQuerySetting{
    NSString *sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10='9000'"];
    
    // 난이도 체크
    if([WORD_LEVEL_CHECK isEqualToString:@""]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_6='%@'", sqlValue, WORD_LEVEL_CHECK];
    }
    
    // 출제횟수
    if([COL4_CHECK isEqualToString:@""]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_4>'%@'", sqlValue, COL4_CHECK];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
        sqlValue = [NSString stringWithFormat:@"%@ LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_2 ASC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_6 LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_4 ASC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_4 DESC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }
    
    id AppID = [[UIApplication sharedApplication] delegate];
    detailListArr = [AppID selectAllWord:sqlValue];
}

// Category Query
- (void)categoryQuerySetting:(NSString *)keyIndexValue{
    NSString *sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10='%@'", keyIndexValue];
    
    // 난이도 체크
    if([WORD_LEVEL_CHECK isEqualToString:@""]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_6='%@'", sqlValue, WORD_LEVEL_CHECK];
    }
    
    // 출제횟수
    if([COL4_CHECK isEqualToString:@""]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_4>'%@'", sqlValue, COL4_CHECK];
    }
    
    // 수능, 공무원 1개년도 체크
    if([yearValue isEqualToString:@"0"]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_9='%@'", sqlValue, yearValue];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
        sqlValue = [NSString stringWithFormat:@"%@ LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_2 ASC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_6 LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_4 ASC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_4 DESC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }
    
    id AppID = [[UIApplication sharedApplication] delegate];
    detailListArr = [AppID selectCategoryWord:sqlValue];
}

// 즐겨찾기
- (void)bookmarkQuerySetting{
    NSString *sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13='true'"];
    
    // 난이도 체크
    if([WORD_LEVEL_CHECK isEqualToString:@""]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_6='%@'", sqlValue, WORD_LEVEL_CHECK];
    }
    
    // 출제횟수
    if([COL4_CHECK isEqualToString:@""]){
    }else{
        sqlValue = [NSString stringWithFormat:@"%@ AND col_4>'%@'", sqlValue, COL4_CHECK];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
        sqlValue = [NSString stringWithFormat:@"%@ LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_2 ASC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_6 LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_4 ASC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        sqlValue = [NSString stringWithFormat:@"%@ ORDER BY col_4 DESC LIMIT '%ld'", sqlValue, LIMIT_NUM];
    }
    
    id AppID = [[UIApplication sharedApplication] delegate];
    detailListArr = [AppID selectBookmarkWord:sqlValue];
}

@end
