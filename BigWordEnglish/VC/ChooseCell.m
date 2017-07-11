//
//  ChooseCell.m
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 13..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import "ChooseCell.h"
#import "GlobalHeader.h"

@implementation ChooseCell

@synthesize titleLabel;
@synthesize selectButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WIDTH_FRAME - 20, 40)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18.0];
        [self addSubview:titleLabel];

        selectButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, WIDTH_FRAME - 20, 40)];
        [selectButton.layer setCornerRadius:0.0f];
        [selectButton.layer setBorderWidth:1.0f];
        [selectButton.layer setBorderColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0].CGColor];
        selectButton.layer.masksToBounds = YES;
        selectButton.layer.cornerRadius = 5.0;
        [self addSubview:selectButton];
    }
    return self;
}

@end
