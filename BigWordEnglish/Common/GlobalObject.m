//
//  GlobalObject.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "GlobalObject.h"

@implementation GlobalObject

+ (GlobalObject *)sharedInstance
{
    static GlobalObject *sharedInstance;
    
    @synchronized(self) {
        if(!sharedInstance) {
            sharedInstance = [[GlobalObject alloc] init];
        }
    }
    
    return sharedInstance;
}

- (id)init
{
    NSLog(@"%s", __FUNCTION__);
    
    self = [super init];
    if (self) {
        _pointCheck = 0;
        _bottomAdCheck = @"";
        _wordLevelCheck = @"";
        _col4Check = @"";
    }
    
    return self;
}

@end
