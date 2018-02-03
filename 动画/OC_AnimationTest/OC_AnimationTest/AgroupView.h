//
//  AgroupView.h
//  Animation3Dmove
//
//  Created by myios on 2017/12/22.
//  Copyright © 2017年 郑惠珠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgroupView : UIView

@property (nonatomic, assign) CGFloat animationTime;

- (void)startAnimation;

- (id)initWithFrame:(CGRect)frame withBlockSize:(CGFloat)size withImageArr:(NSArray *)avatarArr withStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint;
@end
