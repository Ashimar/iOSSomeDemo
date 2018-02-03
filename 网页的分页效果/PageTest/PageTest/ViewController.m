//
//  ViewController.m
//  PageTest
//
//  Created by myios on 2018/1/5.
//  Copyright © 2018年 郑惠珠. All rights reserved.
//

#import "ViewController.h"


#import "PagingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    PagingView *view = [[PagingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    view.totalNum = 23;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
