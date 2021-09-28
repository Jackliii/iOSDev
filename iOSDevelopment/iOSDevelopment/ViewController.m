//
//  ViewController.m
//  iOSDevelopment
//
//  Created by 大明 on 2021/9/23.
//

#import "ViewController.h"
#import "MonitorCore.h"
#import "Common.h"
#import "ListTableView.h"
#import "Test.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *lab;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) ListTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[ListTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];

    _lab = [self createLabel];
    _lab.frame = CGRectMake(40, self.view.bounds.size.height - 56, self.view.bounds.size.width - 80, 30);
    [self.view addSubview:_lab];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateValue) userInfo:nil repeats:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
//    NSArray *rows = @[@(3), @(1), @(4), @(5), @(6)];
//    return [rows[section] integerValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%ld", (long)section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    sleep(indexPath.section / 4.0);
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
    return cell;
}


- (void)updateValue {
    _lab.text = [[MonitorCore monitor] logString];
}

- (UILabel *)createLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:12];
    lab.layer.cornerRadius = 10;
    lab.backgroundColor = AppleTableViewBackgroundColor;
    lab.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    lab.clipsToBounds = YES;
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

@end

