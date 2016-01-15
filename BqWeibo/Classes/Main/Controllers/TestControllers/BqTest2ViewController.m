//
//  BqTest2ViewController.m
//  BqWeibo
//
//  Created by LinBq on 16/1/4.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqTest2ViewController.h"

@interface BqTest2ViewController ()

@end

@implementation BqTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/// 点击空白处
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
