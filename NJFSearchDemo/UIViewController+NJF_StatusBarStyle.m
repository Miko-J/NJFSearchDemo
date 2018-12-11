//
//  UIViewController+NJF_StatusBarStyle.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//
static const char * NJF_STATUS_BAR_LIGHT_KEY = "NJF_STATUS_BAR_LIGHT_KEY";

#import "UIViewController+NJF_StatusBarStyle.h"
#import <objc/runtime.h>

@implementation UIViewController (NJF_StatusBarStyle)

- (void)setNjf_lightStatusBar:(BOOL)njf_lightStatusBar{
    objc_setAssociatedObject(self, NJF_STATUS_BAR_LIGHT_KEY, [NSNumber numberWithInt:njf_lightStatusBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)njf_lightStatusBar {
    return objc_getAssociatedObject(self, NJF_STATUS_BAR_LIGHT_KEY) ? [objc_getAssociatedObject(self, NJF_STATUS_BAR_LIGHT_KEY) boolValue] : NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.njf_lightStatusBar ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

@end
