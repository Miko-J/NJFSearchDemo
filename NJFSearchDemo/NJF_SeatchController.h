//
//  NJF_SeatchController.h
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJF_SearchBar.h"
#import "NJF_SearchResultController.h"


NS_ASSUME_NONNULL_BEGIN

@interface NJF_SeatchController : UIViewController

@property (nonatomic, strong) NJF_SearchBar *searchBar;
@property (nonatomic, assign) BOOL hidesNavigationBarDuringPresentation;
@property (nonatomic, copy) void (^searchBlock)(NSString *text);
@property (nonatomic, strong) NJF_SearchResultController *resultVC;

@end

NS_ASSUME_NONNULL_END
