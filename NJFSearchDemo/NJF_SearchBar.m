//
//  NJF_SearchBar.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "NJF_SearchBar.h"
#import "NJF_SearchTextField.h"
#import "SearchHeader.h"
#import "UIView+NJF_Extension.h"

@interface NJF_SearchBar()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) NJF_SearchTextField *searchTextField;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation NJF_SearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = NJF_Color(243, 243, 243);
        [self addSubview:self.bgImageView];
        [self addSubview:self.searchTextField];
        [self addSubview:self.rightBtn];
        [self addSubview:self.cancelBtn];
    }
    return self;
}

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    if (_isEditing) {
        [UIView animateWithDuration:0.2 animations:^{
            self.searchTextField.x = 10;
            self.rightBtn.x = kScreenWidth - 38 - 40;
            self.bgImageView.width = kScreenWidth - 20 - 40;
            self.cancelBtn.x = kScreenWidth - 40;
        } completion:^(BOOL finished) {
            self.searchTextField.width = kScreenWidth - 20 - 38 - 40;
        }];
        self.searchTextField.canTouch = YES;
        [self.searchTextField becomeFirstResponder];
    } else {
        self.searchTextField.text = @"";
        self.text = @"";
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.2 animations:^{
            self.searchTextField.x = kScreenWidth * 0.5 - 40;
            self.rightBtn.x = kScreenWidth - 38;
            self.bgImageView.width = kScreenWidth - 20;
            self.cancelBtn.x = kScreenWidth;
        } completion:^(BOOL finished) {
            self.searchTextField.width = kScreenWidth * 0.5 + 20 - 38;
        }];
        self.searchTextField.canTouch = NO;
        [self.searchTextField resignFirstResponder];
    }
}

#pragma mark - target action

- (void)textFieldDidChange{
    if (self.searchTextField.text.length) {
        self.text = self.searchTextField.text;
        [self.rightBtn setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateHighlighted];
    }
}

- (void)rightButtonClick{
    if (self.searchTextField.text) {
        self.searchTextField.text = @"";
        self.text = nil;
        [self.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    }
}

- (void)cancelButtonClick{
    if (self.cancelBlok) self.cancelBlok();
}

#pragma mark - lazy loading

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, kScreenWidth - 20, 44 - 16)];
        UIImage *image = [UIImage imageNamed:@"widget_searchbar_textfield"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        _bgImageView.image = image;
    }
    return _bgImageView;
}

- (NJF_SearchTextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[NJF_SearchTextField alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 40, 0, kScreenWidth * 0.5 + 20 - 38, 44)];
        _searchTextField.canTouch = NO;
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchContactsBarIcon"]];
        searchIcon.contentMode = UIViewContentModeScaleAspectFit;
        searchIcon.frame = CGRectMake(0, 0, 30, 14);
        _searchTextField.leftView = searchIcon;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.font = [UIFont systemFontOfSize:16.0f];
        [_searchTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.placeholder = @"搜索";
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.frame = CGRectMake(kScreenWidth - 38, 8, 28, 28);
    }
    return _rightBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(kScreenWidth, 0, 40, 44);
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setTitle:@"取消  " forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)dealloc {
    NSLog(@"NJF_SearchBar dealloc");
}
@end
