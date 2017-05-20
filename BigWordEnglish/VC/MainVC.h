//
//  MainVC.h
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 5. 20..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : UIViewController<NSURLConnectionDelegate>{
    NSUserDefaults *defaults;
    
    NSMutableData *receivedData;
    
    NSString *resultValue;
    
    // 로딩뷰
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UIView *m_bannerView;

@end
