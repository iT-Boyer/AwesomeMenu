//
//  DoraemonHomeWindow.h
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2018/5/16.
//

#import <UIKit/UIKit.h>

@interface AwesomeMenuHomeWindow : UIWindow

@property (nonatomic, strong) UINavigationController *nav;

+ (AwesomeMenuHomeWindow *)shareInstance;

// open plugin vc
+ (void)openPlugin:(UIViewController *)vc;

- (void)show;
- (void)hide;

@end
