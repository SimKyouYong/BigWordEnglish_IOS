//
//  GlobalHeader.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#define WIDTH_FRAME             [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_FRAME            [[UIScreen mainScreen] bounds].size.height

#define DOCUMENT_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

// NSUserDefaults
#define DB_VERSION              @"db_version"
// 단어배열순서(알파벳-1, 난이도-2, 출제횟수 오름차순-3, 출제횟수 내림차순-4, 기본-0)
#define WORD_NUM               @"word_num"

// URL
#define COMMON_URL              @"http://snap40.cafe24.com/BigWordEgs/"
#define DB_FILE_URL             @"admin/db/egDb.db"
#define VERSION_URL             @"Version.php"

// 메모리 보관
#define POINT_CHECK             [GlobalObject sharedInstance].pointCheck
#define BOTTOM_AD_CHECK         [GlobalObject sharedInstance].bottomAdCheck
// 단어 난이도
#define WORD_LEVEL_CHECK        [GlobalObject sharedInstance].wordLevelCheck
// 단어 출제횟수
#define COL4_CHECK              [GlobalObject sharedInstance].col4Check

// AlertTag
#define TEST                    9999

// Ad@m(다음아담) Client ID
#define ClientID_Adam           @"DAN-ursep2xzotib"







