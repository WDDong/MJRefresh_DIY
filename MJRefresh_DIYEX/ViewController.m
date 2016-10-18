//
//  ViewController.m
//  MJRefresh_DIYEX
//
//  Created by waipmac02 on 2016/10/17.
//  Copyright © 2016年 111. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController 
static NSString *reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];

   MJDDGifHeader *header = [MJDDGifHeader headerWithRefreshingBlock:^{
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [_tableView.mj_header endRefreshing];
           [_tableView.mj_footer resetNoMoreData];
       });
   }];
    _tableView.mj_header = header;

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [_tableView.mj_footer endRefreshing];
        });
    }];
    _tableView.mj_footer = footer;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%d行",indexPath.row];

    return cell;

}

@end
