//
//  LGridView.h
//  Example
//
//  Created by zhanglei on 17/04/2015.
//  Copyright © loftor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGridView;

@protocol LGridViewDataSource <NSObject>

@required

- (NSInteger)numberOfLGridView;

- (UIView *)gridView:(LGridView *)gridView viewForIndex:(NSInteger)index;

- (CGFloat)gridView:(LGridView *)gridView widthForIndex:(NSInteger)index;

@end

IB_DESIGNABLE

@interface LGridView : UIView

@property (assign, nonatomic) IBInspectable NSUInteger limitOfLines; // 行数

@property (assign, nonatomic, readonly) IBInspectable NSUInteger numbers; // 个数

@property (assign, nonatomic) UIEdgeInsets edgeInsets; // padding

@property (assign, nonatomic) IBInspectable CGFloat lineSpace; // 行间距

@property (assign, nonatomic) IBInspectable CGFloat itemSpace; // 列间距

@property (assign, nonatomic) IBInspectable CGFloat itemHeight; // 行高

@property (weak, nonatomic) id<LGridViewDataSource> dataSource;

- (void)registerClassName:(nullable NSString *)className;

- (void)registerNibName:(nullable NSString *)nibName;

- (__kindof UIView *)dequeueReusableView;

@end
