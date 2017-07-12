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
@synthesize soundImg;
@synthesize soundButton;
@synthesize bookmarkImg;
@synthesize bookmarkButton;
@synthesize lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 70)];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        numberLabel.textColor = [UIColor colorWithRed:247.0/255.0 green:147.0/255.0 blue:18.0/255.0 alpha:1.0];
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        [self addSubview:numberLabel];
        
        wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, WIDTH_FRAME - 172, 20)];
        [wordLabel setBackgroundColor:[UIColor clearColor]];
        wordLabel.numberOfLines = 0;
        wordLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        wordLabel.textAlignment = NSTextAlignmentLeft;
        wordLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        [self addSubview:wordLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, WIDTH_FRAME - 172, 45)];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:244.0/255.0 alpha:1.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
        [self addSubview:contentLabel];
        
        contentExamLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, WIDTH_FRAME - 50, 45)];
        [contentExamLabel setBackgroundColor:[UIColor clearColor]];
        contentExamLabel.numberOfLines = 0;
        contentExamLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        contentExamLabel.textAlignment = NSTextAlignmentLeft;
        contentExamLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:14.0];
        [self addSubview:contentExamLabel];
        
        levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 121, 0, 40, 70)];
        [levelLabel setBackgroundColor:[UIColor clearColor]];
        levelLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        levelLabel.textAlignment = NSTextAlignmentCenter;
        levelLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [self addSubview:levelLabel];
        
        soundImg = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 75, 27, 18, 17)];
        soundImg.image = [UIImage imageNamed:@"btn_speak"];
        [self addSubview:soundImg];
        
        soundButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 81, 0, 18, 70)];
        soundButton.backgroundColor = [UIColor clearColor];
        [self addSubview:soundButton];
        
        bookmarkImg = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 40, 27, 18, 17)];
        bookmarkImg.image = [UIImage imageNamed:@"btn_favorite"];
        [self addSubview:bookmarkImg];
        
        bookmarkButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 52, 0, 42, 70)];
        bookmarkButton.backgroundColor = [UIColor clearColor];
        [self addSubview:bookmarkButton];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 0.5, WIDTH_FRAME - 20, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    return self;
}

@end
