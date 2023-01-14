//
//  WJEffectView.m
//  TexasPoker
//
//  Created by pengweijian on 2022/12/1.
//

#import "WJEffectView.h"
#import "UIImage+ImageEffects.h"

#define PKOverlayViewTag (4096)

static const char FilterChars [] = {67, 65, 70, 105, 108, 116, 101, 114, 0}; // CAFilter 字符串

@implementation WJEffectView
+ (void)addBlurEffectFilterToView:(UIView *)view radius:(CGFloat)radius{
    [self clearEffectForView:view];
    // 方法一
    NSString *str = [NSString stringWithUTF8String:FilterChars];
    id filter = [NSClassFromString(str) filterWithName:@"gaussianBlur"]; //创建滤镜
    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    if (filter) view.layer.filters = [NSArray arrayWithObject:filter];//设置给view
}

+ (UIImageView *)addBlurImageViewToView:(UIView *)view radius:(CGFloat)radius{
    [self clearEffectForView:view];
    // 方法二
    UIImage *image = [self takeSnapshotOfView:view];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:view.bounds];
    imgView.tag = PKOverlayViewTag;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = [image blurredImageWithRadius:radius];
    // 或者下面这种
//    [image asyncBlurWithRadius:radius handler:^(UIImage *blurImg) {
//        imgView.image = blurImg;
//    }];
    [view addSubview:imgView];
    return imgView;
}

+ (UIVisualEffectView *)addSystemBlurEffectToView:(UIView *)view {
    [self clearEffectForView:view];
    // 方法三
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = view.bounds;
    effectView.tag = PKOverlayViewTag;
    [view addSubview:effectView];
    return effectView;
}

+ (void)addGrayEffectFilterToView:(UIView *)view {
    [self addEffectFilterToView:view tintColor:[UIColor lightGrayColor]];
}

+ (WJEffectView *)addGrayEffectViewToView:(UIView *)view {
    return [self addEffectViewToView:view tintColor:[UIColor lightGrayColor]];
}

+ (void)addEffectFilterToView:(UIView *)view tintColor:(UIColor *)tintColor {
    [self clearEffectForView:view];
    // 方法一
    CGFloat r,g,b,a;
    [tintColor getRed:&r green:&g blue:&b alpha:&a];//获取RGBA颜色数值
    NSString *str = [NSString stringWithUTF8String:FilterChars];
    id filter = [NSClassFromString(str) filterWithName:@"colorMonochrome"];//创建滤镜
    // 设置滤镜参数
    [filter setValue:@[@(r),@(g),@(b),@(a)] forKey:@"inputColor"];
    [filter setValue:@(0) forKey:@"inputBias"];
    [filter setValue:@(1) forKey:@"inputAmount"];
    if (filter) view.layer.filters = [NSArray arrayWithObject:filter]; //设置给view
}

+ (WJEffectView *)addEffectViewToView:(UIView *)view tintColor:(UIColor *)tintColor {
    [self clearEffectForView:view];
    // 方法二
    WJEffectView *effectView = [[WJEffectView alloc] initWithFrame:view.bounds];
    effectView.translatesAutoresizingMaskIntoConstraints = false;
    effectView.backgroundColor = tintColor;
    effectView.layer.compositingFilter = @"saturationBlendMode";
    effectView.tag = PKOverlayViewTag;
    [view addSubview:effectView];
    return effectView;
}

+ (UIView *)clearEffectForView:(UIView *)view {
    UIView *effectView = [view viewWithTag:PKOverlayViewTag];
    if (effectView) {
        [effectView removeFromSuperview];
    }else {
        view.layer.filters = nil;
    }
    return effectView;
}

/** 截图功能 */
/// 方法一
+ (UIImage *)takeSnapshotOfView:(UIView *)view {
/** 下面方法，
 第一个参数表示区域大小。
 第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。
 第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
 */
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取 上下文
    if (!context) return nil;
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/// 方法二
+ (UIImage *)takeSnapshot2OfView:(UIView *)view {
    UIImage *image;
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width, view.frame.size.height));
    BOOL hasSnapshotImage = [view drawViewHierarchyInRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) afterScreenUpdates:YES];
    if (hasSnapshotImage) {
        image = UIGraphicsGetImageFromCurrentImageContext();
    }

    UIGraphicsEndImageContext();
    return image;
}
/// 方法三
+ (UIImage *)takeSnapshotOfView:(UIView *)view InRect:(CGRect)rect {
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width, view.frame.size.height));
    [view drawViewHierarchyInRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return nil;
}
@end
