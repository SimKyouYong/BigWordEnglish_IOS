//
//  SearchVC.h
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController

- (IBAction)homeButton:(id)sender;
- (IBAction)searchButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (weak, nonatomic) IBOutlet UIWebView *searchWebView;

@end
