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
        _titleArr = @[@"提示信息",@"报错",@"成功",@"警告",@"自定义图片信息",@"加载中",@"进度"];
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
            [MBProgressHUD showMessage:@"提示信息：你被包围了!哈哈哈哈!!!"];
            break;
        }
            
        case 1:{
            [MBProgressHUD showError:@"出错了啊!"];
            break;
        }
        case 2:{
            [MBProgressHUD showSuccess:@"成功了!"];
            break;
        }
        case 3:{
            [MBProgressHUD showWarning:@"警告注意!"];
            break;
        }
        case 4:{
            [MBProgressHUD showMessageWithImageName:@"MBHUD_Info" message:@"哈哈哈！"];
            break;
        }
        case 5:{
            MBProgressHUD *hud = [MBProgressHUD showActivityMessage:@"加载中..."];
            [hud hide:YES afterDelay:kHudShowTime];
            break;
        }
        case 6:{
            MBProgressHUD *hud = [MBProgressHUD showProgressBarToView:nil];
//            [hud showAnimated:YES whileExecutingBlock:^{
//                float progress = 0.0f;
//                while (progress < 1.0f) {
//                    progress += 0.01f;
//                    hud.progress = progress;
//                    usleep(50000);
//                }
//            } completionBlock:^{
//                [hud removeFromSuperview];
//
//            }];
            // 模拟网络请求进度
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
                float progress = 0.0f;
            
                while (progress < 1.0f) {
                    progress += 0.01f;
                    // 主线程刷新进度
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hud.progress = progress;
                    });
                    // 进程挂起50毫秒
                    usleep(50000);
                }
                // 100%后移除
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES];
                });
            });
            
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
