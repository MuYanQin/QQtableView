//
//  ViewController.m
//  QQTableView
//
//  Created by qinmuqiao on 2019/3/25.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "ViewController.h"
#import "QQTableView/QQtableView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,QQtableViewRequestDelegate>
@property (nonatomic , strong) QQtableView * tableView;
@property (nonatomic , strong) NSMutableArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray array];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"DEMO";
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:(UIBarButtonItemStylePlain) target:self action:@selector(ttt)];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
    //请求数据
    [self.tableView setUpWithUrl:@"/getData/getist" Parameters:@{} formController:self];
}
- (void)ttt
{
    [self.tableView  requestData];
}
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error
{
    
}
-(void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)PullDown SuccessData:(id)SuccessData
{

    if (self.dataArray.count >0) {
        self.dataArray = @[].mutableCopy;
    }else{
        self.dataArray = @[@"",@"",@""].mutableCopy;
    }

    //处理返回的SuccessData 数据之后刷新table
    [self.tableView reloadData];
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    cell.detailTextLabel.text = @(indexPath.row).stringValue;
    return cell;
}
- (QQtableView *)tableView
{
    if (!_tableView) {
        _tableView = [[QQtableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.RequestDelegate = self;
        //table是否有刷新
        _tableView.isHasHeaderRefresh = YES;
        _tableView.emptyView.imageName = @"noList";
        _tableView.emptyView.imageSize = CGSizeMake(90, 90);
        _tableView.emptyView.hintText = @"暂无数据";
        _tableView.emptyView.hintTextFont = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
        _tableView.emptyView.hintTextColor = [UIColor redColor];
    }
    return _tableView;
}

@end
