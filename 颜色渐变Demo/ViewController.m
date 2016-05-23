//
//  ViewController.m
//  颜色渐变Demo
//
//  Created by 时双齐 on 16/3/21.
//  Copyright © 2016年 亿信互联. All rights reserved.
//

#import "ViewController.h"
#import "RadarAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    RadarAnimationView *rader = [[RadarAnimationView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    
    rader.center = self.view.center;
    
    rader.backgroundColor = [UIColor lightGrayColor];
    rader.image = [UIImage imageNamed:@"IMG_1314.JPG"];
    
    rader.block = ^{
    
        NSLog(@"1");
    };
    
    rader.selectBlock = ^{
        
        NSLog(@"2");
    };
    
    [self.view addSubview:rader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
