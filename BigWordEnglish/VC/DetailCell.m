//
//  DetailCell.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "DetailCell.h"
#import "GlobalHeader.h"

@implementation DetailCell


@synthesize numberLabel;
@synthesize wordLabel;
@synthesize contentLabel;
@synthesize contentExamLabel;
@synthesize levelLabel;
@synthesize soundButton;
@synthesize bookmarkButton;
@synthesize lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 70)];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        numberLabel.textColor = [UIColor grayColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18.0];
        [self addSubview:numberLabel];
        
        wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, WIDTH_FRAME - 200, 20)];
        [wordLabel setBackgroundColor:[UIColor clearColor]];
        wordLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        wordLabel.textAlignment = NSTextAlignmentLeft;
        wordLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18.0];
        [self addSubview:wordLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, WIDTH_FRAME - 200, 45)];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:14.0];
        [self addSubview:contentLabel];
        
        contentExamLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, WIDTH_FRAME - 50, 45)];
        [contentExamLabel setBackgroundColor:[UIColor clearColor]];
        contentExamLabel.numberOfLines = 0;
        contentExamLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        contentExamLabel.textAlignment = NSTextAlignmentLeft;
        contentExamLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:14.0];
        [self addSubview:contentExamLabel];
        
        levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 150, 0, 50, 70)];
        [levelLabel setBackgroundColor:[UIColor clearColor]];
        levelLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        levelLabel.textAlignment = NSTextAlignmentCenter;
        levelLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [self addSubview:levelLabel];
        
        soundButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 100, 0, 50, 70)];
        [soundButton setImage:[UIImage imageNamed:@"btn_speak"] forState:UIControlStateNormal];
        [soundButton setImage:[UIImage imageNamed:@"btn_speak_press"] forState:UIControlStateHighlighted];
        [self addSubview:soundButton];
        
        bookmarkButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 50, 0, 50, 70)];
        [bookmarkButton setImage:[UIImage imageNamed:@"btn_favorite"] forState:UIControlStateNormal];
        [self addSubview:bookmarkButton];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, WIDTH_FRAME, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    return self;
}

@end
