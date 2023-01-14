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
    // Do any additional setup after loading the view.
}

- (IBAction)grayEffectClick:(id)sender {
//    [WJEffectView addGrayEffectViewToView:self.view];
    [WJEffectView addEffectViewToView:self.view tintColor:[UIColor colorWithWhite:0.11 alpha:0.73]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.imageView.hidden = YES;
//    });
}

- (IBAction)blurEffectClick:(id)sender {
//    [WJEffectView addBlurEffectFilterToView:self.view radius:3];
    [WJEffectView addBlurImageViewToView:self.view radius:3];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.imageView.hidden = YES;
//    });
}
- (IBAction)clearEffectClick:(id)sender {
    [WJEffectView clearEffectForView:self.view];
}
@end
