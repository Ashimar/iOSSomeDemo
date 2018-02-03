//
//  AnimationViewController.h
//  LotteryHost
//
//  Created by myios on 2017/12/26.
//  Copyright © 2017年 郑惠珠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BUTTONBLOCK)(NSArray *winners);

@interface AnimationViewController : UIViewController

@property (nonatomic, copy)BUTTONBLOCK btnBlock;
@property (nonatomic, assign) NSInteger prizeID;
/// 背景图片
@property (nonatomic, strong) NSString *bgImageURL;
@end
