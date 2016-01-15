//
//  BqTestViewController.m
//  Bq 微博
//
//  Created by LinBq on 15/12/30.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "BqTestViewController.h"
#import "BqTest2ViewController.h"

@interface BqTestViewController ()

@end

@implementation BqTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 点击 view 进行跳转
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BqTest2ViewController *testVC2 = [[BqTest2ViewController alloc] init];
    testVC2.title = @"测试2 控制器";
    [self.navigationController pushViewController:testVC2 animated:YES];
}

//}
@end
