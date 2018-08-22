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
    btn.jw_acceptEventTimeInterval = 20.0;
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 200, 200, 60)];
    [btn2 setBackgroundColor:[UIColor yellowColor]];
    [btn2 setTitle:@"Button" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clickedBtn2:) forControlEvents:UIControlEventTouchUpInside];
    btn2.jw_acceptEventTimeInterval = 5.0;
    
    [self.view addSubview:btn2];
    
    
}

#pragma mark - actions & events
- (void)clickedBtn:(id)sender {
    NSLog(@"clicked button");
}

- (void)clickedBtn2:(id)sender {
    NSLog(@"cliked btn2");
}

@end
