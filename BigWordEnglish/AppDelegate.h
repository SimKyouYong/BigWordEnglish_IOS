//
//  AppDelegate.h
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 5. 9..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSMutableArray *)selectSubKey:(NSInteger)subKey;
- (NSMutableArray *)selectAllWord;
- (NSMutableArray *)selectBookmarkWord;
- (NSMutableArray *)selectCategoryWord:(NSString*)categoryValue;

- (void)wordBookmarkUpdate:(NSInteger)idNum bookmarkValue:(NSString*)bookmarkValue;
- (void)wordBookmarkReset;

@end

