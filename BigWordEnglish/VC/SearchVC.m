//
//  SearchVC.m
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()

@end

@implementation SearchVC

@synthesize searchText;
@synthesize searchWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)searchButton:(id)sender {
    if(searchText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"검색어를 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    [searchText resignFirstResponder];
    
    NSString *urlValue = [NSString stringWithFormat:@"http://endic.naver.com/search.nhn?sLn=kr&isOnlyViewEE=N&query=%@", searchText.text];
    NSURL *url = [NSURL URLWithString:urlValue];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [searchWebView loadRequest:request];
}

@end
