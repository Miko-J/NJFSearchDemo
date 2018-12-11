//
//  NJF_SearchTextField.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "NJF_SearchTextField.h"

@implementation NJF_SearchTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.canTouch = YES;
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL result = [super pointInside:point withEvent:event];
    if (self.canTouch) {
        return result;
    } else {
        return NO;
    }
}

- (void)dealloc {
    NSLog(@"NJF_SearchTextField dealloc");
}
@end
