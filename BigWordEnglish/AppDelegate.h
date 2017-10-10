//
//  AppDelegate.h
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 5. 9..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;

- (NSMutableArray *)selectSubKey:(NSInteger)subKey;
- (NSMutableArray *)selectAllWord:(NSString*)allWordQuery;
- (NSMutableArray *)selectBookmarkWord:(NSString*)bookmarkQuery;
- (NSMutableArray *)selectCategoryWord:(NSString*)categoryValue;

- (void)wordBookmarkUpdate:(NSInteger)idNum bookmarkValue:(NSString*)bookmarkValue;
- (void)wordBookmarkReset;

@property (nonatomic,retain) NSString* pushBadge;
@property (nonatomic,retain) NSString* pushAlert;
@property (nonatomic,retain) NSMutableArray* pushMethArray;;

@end

