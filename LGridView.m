//
//  LGridView.m
//  Example
//
//  Created by zhanglei on 17/04/2015.
//  Copyright © loftor. All rights reserved.
//

#import "LGridView.h"

@interface LGridView ()

@property (nonatomic, strong) NSString * className;

@property (nonatomic, strong) NSString * nibName;

@property (nonatomic, assign) NSUInteger numberOfLines;

@end

@implementation LGridView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setItemSpace:(CGFloat)itemSpace{
    if (_itemSpace != itemSpace) {
        _itemSpace = itemSpace;
        self.dataSource = _dataSource;
    }
}

- (void)setLineSpace:(CGFloat)lineSpace{
    if (_lineSpace != lineSpace) {
        _lineSpace = _itemSpace;
        self.dataSource = _dataSource;
    }
}

- (void)setItemHeight:(CGFloat)itemHeight{
    if (_itemHeight != itemHeight) {
        _itemHeight = itemHeight;
        self.dataSource = _dataSource;
    }
}

- (void)setLimitOfLines:(NSUInteger)limitOfLines{
    if (_limitOfLines != limitOfLines) {
        _limitOfLines = limitOfLines;
        self.dataSource = _dataSource;
    }
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets)) {
        _edgeInsets = edgeInsets;
        self.dataSource = _dataSource;
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

- (void)initView{
    
    _itemHeight = 20;
    
}

- (void)registerClassName:(NSString *)className{
    
    self.className = className;
    
}

- (void)registerNibName:(NSString *)nibName{
    
    self.nibName = nibName;
    
}

- (UIView *)dequeueReusableView {
    
    if (_className) {
        return [[NSClassFromString(_className) alloc]init];
    }
    
    if (_nibName) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:_nibName owner:nil options:nil];
        return [nibView objectAtIndex:0];
    }
    return nil;
}

- (void)setDataSource:(id<LGridViewDataSource>)dataSource{
    if (dataSource == nil) {
        return;
    }
    
    if (![dataSource respondsToSelector:@selector(numberOfLGridView)] ||
        ![dataSource respondsToSelector:@selector(gridView:viewForIndex:)] ||
        ![dataSource respondsToSelector:@selector(gridView:widthForIndex:)] ) {
        return;
    }
    
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    _dataSource = dataSource;
    
    
    _numbers = [dataSource numberOfLGridView];
    
    CGPoint point = CGPointMake(self.edgeInsets.left, self.edgeInsets.top);
    if (_numbers >0 ) {
        _numberOfLines++;
    }
    
    for (int i=0; i<_numbers; i++) {
        UIView * view = [dataSource gridView:self viewForIndex:i];
        if (view == nil) {
            continue;
        }
        
        CGFloat width = [dataSource gridView:self widthForIndex:i];
        if (point.x+width+self.edgeInsets.right>self.bounds.size.width) {
            _numberOfLines++;
            if (_limitOfLines != 0 && _numberOfLines > _limitOfLines) {
                break;
            }
            point.x = self.edgeInsets.left;
            point.y += _itemHeight + _lineSpace;
            view.frame = CGRectMake(point.x, point.y, width, _itemHeight);
        }
        else{
            view.frame = CGRectMake(point.x, point.y, width, _itemHeight);
            
        }
        
        point.x += _itemSpace+width;
        
        [self addSubview:view];
        
    }
    
    CGSize contentSize = [self contentSize];
    self.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
   
    
}

- (CGSize)contentSize{
    if (_numbers==0) {
        return CGSizeZero;
    }
    else{
        if (_limitOfLines == 0) {
            
            return CGSizeMake(self.bounds.size.width, _numberOfLines * _itemHeight + (_numberOfLines-1)*_lineSpace +self.edgeInsets.top+self.edgeInsets.bottom);
            
        }
        else{
            NSUInteger minLine = MIN(_limitOfLines, _numberOfLines);
            return CGSizeMake(self.bounds.size.width, minLine * _itemHeight + (minLine-1)*_lineSpace +self.edgeInsets.top+self.edgeInsets.bottom);
        }
    }
}

- (CGSize)intrinsicContentSize{
    
    return [self contentSize];
    
}

@end
