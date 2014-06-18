//
//  MROpenAnimationViewController.m
//  MROpenAnimationView
//
//  Created by Sheldon on 14-6-18.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "MROpenAnimationViewController.h"
#import "MROpenAnimationCell.h"

#define CELL_HEIGHT ([UIScreen mainScreen].bounds.size.height / 4)
#define DELAY_PERCENT .5

@interface MROpenAnimationViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *numbers_;
    BOOL direct_;
}

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation MROpenAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    numbers_ = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < 100; i++) {
        [numbers_ addObject:@((arc4random() % 2) + 1)];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters -

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

#pragma mark - TableView DataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numbers_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MROpenAnimationCell";
    
    MROpenAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MROpenAnimationCell" owner:nil options:nil] lastObject];
    }
    
    NSInteger row = indexPath.row;
    
    cell.style = numbers_[row];
    
    if ([cell.style integerValue] == 1) {
        cell.direction = direct_;
        direct_ = !direct_;
    }
    
    [cell performSelector:@selector(layoutUIWithStyle:) withObject:cell.style];
    
    return cell;
}

#pragma mark - ScrollView Delegate -

- (void)scrollViewDidScroll:(UITableView *)tableView
{
    MROpenAnimationCell *firstCell = [tableView.visibleCells firstObject];
    
    CGPoint firstCellCenter = [tableView convertPoint:firstCell.center fromView:self.view];
    CGFloat firstPrecent = (0 - firstCellCenter.y) / (CELL_HEIGHT / 2);
    
    if (firstCellCenter.y < 0) {
        [firstCell animationWithPrecent:firstPrecent];
    } else {
        [firstCell animationWithPrecent:0];
    }
    
    MROpenAnimationCell *lastCell = [tableView.visibleCells lastObject];
    CGPoint lastCellCenter = [tableView convertPoint:lastCell.center toView:self.view];
    CGFloat maxY = [UIScreen mainScreen].bounds.size.height;
    CGFloat lastPrecent = (lastCellCenter.y - maxY) / ((CELL_HEIGHT) * 0.5);
    
    if (lastCellCenter.y > maxY) {
        [lastCell animationWithPrecent:lastPrecent];
    } else {
        [lastCell animationWithPrecent:0];
    }
    
    [tableView.visibleCells enumerateObjectsUsingBlock:^(MROpenAnimationCell *cell, NSUInteger idx, BOOL *stop) {
        if (idx != 0 && idx != (tableView.visibleCells.count - 1)) {
            [cell animationWithPrecent:0];
        }
    }];
}

@end
