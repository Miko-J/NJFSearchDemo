//
//  UIView+NJF_Touch.h
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NJF_Touch)

// 是否能够响应touch事件
@property (nonatomic, assign) BOOL unTouch;
// 不响应touch事件的区域
@property (nonatomic, assign) CGRect unTouchRect;

@end

NS_ASSUME_NONNULL_END
