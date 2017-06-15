//
//  NoticeVC.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeCell.h"

@interface NoticeVC ()

@end

@implementation NoticeVC

@synthesize noticeTableView;
@synthesize noticeWebview;
@synthesize closeButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"http://snap40.cafe24.com/BigWordEgs/admin/view_notice_list_json.php";
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        noticeArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [noticeTableView reloadData];
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [noticeArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeCell *cell = (NoticeCell *)[tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
    
    if (cell == nil){
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NoticeCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dic = [noticeArr objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dic objectForKey:@"mTitle"];
    cell.contentLabel.text = [dic objectForKey:@"mDate"];
    
    cell.cellSelectedButton.tag = indexPath.row;
    [cell.cellSelectedButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

- (void)selectedAction:(UIButton*)sender{
    NSDictionary *dic = [noticeArr objectAtIndex:sender.tag];
    pathStr = [NSString stringWithFormat:@"http://snap40.cafe24.com/BigWordEgs/admin/notice/%@", [dic objectForKey:@"mPath"]];
    
    noticeWebview.hidden = NO;
    closeButton.hidden = NO;
    
    NSURL *url = [NSURL URLWithString:pathStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [noticeWebview loadRequest:request];
}

- (IBAction)homeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeButton:(id)sender {
    noticeWebview.hidden = YES;
    closeButton.hidden = YES;
}

@end
