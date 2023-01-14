//
//  WJEffectView.h
//  WJEffectView
//
//  Created by pengweijian on 2022/12/1.
//  黑白色效果、高斯模糊效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 承载滤镜，自身不接收、不拦截任何触摸事件
@interface WJEffectView : UIView

/// 实现高斯模糊效果方式一：采用私有类 滤镜生成高斯模糊到View上，具有实时性
/// - Parameters:
///   - view: 高斯模糊的视图
///   - radius: 用于调节模糊度   
+ (void)addBlurEffectFilterToView:(UIView *)view radius:(CGFloat)radius;

/// 实现高斯模糊效果方式二：截取View内容生成高斯模糊图片，添加含刚生成的高斯模糊图片UIImageView到View上
/// - Parameters:
///   - view: 高斯模糊的视图
///   - radius: 用于调节模糊度
+ (UIImageView *)addBlurImageViewToView:(UIView *)view radius:(CGFloat)radius;

/// 实现高斯模糊效果方式三：添加系统的高斯模糊UIVisualEffectView到View上
/// - Parameters:
///   - view: 高斯模糊的视图
+ (UIVisualEffectView *)addSystemBlurEffectToView:(UIView *)view;

/// 黑白色调效果方式一：采用私有类 滤镜方式生成黑白色效果，具有实时性
+ (void)addGrayEffectFilterToView:(UIView *)view;
/// 黑白色调效果方式二：添加WJEffectView生成黑白色效果，具有实时性
+ (WJEffectView *)addGrayEffectViewToView:(UIView *)view;

/// 添加色调效果方式一：采用私有类 滤镜方式生成黑白色效果，具有实时性
/// - Parameters:
///   - view: 高斯模糊的视图
///   - tintColor: 色调
+ (void)addEffectFilterToView:(UIView *)view tintColor:(UIColor *)tintColor;

/// 添加色调效果方式二：添加WJEffectView生成黑白色效果，具有实时性
/// - Parameters:
///   - view: 高斯模糊的视图
///   - tintColor: 色调
+ (WJEffectView *)addEffectViewToView:(UIView *)view tintColor:(UIColor *)tintColor;

/// 清除覆盖在view的效果
+ (UIView *)clearEffectForView:(UIView *)view;
    
/// 截图功能
+ (UIImage *)takeSnapshotOfView:(UIView *)view;
+ (UIImage *)takeSnapshot2OfView:(UIView *)view;
+ (UIImage *)takeSnapshotOfView:(UIView *)view InRect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
