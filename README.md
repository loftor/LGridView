# LGridView
实现Grid排版功能

# 引用方式
pod 'LGridView', :git => 'https://github.com/loftor/LGridView.git', :tag => 'v1.0'

# 使用方式
1、修改类名LGridView
2、调用registerClassName（注册类名）/registerNibName（注册xib名）
3、实现LGridViewDataSource下面的代理方法，viewForIndex请使用dequeueReusableView方法获取view
