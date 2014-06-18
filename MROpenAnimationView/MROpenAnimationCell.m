//
//  MROpenAnimationCell.m
//  MROpenAnimationView
//
//  Created by Sheldon on 14-6-18.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "MROpenAnimationCell.h"

@implementation MROpenAnimationCell
{
    NSMutableArray *views_;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    views_ = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public Methods -

- (void)layoutUIWithStyle:(NSNumber *)style
{
    if ([style integerValue] == 1) {
        CGRect rect = CGRectMake(10, 10,CGRectGetWidth(self.bounds) - 20 ,CGRectGetHeight(self.bounds) - 20 );
        [self creatViewWithFrame:rect];
    } else {
        
        CGRect leftRect = CGRectMake(10, 10,CGRectGetMidX(self.bounds) - 20 ,CGRectGetHeight(self.bounds) - 20 );
        [self creatViewWithFrame:leftRect];
        
        CGRect rightRect = CGRectMake(CGRectGetMidX(self.bounds) + 10, 10,CGRectGetMidX(self.bounds) - 20 ,CGRectGetHeight(self.bounds) - 20 );
        [self creatViewWithFrame:rightRect];
    }
}

- (void)creatViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [self addSubview:view];
    [views_ addObject:view];
    UIColor *color = [UIColor colorWithRed:arc4random() % 255 * 1.0 / 255 green:arc4random() % 255 * 1.0 / 255 blue:arc4random() % 255 * 1.0 / 255 alpha:1];
    view.backgroundColor = color;
    view.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
}

- (void)animationWithPrecent:(CGFloat)precent
{
    if ([self.style integerValue] == 1) {
        UIView *view = [views_ firstObject];
        CGPoint point = view.center;
        if (self.direction) {
            point.x = self.contentView.center.x - CGRectGetWidth(self.bounds) * precent;
        } else {
            point.x = self.contentView.center.x + CGRectGetWidth(self.bounds) * precent;
        }
        
        view.center = point;
        self.alpha = 1- precent;
    } else {
        UIView *leftView = views_[0];
        UIView *rightView = views_[1];
        
        CGPoint leftPoint = leftView.center;
        CGPoint rightPoint = rightView.center;
        
        CGFloat leftXDistance = CGRectGetMidX(self.bounds) / 2 - CGRectGetWidth(leftView.bounds) * precent;
        
        CGFloat rightXDistance = CGRectGetMidX(self.bounds) *3 / 2 + CGRectGetWidth(rightView.bounds) * precent;
        
        
        leftPoint.x =  leftXDistance;
        rightPoint.x = rightXDistance;
        
        leftView.center = leftPoint;
        rightView.center = rightPoint;
        self.alpha= 1 - precent;
        
    }
}

@end
