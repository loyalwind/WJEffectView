//
//  ViewController.m
//  WJEffectView
//
//  Created by pengweijian on 2023/1/13.
//

#import "ViewController.h"
#import "WJEffectView.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

- (IBAction)colorEffectClick:(id)sender {
    // 传self.imageView, self.view 覆盖范围不一样
    [WJEffectView addEffectViewToView:self.imageView tintColor:[UIColor colorWithWhite:0.11 alpha:0.73]];
}

- (IBAction)grayEffectClick:(id)sender {
    // 传self.imageView, self.view 覆盖范围不一样
    [WJEffectView addGrayEffectViewToView:self.imageView];
}

- (IBAction)blurEffectClick:(id)sender {
    // 传self.imageView, self.view 覆盖范围不一样
    [WJEffectView addBlurEffectFilterToView:self.imageView radius:3];
    // 或者
//    [WJEffectView addBlurImageViewToView:self.imageView radius:3];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.imageView.hidden = YES;
//    });
}
- (IBAction)clearEffectClick:(id)sender {
    // 传self.imageView, self.view 清除范围不一样
    [WJEffectView clearEffectForView:self.imageView];
}
@end
