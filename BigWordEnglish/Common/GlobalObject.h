//
//  GlobalObject.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalObject : NSObject

+ (GlobalObject *)sharedInstance;

@property (nonatomic, assign) NSInteger pointCheck;
@property (nonatomic, assign) NSString *bottomAdCheck;
@property (nonatomic, assign) NSString *wordLevelCheck;
@property (nonatomic, assign) NSString *col4Check;
@property (nonatomic, assign) NSInteger limitNum;

@end
