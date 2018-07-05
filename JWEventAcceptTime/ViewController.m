//
//  ViewController.m
//  JWEventAcceptTime
//
//  Created by JessieWu on 2018/7/5.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+EventAcceptTime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    [self checkBtnAcceptTime];
}

#pragma mark - methods
- (void)checkBtnAcceptTime {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 120, 200, 60)];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.jw_acceptEventTimeInterval = 5.0;
    [self.view addSubview:btn];
}

#pragma mark - actions & events
- (void)clickedBtn:(id)sender {
    NSLog(@"clicked button");
}

@end
