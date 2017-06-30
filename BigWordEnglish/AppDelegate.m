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
#import "GlobalObject.h"

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
    
    const char *sql;
    if([WORD_LEVEL_CHECK isEqualToString:@""]){
        if([COL4_CHECK isEqualToString:@""]){
            NSString *sqlValue;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word ORDER BY col_2 ASC LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word ORDER BY col_6 LIMIT '%ld", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word ORDER BY col_4 ASC LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word ORDER BY col_4 DESC LIMIT '%ld'", LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
            
        }else{
            NSString *sqlValue;
            NSString *col4Value = COL4_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' ORDER BY col_2 ASC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' ORDER BY col_6 LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' ORDER BY col_4 ASC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' ORDER BY col_4 DESC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
        }
    }else{
        if([COL4_CHECK isEqualToString:@""]){
            NSString *sqlValue;
            NSString *wordLevelValue = WORD_LEVEL_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_6='%s' LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_6='%s' ORDER BY col_2 ASC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_6='%s' ORDER BY col_6 LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_6='%s' ORDER BY col_4 ASC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_6='%s' ORDER BY col_4 DESC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
            
        }else{
            NSString *sqlValue;
            NSString *col4Value = COL4_CHECK;
            NSString *wordLevelValue = WORD_LEVEL_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' AND col_6='%s' LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' AND col_6='%s' ORDER BY col_2 ASC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' AND col_6='%s' ORDER BY col_6 LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' AND col_6='%s' ORDER BY col_4 ASC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_4>'%ld' AND col_6='%s' ORDER BY col_4 DESC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
            NSLog(@"%@", sqlValue);
        }
    }
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *col2 = ((char *)sqlite3_column_text(statement, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] :
            nil;
            if(col2 == nil){
                col2 = @"";
            }
            
            NSString *col3 = ((char *)sqlite3_column_text(statement, 2)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)] :
            nil;
            if(col3 == nil){
                col3 = @"";
            }
            
            NSString *col5 = ((char *)sqlite3_column_text(statement, 4)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)] :
            nil;
            if(col5 == nil){
                col5 = @"";
            }
            
            NSString *col6 = ((char *)sqlite3_column_text(statement, 5)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)] :
            nil;
            if(col6 == nil){
                col6 = @"";
            }
            
            NSString *col7 = ((char *)sqlite3_column_text(statement, 6)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)] :
            nil;
            if(col7 == nil){
                col7 = @"";
            }
            
            NSString *col8 = ((char *)sqlite3_column_text(statement, 7)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)] :
            nil;
            if(col8 == nil){
                col8 = @"";
            }
            
            NSString *col10 = ((char *)sqlite3_column_text(statement, 9)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)] :
            nil;
            if(col10 == nil){
                col10 = @"";
            }
            
            NSString *col11 = ((char *)sqlite3_column_text(statement, 10)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)] :
            nil;
            if(col11 == nil){
                col11 = @"";
            }
            
            NSString *col12 = ((char *)sqlite3_column_text(statement, 11)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)] :
            nil;
            if(col12 == nil){
                col12 = @"";
            }
            
            NSString *col13 = ((char *)sqlite3_column_text(statement, 12)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)] :
            nil;
            if(col13 == nil){
                col13 = @"";
            }
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"col_1",
                                 col2,@"col_2",
                                 col3,@"col_3",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 3)],@"col_4",
                                 col5,@"col_5",
                                 col6,@"col_6",
                                 col7,@"col_7",
                                 col8,@"col_8",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 8)],@"col_9",
                                 col10,@"col_10",
                                 col11,@"col_11",
                                 col12,@"col_12",
                                 col13,@"col_13",
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
    
    const char *sql;
    if([WORD_LEVEL_CHECK isEqualToString:@""]){
        if([COL4_CHECK isEqualToString:@""]){
            NSString *sqlValue;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? ORDER BY col_2 ASC LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? ORDER BY col_6 LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? ORDER BY col_4 ASC LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? ORDER BY col_4 DESC LIMIT '%ld'", LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
            
        }else{
            NSString *sqlValue;
            NSString *col4Value = COL4_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' ORDER BY col_2 ASC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' ORDER BY col_6 LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' ORDER BY col_4 ASC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' ORDER BY col_4 DESC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
        }
    }else{
       if([COL4_CHECK isEqualToString:@""]){
           NSString *sqlValue;
           NSString *wordLevelValue = WORD_LEVEL_CHECK;
           if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_6='%s' LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_6='%s' ORDER BY col_2 ASC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_6='%s' ORDER BY col_6 LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_6='%s' ORDER BY col_4 ASC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_6='%s' ORDER BY col_4 DESC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
           }
           
           sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
       }else{
           NSString *sqlValue;
           NSString *col4Value = COL4_CHECK;
           NSString *wordLevelValue = WORD_LEVEL_CHECK;
           if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' AND col_6='%s' LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_2 ASC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_6 LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_4 ASC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
           }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
               sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_10=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_4 DESC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
           }
           
           sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
       }
    }
    
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [categoryValue UTF8String],  -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *col2 = ((char *)sqlite3_column_text(statement, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] :
            nil;
            if(col2 == nil){
                col2 = @"";
            }
            
            NSString *col3 = ((char *)sqlite3_column_text(statement, 2)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)] :
            nil;
            if(col3 == nil){
                col3 = @"";
            }
            
            NSString *col5 = ((char *)sqlite3_column_text(statement, 4)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)] :
            nil;
            if(col5 == nil){
                col5 = @"";
            }
            
            NSString *col6 = ((char *)sqlite3_column_text(statement, 5)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)] :
            nil;
            if(col6 == nil){
                col6 = @"";
            }
            
            NSString *col7 = ((char *)sqlite3_column_text(statement, 6)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)] :
            nil;
            if(col7 == nil){
                col7 = @"";
            }
            
            NSString *col8 = ((char *)sqlite3_column_text(statement, 7)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)] :
            nil;
            if(col8 == nil){
                col8 = @"";
            }
            
            NSString *col10 = ((char *)sqlite3_column_text(statement, 9)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)] :
            nil;
            if(col10 == nil){
                col10 = @"";
            }
            
            NSString *col11 = ((char *)sqlite3_column_text(statement, 10)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)] :
            nil;
            if(col11 == nil){
                col11 = @"";
            }
            
            NSString *col12 = ((char *)sqlite3_column_text(statement, 11)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)] :
            nil;
            if(col12 == nil){
                col12 = @"";
            }
            
            NSString *col13 = ((char *)sqlite3_column_text(statement, 12)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)] :
            nil;
            if(col13 == nil){
                col13 = @"";
            }
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"col_1",
                                 col2,@"col_2",
                                 col3,@"col_3",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 3)],@"col_4",
                                 col5,@"col_5",
                                 col6,@"col_6",
                                 col7,@"col_7",
                                 col8,@"col_8",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 8)],@"col_9",
                                 col10,@"col_10",
                                 col11,@"col_11",
                                 col12,@"col_12",
                                 col13,@"col_13",
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
    
    const char *sql;
    if([WORD_LEVEL_CHECK isEqualToString:@""]){
        if([COL4_CHECK isEqualToString:@""]){
            NSString *sqlValue;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? ORDER BY col_2 ASC LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? ORDER BY col_6 LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? ORDER BY col_4 ASC LIMIT '%ld'", LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? ORDER BY col_4 DESC LIMIT '%ld'", LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
            
        }else{
            NSString *sqlValue;
            NSString *col4Value = COL4_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' ORDER BY col_2 ASC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' ORDER BY col_6 LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' ORDER BY col_4 ASC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' ORDER BY col_4 DESC LIMIT '%ld'", [col4Value integerValue], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
        }
    }else{
        if([COL4_CHECK isEqualToString:@""]){
            NSString *sqlValue;
            NSString *wordLevelValue = WORD_LEVEL_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_6='%s' LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_6='%s' ORDER BY col_2 ASC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_6='%s' ORDER BY col_6 LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_6='%s' ORDER BY col_4 ASC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_6='%s' ORDER BY col_4 DESC LIMIT '%ld'", [wordLevelValue UTF8String], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
        }else{
            NSString *sqlValue;
            NSString *col4Value = COL4_CHECK;
            NSString *wordLevelValue = WORD_LEVEL_CHECK;
            if([[defaults stringForKey:WORD_NUM] isEqualToString:@"0"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' AND col_6='%s' LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"1"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_2 ASC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"2"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_6 LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"3"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_4 ASC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }else if([[defaults stringForKey:WORD_NUM] isEqualToString:@"4"]){
                sqlValue = [NSString stringWithFormat:@"SELECT * FROM Word WHERE col_13=? AND col_4>'%ld' AND col_6='%s' ORDER BY col_4 DESC LIMIT '%ld'", [col4Value integerValue], [wordLevelValue UTF8String], LIMIT_NUM];
            }
            
            sql = [sqlValue cStringUsingEncoding:[NSString defaultCStringEncoding]];
        }
    }

    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [@"true" UTF8String],  -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *col2 = ((char *)sqlite3_column_text(statement, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] :
            nil;
            if(col2 == nil){
                col2 = @"";
            }
            
            NSString *col3 = ((char *)sqlite3_column_text(statement, 2)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)] :
            nil;
            if(col3 == nil){
                col3 = @"";
            }
            
            NSString *col5 = ((char *)sqlite3_column_text(statement, 4)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)] :
            nil;
            if(col5 == nil){
                col5 = @"";
            }
            
            NSString *col6 = ((char *)sqlite3_column_text(statement, 5)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)] :
            nil;
            if(col6 == nil){
                col6 = @"";
            }
            
            NSString *col7 = ((char *)sqlite3_column_text(statement, 6)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)] :
            nil;
            if(col7 == nil){
                col7 = @"";
            }
            
            NSString *col8 = ((char *)sqlite3_column_text(statement, 7)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)] :
            nil;
            if(col8 == nil){
                col8 = @"";
            }
            
            NSString *col10 = ((char *)sqlite3_column_text(statement, 9)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)] :
            nil;
            if(col10 == nil){
                col10 = @"";
            }
            
            NSString *col11 = ((char *)sqlite3_column_text(statement, 10)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)] :
            nil;
            if(col11 == nil){
                col11 = @"";
            }
            
            NSString *col12 = ((char *)sqlite3_column_text(statement, 11)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)] :
            nil;
            if(col12 == nil){
                col12 = @"";
            }
            
            NSString *col13 = ((char *)sqlite3_column_text(statement, 12)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)] :
            nil;
            if(col13 == nil){
                col13 = @"";
            }
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 0)],@"col_1",
                                 col2,@"col_2",
                                 col3,@"col_3",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 3)],@"col_4",
                                 col5,@"col_5",
                                 col6,@"col_6",
                                 col7,@"col_7",
                                 col8,@"col_8",
                                 [NSNumber numberWithUnsignedInteger:sqlite3_column_int64(statement, 8)],@"col_9",
                                 col10,@"col_10",
                                 col11,@"col_11",
                                 col12,@"col_12",
                                 col13,@"col_13",
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

@end
