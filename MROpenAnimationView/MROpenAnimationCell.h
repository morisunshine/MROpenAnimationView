//
//  MROpenAnimationCell.h
//  MROpenAnimationView
//
//  Created by Sheldon on 14-6-18.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MROpenAnimationCell : UITableViewCell

@property (nonatomic, retain) NSNumber *style;
@property (nonatomic, assign) BOOL direction;

- (void)layoutUIWithStyle:(NSNumber *)style;
- (void)animationWithPrecent:(CGFloat)precent;

@end
