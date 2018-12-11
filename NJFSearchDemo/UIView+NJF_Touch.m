//
//  UIView+NJF_Touch.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//
static const char * NJF_UN_TOUCH_KEY = "NJF_UN_TOUCH_KEY";
static const char * NJF_UN_TOUCH_RECT_KEY = "NJF_UN_TOUCH_RECT_KEY";

#import "UIView+NJF_Touch.h"
#import <objc/runtime.h>

@implementation UIView (NJF_Touch)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:)), class_getInstanceMethod([UIView class], @selector(njf_pointInside:withEvent:)));
}

- (void)setUnTouch:(BOOL)unTouch {
    objc_setAssociatedObject(self, NJF_UN_TOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)unTouch {
    return objc_getAssociatedObject(self, NJF_UN_TOUCH_KEY) ? [objc_getAssociatedObject(self, NJF_UN_TOUCH_KEY) boolValue] : NO;
}

- (void)setUnTouchRect:(CGRect)unTouchRect {
    objc_setAssociatedObject(self, NJF_UN_TOUCH_RECT_KEY, [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)unTouchRect {
    return objc_getAssociatedObject(self, NJF_UN_TOUCH_RECT_KEY) ? [objc_getAssociatedObject(self, NJF_UN_TOUCH_RECT_KEY) CGRectValue] : CGRectZero;
}

- (BOOL)njf_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.unTouch) return NO;
    if (self.unTouchRect.origin.x == 0 && self.unTouchRect.origin.y == 0 && self.unTouchRect.size.width == 0 && self.unTouchRect.size.height == 0) {
        return [self njf_pointInside:point withEvent:event];
    } else {
        if (CGRectContainsPoint(self.unTouchRect, point)) return NO;
        else return [self njf_pointInside:point withEvent:event];
    }
}

@end
