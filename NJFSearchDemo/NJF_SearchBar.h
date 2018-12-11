//
//  NJF_SearchBar.h
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NJF_SearchBar : UIView
@property (nonatomic, copy) void (^cancelBlok)(void);
@property (nonatomic, copy) NSString *_Nullable text;
@end
