//
//  PagingView.m
//  PageTest
//
//  Created by myios on 2018/1/5.
//  Copyright © 2018年 郑惠珠. All rights reserved.
//

#import "PagingView.h"

@interface PagingView ()
{
    UIButton *lastButton;
    NSMutableArray *textArray;
    UIButton *pageUpBtn;
    UIButton *pageDownBtn;
    UIButton *tailBtn;  // 尾页
}
@end

@implementation PagingView

/// 页码最大显示个数
static NSInteger showMaxPageNum = 5;

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)setTotalNum:(NSInteger)totalNum {
    _totalNum = totalNum;
    
    [self drawButton];
}

- (void)drawButton {
    textArray = [NSMutableArray arrayWithArray:@[@"首页",@"上一页",@"下一页",@"尾页",@"共20页"]];
    NSInteger num = _totalNum >= showMaxPageNum ? showMaxPageNum : _totalNum;
    for (int i = 0; i < num; i++) {
        [textArray insertObject:[NSString stringWithFormat:@"%d", i+1] atIndex:textArray.count - 3];
    }
    NSLog(@"%@", textArray);
    for (int i = 0; i < textArray.count; i++){
        CGFloat width = 80;
        CGFloat space = 15;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(self.frame.size.width/2-(width+space)*5 + i* (width+space), 60, width, width);
        [button setTitle:textArray[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        button.backgroundColor = [UIColor whiteColor];
        button.tag = i + 100;
        [self addSubview:button];
        /// 设置按钮边款和是否可点击
        if (i == textArray.count - 1) {
            button.enabled = NO;
            
        } else {
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [button addTarget:self action:@selector(pageButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
        // 第一页显示为选中状态
        if (i == 2) {
            lastButton = button;
            
            button.backgroundColor = [UIColor blueColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if (i == 1) {
            [self setButtonIsInvaildWithState:YES withButton:button];
            pageUpBtn = button;
        }
        if (i == textArray.count - 3) {
            pageDownBtn = button;
        }
    }
    
}

- (void)pageButtonDidTouch:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    [self setButtonIsInvaildWithState:NO withButton:pageUpBtn];
    [self setButtonIsInvaildWithState:NO withButton:pageDownBtn];
    
    NSInteger lastButtonPage = [lastButton.titleLabel.text integerValue];
    
    // 页码的点击响应
    if (sender.tag >= 102 && sender.tag < textArray.count + 100 - 3) {
        
        NSInteger curPage = [sender.titleLabel.text integerValue];
        if (curPage == lastButtonPage) {
            return;
        }
        /// 判断上下页面 的显示状态
        if (sender.tag == 106 && curPage == _totalNum) {
            [self setButtonIsInvaildWithState:YES withButton:pageDownBtn];
        } else if (sender.tag == 102 && curPage == 1) {
            [self setButtonIsInvaildWithState:YES withButton:pageUpBtn];
        } else {
            [self setButtonIsInvaildWithState:NO withButton:pageUpBtn];
            [self setButtonIsInvaildWithState:NO withButton:pageDownBtn];
        }
        
        if (sender.tag < 104 && curPage > 1) {
            if (curPage == 2 && sender.tag == 103) {
                [self changeButtonStateWithButton:sender];
                return;
            }
            // 步长
            NSInteger lenght = curPage == 2 ? 1 : 104 - sender.tag;
            // 减少页码
            [self reloadButtonWithIsAdd:NO andAddLenght:lenght];
           
            
        } else if (sender.tag >= 105 && curPage < _totalNum) {
            if (curPage ==  _totalNum-1 && sender.tag == 105) {
                [self changeButtonStateWithButton:sender];
                return;
            }
            // 步长
            NSInteger lenght = curPage == _totalNum - 1 ? 1 : sender.tag - 104;
            
            // 增加页码
            [self reloadButtonWithIsAdd:YES andAddLenght:lenght];
        } else {
            [self changeButtonStateWithButton:sender];
        }
    } else if (sender.tag == 101) {
        /// 上一页
        [self setButtonIsInvaildWithState:NO withButton:pageDownBtn];
        
        if ((lastButtonPage <= 3 && lastButtonPage > 1) || lastButtonPage > _totalNum - 2) {
            
            [self reloadButtonWithTag:lastButton.tag - 1];
            if (lastButtonPage - 1 == 1) {  // 当到达第一个page 的时候上一页按钮失效
                [self setButtonIsInvaildWithState:YES withButton:sender];
            }
        } else {
            // 减少页码
            [self reloadButtonWithIsAdd:NO andAddLenght:1];
        }
        
    } else if (sender.tag == textArray.count+ 100 - 3) {
        /// 下一页
        [self setButtonIsInvaildWithState:NO withButton:pageUpBtn];
        
        if ((lastButtonPage >  _totalNum-3 && lastButtonPage < _totalNum) || lastButtonPage < 3) {
            
            [self reloadButtonWithTag:lastButton.tag + 1];
            
            if (lastButtonPage + 1 == _totalNum) {
                
                [self setButtonIsInvaildWithState:YES withButton:pageDownBtn];
            }
        } else {
            // 减少页码
            [self reloadButtonWithIsAdd:YES andAddLenght:1];
        }
    } else if (sender.tag == 100) {
        // 首页
        [self tailButtonWithStartPage:1];
        [self setButtonIsInvaildWithState:YES withButton:pageUpBtn];
        [self setButtonIsInvaildWithState:NO withButton:tailBtn];
    } else if (sender.tag == textArray.count + 100 -2) {
        
        // 尾页
        tailBtn = sender;
        [self tailButtonWithStartPage:_totalNum];
        [self setButtonIsInvaildWithState:YES withButton:pageDownBtn];
        [self setButtonIsInvaildWithState:YES withButton:tailBtn];
    }
    
    
}

- (void)setButtonIsInvaildWithState:(BOOL)state withButton:(UIButton *)button {
    if (state) {
        // 无效的
        button.enabled = NO;
        [button setTitleColor:[UIColor lightGrayColor] forState:0];
    } else {
        // 有效的
        button.enabled = YES;
        [button setTitleColor:[UIColor blackColor] forState:0];
    }
}

- (void)changeButtonStateWithButton:(UIButton *)sender {
    
    sender.backgroundColor = [UIColor blueColor];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    lastButton.backgroundColor = [UIColor whiteColor];
    [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lastButton = sender;
}

- (void)tailButtonWithStartPage:(NSInteger) startPage {
    
    NSInteger index = startPage == 1 ? 0 : - 4;
    
    for (id obj in self.subviews) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)obj;
            
            if (button.tag >= 102 && button.tag < textArray.count + 100 - 3) {
                NSString *page = [NSString stringWithFormat:@"%ld", startPage + index];
                
                [button setTitle:page forState:0];
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if ((startPage == 1 && button.tag == 102 ) || (startPage == _totalNum && button.tag == 106 )) {
                    button.backgroundColor = [UIColor blueColor];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    lastButton = button;
                }
                index ++;
            }
        }
        
    }
    
}

/// 根据BUtton tag 来改变分页的页码和选中的页码
- (void)reloadButtonWithTag:(NSInteger)tag{
    
    for (id obj in self.subviews) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)obj;
            
            if (button.tag == tag) {
                
                button.backgroundColor = [UIColor blueColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                lastButton = button;
            } else {
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}

/// 根据步长来改变分页的页码和选中的页码
- (void)reloadButtonWithIsAdd :(BOOL)isAdd andAddLenght:(NSInteger)lenght{
    
    for (id obj in self.subviews) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)obj;
            
            if (button.tag >= 102 && button.tag < textArray.count + 100 - 3) {
                NSString *page;
                if (isAdd) {
                     page = [NSString stringWithFormat:@"%ld", [button.titleLabel.text integerValue] + lenght];
                } else {
                    page = [NSString stringWithFormat:@"%ld", [button.titleLabel.text integerValue] - lenght];
                }
                
                [button setTitle:page forState:0];
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (button.tag == 104) {
                    button.backgroundColor = [UIColor blueColor];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    lastButton = button;
                }
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
