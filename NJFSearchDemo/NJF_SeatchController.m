//
//  NJF_SeatchController.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "NJF_SeatchController.h"
#import "SearchHeader.h"
#import "UIView+NJF_Touch.h"
#import "UIView+NJF_Extension.h"
#import "UIViewController+NJF_StatusBarStyle.h"
#import "UIView+NJF_CurrentVC.h"

@interface NJF_SeatchController ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation NJF_SeatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    self.view.unTouchRect = CGRectMake(0, 0, self.view.width,kSafeAreaNavHeight);
    self.resultVC.view.frame = self.bgView.bounds;
    [self.bgView addSubview:self.resultVC.view];
}

#pragma mark - tap action

- (void)tapSearchBarAction{
    self.searchBar.currentVC.njf_lightStatusBar = NO;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.view];
    [self.searchBar setValue:@1 forKey:@"isEditing"];
    if (self.searchBar.currentVC.parentViewController && [self.searchBar.currentVC.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation){
        [(UINavigationController *)self.searchBar.currentVC.parentViewController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.bgView.y = kSafeAreaNavHeight;
        }];
    }
}

- (void)endSearchTextFieldEditing:(UITapGestureRecognizer *)sender {
    UITextField *searchTextField = [self.searchBar valueForKey:@"searchTextField"];
    [searchTextField resignFirstResponder];
}

//KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"] && self.searchBlock) {
        //更新resultVC数据
        self.searchBlock(self.searchBar.text);
    }
}

#pragma mark - lazy loading

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) +  kSafeAreaNavHeight, kScreenWidth, kScreenHeight - self.searchBar.frame.size.height - (IS_IPhoneX_All ? 44 : 20))];
        _bgView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endSearchTextFieldEditing:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [_bgView addGestureRecognizer:tapGestureRecognizer];
    }
    return _bgView;
}

- (NJF_SearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[NJF_SearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [_searchBar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchBarAction)]];
        [_searchBar addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        @weakObj(self);
        _searchBar.cancelBlok = ^{
            @strongObj(self);
             self.searchBar.currentVC.njf_lightStatusBar = YES;
             NSArray *searchBarGestures = self.searchBar.gestureRecognizers;
             if (searchBarGestures.count == 3) {
                [self.searchBar removeGestureRecognizer:searchBarGestures.lastObject];
                [self.searchBar removeGestureRecognizer:searchBarGestures.lastObject];
             }
             if (searchBarGestures.count == 2) {
                [self.searchBar removeGestureRecognizer:searchBarGestures.lastObject];
             }
             [self.view removeFromSuperview];
             [self.searchBar setValue:@0 forKey:@"isEditing"];
             if (self.searchBar.currentVC.parentViewController && [self.searchBar.currentVC.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
                [(UINavigationController *)self.searchBar.currentVC.parentViewController setNavigationBarHidden:NO animated:YES];
                self.bgView.y = CGRectGetMaxY(self.searchBar.frame) + kSafeAreaNavHeight;
            }
        };
    }
    return _searchBar;
}

- (NJF_SearchResultController *)resultVC{
    if (!_resultVC) {
        _resultVC = [[NJF_SearchResultController alloc] init];
    }
    return _resultVC;
}

- (void)dealloc {
    [self.searchBar removeObserver:self forKeyPath:@"text"];
    NSLog(@"NJF_SeatchController dealloc");
}
@end
