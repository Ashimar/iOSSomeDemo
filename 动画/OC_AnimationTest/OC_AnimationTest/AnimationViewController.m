//
//  AnimationViewController.m
//  LotteryHost
//
//  Created by myios on 2017/12/26.
//  Copyright © 2017年 郑惠珠. All rights reserved.
//

#import "AnimationViewController.h"
#import "AgroupView.h"

/* 屏幕尺寸 */
#define Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Screen_Width [[UIScreen mainScreen] bounds].size.width

@interface AnimationViewController ()

{
    int num;
    NSTimer *timer ;
    CGFloat animationTime;
    NSMutableArray *_allAvatarArray;
}
@end

@implementation AnimationViewController

- (void)dealloc {
    NSLog(@"##### kill me %@", [[self class] description]);
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _allAvatarArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
     animationTime = 0.0;
    [self method2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawButton {
    CGFloat buttonWidth = Screen_Width/8;
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stopButton.frame = CGRectMake(100, 200, buttonWidth, buttonWidth);
    stopButton.backgroundColor = [UIColor orangeColor];
    [stopButton setTitle:@"停止" forState:0];
    [stopButton setTitleColor:[UIColor whiteColor] forState:0];
    stopButton.titleLabel.font = [UIFont systemFontOfSize:20];
    stopButton.layer.masksToBounds = YES;
    stopButton.layer.cornerRadius = buttonWidth/2;
    stopButton.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
    stopButton.layer.borderWidth = 10;
    [self.view addSubview:stopButton];
    
//    stopButton.center = self.view.center;
    [stopButton addTarget:self action:@selector(stopButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:stopButton];
}

- (void)stopButtonDidTouch: (UIButton *)sender {
    sender.backgroundColor = [UIColor lightGrayColor];
    sender.enabled = NO;
   
        [self dismissViewControllerAnimated:NO completion:nil];
   
}

- (void)method2 {
    num = 1;
    timer = [NSTimer scheduledTimerWithTimeInterval:animationTime target:self selector:@selector(startDrawView) userInfo:nil repeats:YES];
}

- (void)startDrawView {
    if (num > 25) {
        [timer invalidate];
        timer = nil;
        [self drawButton];
        return;
    }
//    if (num == 13) {
//        num++;
//        return;
//    }
    int j = num-1;
    int i = 0;
    while (j >= 5) {
        j = j - 5;
        i++;
    }
    
    NSLog(@"%d-%d- %d",j , i, num);
    
    CGFloat size = 30.0f;
    CGFloat tmp_x = Screen_Width/2 - 2 * size;
    CGFloat tmp_y = Screen_Height/2 - 2 * size;
    //    CGFloat cutScreenWidth = (Screen_Width - Screen_Width/5)/4;
    CGFloat cutScreenWidth = Screen_Width/2 ;
    CGFloat cutScreenHeight = Screen_Height/2;
    
    CGFloat start_x = tmp_x + size * j;
    CGFloat start_y = tmp_y + size * i;
    
    
    CGFloat end_x = - 5 * Screen_Width/10 + cutScreenWidth * j;
    CGFloat end_y = - 5 * Screen_Height/10 + cutScreenHeight * i;
    
    AgroupView *view = [[AgroupView alloc] initWithFrame:self.view.frame withBlockSize:size withImageArr:[self randomAvatar] withStartPoint:CGPointMake(start_x, start_y) withEndPoint:CGPointMake(end_x, end_y)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    //            int index = i * 5 + j + 1;
    switch (num) {
            case 1: case 5: case 21: case 25:
            view.animationTime = animationTime + 0.1;
            break;
            case 2: case 4: case 6: case 16: case 10: case 20: case 22: case 24:
            view.animationTime = animationTime + 0.15;
            break;
            case 3: case 11: case 15: case 23:
            view.animationTime = animationTime + 0.2;
            break;
            case 8: case 12: case 18: case 14:
            view.animationTime = animationTime + 0.25;
            break;
            case 7: case 9: case 17: case 19:
            view.animationTime = animationTime + 0.3;
            break;
        default:
            //            view.animationTime = 3-0.2;
            
            break;
    }
    view.animationTime = 3;
    [view startAnimation];
    
    num++;
}

- (NSArray *)randomAvatar {
    
    NSMutableArray *mAvatarArr = [NSMutableArray array];
    while (mAvatarArr.count < 6) {
        int index = arc4random() % 212 + 1;
        NSString *avatar = [NSString stringWithFormat:@"%d.jpg", index];
        if ([_allAvatarArray containsObject:avatar]) {
            continue;
        }
        [mAvatarArr addObject:avatar];
        [_allAvatarArray addObject:avatar];
    }
    return mAvatarArr;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
