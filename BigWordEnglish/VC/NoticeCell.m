//
//  NoticeCell.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "NoticeCell.h"
#import "GlobalHeader.h"

@implementation NoticeCell

@synthesize titleLabel;
@synthesize contentLabel;
@synthesize cellSelectedButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WIDTH_FRAME - 20, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18.0];
        [self addSubview:titleLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, WIDTH_FRAME - 20, 20)];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        contentLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        [self addSubview:contentLabel];
        
        cellSelectedButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 50)];
        [self addSubview:cellSelectedButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_FRAME, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    return self;
}

@end
