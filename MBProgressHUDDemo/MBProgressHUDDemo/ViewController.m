//
//  ViewController.m
//  MBProgressHUDDemo
//
//  Created by 斌 on 2018/7/13.
//  Copyright © 2018年 斌. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+JJ.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSArray *titleArr;

@end

@implementation ViewController

- (NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"报错",@"提示信息",@"成功",@"加载中"];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:table];
    
    table.delegate = self;
    table.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [MBProgressHUD showError:@"出错了啊！"];
            break;
        }
            
        case 1:{
            [MBProgressHUD showMessage:@"提示信息：你被包围了！哈哈哈哈！！！"];
            break;
        }
        case 2:{
            [MBProgressHUD showSuccess:@"成功了！"];
            break;
        }
        case 3:{
            MBProgressHUD *hud = [MBProgressHUD showActivityMessage:@"加载中..."];
            [hud hide:YES afterDelay:kHudShowTime];
            break;
        }
        
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
