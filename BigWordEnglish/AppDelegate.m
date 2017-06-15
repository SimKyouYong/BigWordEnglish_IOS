//
//  AppDelegate.m
//  BigWordEnglish
//
//  Created by Joseph_iMac on 2017. 5. 9..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "AppDelegate.h"
#import <sqlite3.h>
#import "GlobalHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if([defaults stringForKey:WORD_NUM].length == 0){
        [defaults setObject:@"0" forKey:WORD_NUM];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark DB

// 카테고리 리스트
- (NSMutableArray *)selectSubKey:(NSInteger)subKey{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    sqlite3_stmt *statement;
    char *sql = "SELECT * FROM Category WHERE Category_Sub_Key=?";
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, subKey);
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"KeyIndex",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"Category_Sub_key",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"Category_Sub",
                                 nil];
            [Result addObject:dic];
        }
    }
    return Result;
}

// 모든 단어 가져오기
- (NSMutableArray *)selectAllWord{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    sqlite3_stmt *statement;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    char *sql;
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
        sql = "SELECT * FROM Word";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        sql = "SELECT * FROM Word ORDER BY col_2 ASC";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        sql = "SELECT * FROM Word ORDER BY col_6";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        sql = "SELECT * FROM Word ORDER BY col_4 ASC";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        sql = "SELECT * FROM Word ORDER BY col_4 DESC";
    }
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"col_1",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)],@"col_2",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)],@"col_3",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 3)],@"col_4",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)],@"col_5",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)],@"col_6",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 6)],@"col_7",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)],@"col_8",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 8)],@"col_9",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 9)],@"col_10",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 10)],@"col_11",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 11)],@"col_12",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 12)],@"col_13",
                                 nil];
            [Result addObject:dic];
        }
    }
    return Result;
}

// 카테고리 단어 가져오기
- (NSMutableArray *)selectCategoryWord:(NSString*)categoryValue{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    sqlite3_stmt *statement;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    char *sql;
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
        sql = "SELECT * FROM Word WHERE col_10=?";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        sql = "SELECT * FROM Word WHERE col_10=? ORDER BY col_2 ASC";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        sql = "SELECT * FROM Word WHERE col_10=? ORDER BY col_6";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        sql = "SELECT * FROM Word WHERE col_10=? ORDER BY col_4 ASC";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        sql = "SELECT * FROM Word WHERE col_10=? ORDER BY col_4 DESC";
    }
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [categoryValue UTF8String],  -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"col_1",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)],@"col_2",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)],@"col_3",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 3)],@"col_4",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)],@"col_5",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)],@"col_6",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 6)],@"col_7",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)],@"col_8",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 8)],@"col_9",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 9)],@"col_10",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 10)],@"col_11",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 11)],@"col_12",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 12)],@"col_13",
                                 nil];
            [Result addObject:dic];
        }
    }
    return Result;
}

// 모든 단어 즐겨찾기 가져오기
- (NSMutableArray *)selectBookmarkWord{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    sqlite3_stmt *statement;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    char *sql;
    if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
        sql = "SELECT * FROM Word WHERE col_13=?";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
        sql = "SELECT * FROM Word WHERE col_13=? ORDER BY col_2 ASC";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
        sql = "SELECT * FROM Word WHERE col_13=? ORDER BY col_6";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
        sql = "SELECT * FROM Word WHERE col_13=? ORDER BY col_4 ASC";
    }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
        sql = "SELECT * FROM Word WHERE col_13=? ORDER BY col_4 DESC";
    }

    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [@"true" UTF8String],  -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"col_1",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)],@"col_2",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)],@"col_3",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 3)],@"col_4",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)],@"col_5",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)],@"col_6",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 6)],@"col_7",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)],@"col_8",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 8)],@"col_9",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 9)],@"col_10",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 10)],@"col_11",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 11)],@"col_12",
                                 [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 12)],@"col_13",
                                 nil];
            [Result addObject:dic];
        }
    }
    return Result;
}

// 단어장 즐겨찾기 추가
- (void)wordBookmarkUpdate:(NSInteger)idNum bookmarkValue:(NSString*)bookmarkValue{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql = "UPDATE Word SET col_13=? WHERE col_1=?";
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [bookmarkValue UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 2, idNum);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"Error");
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

// 칼럼 업데이트 (NULL)
- (void)col12Update{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql = "UPDATE Word SET col_12=''";
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"Error");
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

- (void)col13Update{
    sqlite3 *database;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"EgDb.db"];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql = "UPDATE Word SET col_13=''";
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"Error");
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

@end
