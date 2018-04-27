//
//  MainController.m
//  全民来吐槽
//
//  Created by Mac on 2018/4/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MainController.h"
#import "HomeController.h"
#import "AddController.h"
#import "MyController.h"

@interface MainController ()
@property (weak, nonatomic) IBOutlet UIView *bottomCenterView;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) HomeController *homeVC;
@property (nonatomic, strong) AddController *addVC;
@property (nonatomic, strong) MyController *myVC;
@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置界面
    [self setView];
    // 添加子控制器
    //[self addChildVC];
    self.homeVC = (HomeController *)[self getVCFromStoryboard:@"homeVC"];
    self.addVC = (AddController *)[self getVCFromStoryboard:@"addVC"];
    self.myVC = (MyController *)[self getVCFromStoryboard:@"userVC"];
    [self.homeVC didMoveToParentViewController:self];
    [self.mainView addSubview:self.homeVC.view];
    self.currentVC = self.homeVC;
    
}
- (void)setView{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    CGPoint center = CGPointMake(CGRectGetWidth(_bottomCenterView.frame)/2.0, CGRectGetHeight(_bottomCenterView.frame)/2.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:35.0 startAngle:-0.3 endAngle:3.45 clockwise:NO];
    _bottomCenterView.layer.shadowColor = [UIColor colorFromHexCode:@"e6e6e6"].CGColor;
    _bottomCenterView.layer.shadowOpacity = 0.5;
    _bottomCenterView.layer.shadowRadius = 0.1;
    //_bottomCenterView.layer.shadowOffset = CGSizeMake(0, 0);
    _bottomCenterView.layer.shadowPath = path.CGPath;
}
- (void)addChildVC{
    
    
}
- (UIViewController *)getVCFromStoryboard:(NSString *)identifier{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    if (![identifier isEqualToString:@"addVC"]) {
        [self addChildViewController:vc];
    }
    return vc;
}
- (IBAction)selectButton:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = YES;
    if (sender.tag == 1) {
        self.userButton.selected = NO;
        [self transitionFromViewController:self.currentVC toViewController:self.homeVC duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
            self.currentVC = self.homeVC;
            self.title = @"首页";
        }];
    }else{
        self.homeButton.selected = NO;
        [self transitionFromViewController:self.currentVC toViewController:self.myVC duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
            self.currentVC = self.myVC;
            self.title = @"我的";
        }];
    }
}
- (IBAction)add:(UIButton *)sender {
    [self presentViewController:self.addVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
