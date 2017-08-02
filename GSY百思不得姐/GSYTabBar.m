//
//  GSYTabBar.m
//  GSY百思不得姐
//
//  Created by Song on 17/8/2.
//  Copyright © 2017年 Song. All rights reserved.
//

#import "GSYTabBar.h"

@interface GSYTabBar()
@property(nonatomic,weak) UIButton *publishButton;
@end

@implementation GSYTabBar

#pragma mark - 懒加载
-(UIButton *)publishButton {
    if (!_publishButton) {
        /**** 添加中间的发布按钮 ****/
        // 创建中间的发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        // 点击事件
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return _publishButton;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    // 索引
    CGFloat index = 0;
    
    for (UIView *subview in self.subviews) {
        
#warning Find - UITabBarButton
        // 过滤掉非UITabBarButton,找到四个按钮
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
#warning Find - UITabBarButton
        
        // 设置frame
        CGFloat buttonX = index * buttonW;
        if (index >= 2) {
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    }
    
    /**** 设置中间的发布按钮的 frame ****/
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

-(void)publishClick {
    GSYLog(@"publish -- click");
}

@end
