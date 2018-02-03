//
//  ViewController.m
//  OC_AnimationTest
//
//  Created by myios on 2018/2/3.
//  Copyright © 2018年 郑惠珠. All rights reserved.
//

#import "ViewController.h"
#import "AnimationViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) IBOutlet UIView *purpleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CATransform3D t = CATransform3DMakeTranslation(0, 0, 0);
    t = CATransform3DTranslate(t, 0, 0, 2.0);//将单位矩阵t做偏移运算后作为返回值
    _purpleView.layer.transform = t;
}

- (IBAction)startButtonDidTouch:(UIButton *)sender {
    AnimationViewController *animationVC = [AnimationViewController new];
   
    [self presentViewController:animationVC animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
