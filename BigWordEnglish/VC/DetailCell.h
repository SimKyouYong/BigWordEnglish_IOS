//
//  DetailCell.h
//  BigWordEnglish
//
//  Created by Joseph Kang on 2017. 6. 15..
//  Copyright © 2017년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (nonatomic) UILabel *numberLabel;
@property (nonatomic) UILabel *wordLabel;
@property (nonatomic) UILabel *wordLabel2;
@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) UILabel *contentExamLabel;
@property (nonatomic) UILabel *levelLabel;
@property (nonatomic) UIImageView *soundImg;
@property (nonatomic) UIButton *soundButton;
@property (nonatomic) UIImageView *bookmarkImg;
@property (nonatomic) UIButton *bookmarkButton;
@property (nonatomic) UIView *lineView;

@end
